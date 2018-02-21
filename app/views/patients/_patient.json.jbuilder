json.extract! patient, :id, :name, :age, :dob, :address, :phone, :symptom, :created_at, :updated_at
json.url patient_url(patient, format: :json)
