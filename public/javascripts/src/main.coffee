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
	return