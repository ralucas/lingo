# Module dependencies.

express = require 'express'
routes = require './../routes'
user = require './../routes/user'
http = require 'http'
path = require 'path'
BeGlobal = require 'node-beglobal'

app = express()

#initialize the BeGlobal API
beglobal = new BeGlobal.BeglobalAPI({
	api_token: 'uLTwm1AjPmzs3Pl68jxO4g%3D%3D'
	})

#all environments
app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + './../views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, './../public'))

newWord = {}

quizResults = []

#development only
if 'development' == app.get('env')
	app.use express.errorHandler()

app.get '/', routes.index
app.get '/users', user.list

app.get '/translate', (req, res) ->
	res.render 'translate'

app.post '/translate', (req, res) ->
	newWord = req.body
	console.log newWord

	beglobal.translations.translate(
		newWord,
		(err, results) ->
			if err
				return console.log err
			else
				res.send results
		)

app.get '/quiz', (req, res) ->
	res.render 'quiz'

app.get '/lang', (req, res) ->
	beglobal.languages.all( (err, results) -> 
		if err
			return console.log err
		else
			res.send results
			)

app.post '/displayQuiz', (req, res) ->
	quizWords = req.body

	for quizWord in quizWords['objArr']
		console.log(quizWord)
		beglobal.translations.translate(
			quizWord,
			(err, results) ->
				if err then console.log err else
					quizResults.push(results)
					console.log quizResults
					return
			)
	res.send {newObj : quizResults}
	return

http.createServer(app).listen(app.get('port'), () ->
	console.log 'Express server listening on port ' + app.get('port'))