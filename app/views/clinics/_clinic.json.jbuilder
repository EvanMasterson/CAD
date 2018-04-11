json.extract! clinic, :id, :name, :location, :specialisations, :description, :created_at, :updated_at
json.url clinic_url(clinic, format: :json)
