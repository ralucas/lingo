Objective
==========
Create a web app that helps people learn a new language, utilizing a dynamic quiz system that allows the user to practice and test their understanding.

Resources
----------
* BeGlobal API
* node-beglobal npm module
* Passport
* Requirements

Part I
-------
Your app should consist of three main sections: Translate, Quiz, and Progress.

Translate
---------
When the user goes to the Translate page, they are presented with a form with the following fields:
* Language of word to translate
* Language to translate it into
* Word to translate
* When they hit enter or the submit button, their word should be submitted to the server for translation.
* The server should translate the submitted word using the node-beglobal npm module. You will have to sign up for the BeGlobal API to receive a sandbox API key which will allow them to authenticate your requests.
* The user is shown the translation, or a friendly message if a translation couldn't be find.

Quiz
-----
* When the user goes to the Quiz page, they should first be asked what language they would like to study.
* The quiz should consist of 10 translations.
* If the user gets 3 questions incorrect, they fail the quiz and must start over.
* This user should be shown a word and given a form to type in the translation. You will need to store a list of words that are used for the quiz (or use a Random Word API).
* When they hit enter or the submit button, their answer should be submitted to the server for verification.
* The server should check if the submitted answer is correct using the node-beglobal npm module.
* If the user gets the answer incorrect, they should be shown the correct answer.
* If the user gets the answer correct, they should be shown a success message.
* After the user sees whether they were correct or incorrect, they should be prompted with the next word to translate.
* If the user's answer is off by just a single character, it should count as correct and they get a warning message that points out their typo.
* If the user misses an accent, it should count as correct and they should get a warning message that reminds them to be careful about accents.
After completing 3 quizzes (successfully or unsuccessfully) allow the user to take the following different types of quizzes:
1. Random - Default quiz type.
2. Hardest - The 10 words they have gotten wrong the most.
3. Least Practiced - The 10 words they have practiced the least.
Most Recent - The most recent 10 words they were tested on.

Progress
--------
All of the results from the user's quizzes should be saved to a Mongo database. Allow the user to view their overall results on the Progress page. Include the following pieces of information:
* Total number of quizzes taken
* Number of quizzes passed
* Number of quizzes failed
* % quizzes passed
* Total number of words translated
* Number of words correctly translated
* Number of words incorrectly translated
* % words translated correctly
* Best 10 words
* Worst 10 words
* Allow the user to reset all their data.

Part II
========
Convert the application into a multi-user environment. This requires adding authentication and changing how you are storing information in the database.

* Use Passport to handle user authentication.
* Add a registation page or allow the user to login with Facebook (see Passport documentation).
* Add a login page.
* Adjust the database code to save quizzes and progress for each user separately.
* Add a section to the Progress page that compares the user's overall translation accuracy with all other users.
