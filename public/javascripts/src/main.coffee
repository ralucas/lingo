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
	'alone'
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

$ () ->

	$('#word-form').on 'submit', (event) ->
		event.preventDefault()
		word = $(this).find('#word').val()
		langFrom = $(this).closest('#main').find('#selectFrom option:selected')
			.attr('data-lang')
		langTo = $(this).closest('#main').find('#selectTo option:selected')
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

	$.get '/lang', (results) ->
		for i in results
			if i['to']['code'] isnt 'eng' then $('#selectQuiz')
			.append('<option data-lang='+i['to']['code']+'>'+
				i['to']['fullName']+'</option>')
		return

	$('#selectQuiz').on 'change', () ->
		selectedQuiz = $('#selectQuiz option:selected').attr('data-lang')
		quizArr = createWordsObj(words)
		console.log(quizArr)
		$.post '/displayQuiz',{ objArr : quizArr } , (data) ->
			console.log data
			return
		return

	return