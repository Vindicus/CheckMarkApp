CheckMarkApp
============

*Update: 3/14/2017*: Twilio API is not working for this application as it was a trial version of Twilio was used.

This project is a simple appointment reminder app. This allows users to create their own appointments and be reminded via phone calls, text messages, or emails.
Users can also invite friends that have a CheckMark account to the appointment. They can be reminded of the invitation via email.

The hardest parts were getting the modeling relationships correct and using Twilio API:

1) Before the beginning of the project, I had to create a modeling relationship like users, appointments, invitations, and reminders
2) I would create one to many relationships amongst them and fill in the appropriate fields
3) The other hard part was using the Twilio API, I had to read through the documentation to understand how to use it
4) I also had to use a background process to send out reminders via a gem called Sidekiq and Sendgrid
5) The last hardest part was creating rspec tests. Testing was very difficult for me, I know "what" to test but it is hard to know "how" to test
6) Although testing is something I lack but I am currently developing a way to overcome this obstacle

The most interesting parts were setting up actionmailer with Sendgrid, Devise and creating form fields to work with the database

1) I added an addon called Sendgrid so it will allow the app to send email reminders
2) I also added an authentication gem called Devise which was easy and fun to work with by simply customizing flash messages, fields, and validations
3) The next fun part was creating forms to add params to the designated models
4) The next part was adding nested associated forms where one form works with two or more models amongst appointments, invitations, and reminders

Access <a href="http://checkmark-vindicus.herokuapp.com/"> CheckMark</a>
