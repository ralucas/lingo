words = [
	'hello',
	'goodbye'
	'watch'
	'phone'
	'computer'
	'taxi'
	'hotel'
	'country'
	'help'
	'lost'
	'cost'
	'go'
]

selectedQuiz = String

quizWords = {}

quizzo = []

createWordsObj = (arr) ->
	quizzo.length = 0
	for i in arr
		quizWords = {
			"text" : i,
			"from" : "eng",
			"to" : selectedQuiz
		}
		quizzo.push(quizWords)
	return quizzo

correctAns = (answer, value) ->
	if answer is value then '✓' else ('✘'+'  '+answer)

$ () ->

	#for word-to-word translation
	$('#word-form').on 'submit', (event) ->
		event.preventDefault()
		$('#trans-word').empty()
		word = $(@).find('#word').val()
		langFrom = $(@).closest('#main').find('#selectFrom option:selected')
			.attr('data-lang')
		langTo = $(@).closest('#main').find('#selectTo option:selected')
			.attr('data-lang')

		wordObj = {
			text : word,
			from : langFrom,
			to : langTo
		}

		$.post '/translate', wordObj, (data) ->
			$('#trans-word').append('<h3>Translated:</h3>'+
				'<p class="lead">'+data.translation+
				'</p>')

			return
		return

	#creating the language option box for selection on quiz
	$.get '/lang', (results) ->
		for i in results
			if i['to']['code'] isnt 'eng' then $('#selectQuiz')
			.append('<option data-lang='+i['to']['code']+'>'+
				i['to']['fullName']+'</option>')
		return

	#selecting and creating the quiz
	$('#selectQuiz').on 'change', () ->
		selectedQuiz = $('#selectQuiz option:selected').attr('data-lang')
		quizArr = createWordsObj(words)
		$('#quiz').empty()
		$('#quiz').append '<h2>Please wait while your quiz is loading</h2>'

		#posts array for translation and receives translated words for quiz
		$.post '/displayQuiz',{ objArr : quizArr } , (data) ->
			$('#quiz').empty()
			for i in data
				$('#quiz').append('<li class="list-group-item">'+i['translation']+
					'<input class="answer-input" type="text" placeholder="Enter Answer"></li>')

			#pushes english word to data attribute for later checking
			$('#quiz li').each (j) ->
				$(@).attr('data-eng', quizArr[j]['text'])
				return
			return
		return

	$('#quiz').on 'blur', '.answer-input', (e) ->
		value = $(@).val().toLowerCase()
		answer = $(@).parent().attr('data-eng')
		response = correctAns(answer, value)
		$(@).attr('disabled', 'disabled')
		$(@).parent().append('<span class=response>'+response+'</span>')
		if response is '✓' then $(@).next().css('color','green')
		else $(@).next().css('color', 'red')
		return

	return