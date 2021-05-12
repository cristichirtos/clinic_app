# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.create(username: 'doctor', name: 'Doctor', password: 'password', password_confirmation: 'password')
Secretary.create(username: 'secretary', name: 'Secretary', password: 'password', password_confirmation: 'password')
Admin.create(username: 'admin', name: 'Admin', password: 'password', password_confirmation: 'password')
Patient.create(name: 'Patient', id_card_number: 'CJ112458', personal_numerical_code: 1991126125448, date_of_birth: '1999-11-26', address: 'Everywhere')
