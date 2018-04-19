# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Clinic.delete_all
Clinic.create(name: 'Hanover Medical Center', specialisation: 'Dermatology', location: '5 Lazer Ln, Grand Canal Dock, Dublin 2', image: 'clinic.jpg', description: 'Monday-Thursday(8:00am-7:00pm) Friday(8:00am-3:00pm) Saturday-Sunday(Closed)')
Clinic.create(name: 'Baggot Street Medical', specialisation: 'Pediatrics', location: '10 Baggot Street Upper, Dublin 4', image: 'clinic.jpg', description: 'Monday-Thursday(7:00am-7:00pm) Friday(7:00am-3:00pm) Saturday(10:00am-1:00pm) Sunday(Closed)')
Clinic.create(name: 'Dame Street Medical Centre', specialisation: 'Psychiatry', location: '16 Dame St, Dublin 2', image: 'clinic.jpg', description: 'Monday-Friday(9:30am-6:30pm) Saturday(11:00am-5:00pm) Sunday(12:00pm-4:00pm)')
Clinic.create(name: 'Travel Health Clinic', specialisation: 'Vaccinations', location: '7 Dawson Street (2nd floor), Dublin 2', image: 'clinic.jpg', description: 'Monday,Thursday(9:00am-8:00pm) Tuesday,Wednesday,Friday(8:00am-5:00pm) Saturday(9:30am-1:30pm) Sunday(Closed)')
Clinic.create(name: 'Fairview Medical Centre', specialisation: 'Obstetrics and Gynacology', location: '37 - 39 Fairview Strand, Dublin 3', image: 'clinic.jpg', description: 'Monday-Friday(8:00am-6:00pm) Saturday(8:00am-10:30am) Sunday(Closed)')
Clinic.create(name: 'Barrow Medical, Centric Health', specialisation: 'Cryotherapy', location: 'Unit 2E, Gasworks House, Barrow St, Dublin 4', image: 'clinic.jpg', description: 'Monday-Friday(8:00am-5:00pm) Saturday-Sunday(Closed)')
Clinic.create(name: 'CliftonCourt Medical, Centric Health', specialisation: 'Otolaryngology', location: 'Clifton Court, Fitzwilliam Street Lower, Dublin 2', image: 'clinic.jpg', description: 'Monday-Wednesday(8:00am-7:00pm) Thursday-Friday(8:00am-5:00pm) Saturday-Sunday(Closed)')
Clinic.create(name: 'Aungier Street Clinic', specialisation: 'Radiology-Diagnostic', location: '16 Redmond Hill, Aungier St, Dublin 2', image: 'clinic.jpg', description: 'Monday-Friday(8:30am-6:00pm) Saturday-Sunday(Closed)')
Clinic.create(name: 'Ballsbridge Medical Centre', specialisation: 'Anesthesiology', location: '66 Merrion Rd, Dublin 4', image: 'clinic.jpg', description: 'Monday-Friday(8:00am-5:00pm) Saturday-Sunday(Closed)')
Clinic.create(name: 'Camden Medical Doctors Dublin', specialisation: 'Family Medicine', location: 'GP Doctor Meath Primary Care Centre, Heytesbury St, Dublin 8', image: 'clinic.jpg', description: 'Monday-Friday(8:30am-5:00pm) Saturday-Sunday(Closed)')