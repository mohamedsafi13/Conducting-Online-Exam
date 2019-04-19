# Conducting-Online-Exam

The list of user who can take the test is stored in database.

The user needs to enter their e-mail id to login and take the test.

The user entered e-mail Id is checked with that present in the database and if a match if found the user is taken to the test page.

The questions, options and the correct answer for that question is in a .csv file.

The “.csv” file is read using csv reader provided by javacsv jar.

The questions are stored in a string array and the four different options for each question are stored in four separate string arrays.

The content of these five arrays are randomized before displaying.

A timer is activated once the user has been logged in using JavaScript.

Buttons are displayed which uses Ajax requests to change the questions(go to next question, go to previous question, or change to a particular question by clicking the button with the required question number).

Once the Submit button is pressed or the timer expires, the test ends and the answers are submitted.

The answers chosen by the user is checked against the correct answer mentioned in the “.csv” file and if the answer chosen by the user for a particular question matches the answer in the “.csv” file, then the user is given one mark for that question and if it does not matches no mark is allotted for that question. The result is stored in database question wise for each user.

After checking for all the questions the question-wise result in database is processed to get the total mark obtained by the user and this total mark is stored along with the e-mail Id of the user in a separate table in the database. 
