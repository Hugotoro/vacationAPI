require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { described_class.new }

  # Prueba para validar la presencia del nombre
  it 'is not valid without a name' do
    subject.email = 'test@example.com'
    expect(subject).to_not be_valid
    expect(subject.errors[:name]).to include("can't be blank")
  end

  # Prueba para validar la presencia del email
  it 'is not valid without an email' do
    subject.name = 'Test Name'
    expect(subject).to_not be_valid
    expect(subject.errors[:email]).to include("can't be blank")
  end

  # Prueba para validar el formato del email
  it 'is valid with a valid email format' do
    subject.name = 'Test Name'
    subject.email = 'valid@example.com'
    expect(subject).to be_valid
  end

  it 'is not valid with an invalid email format' do
    subject.name = 'Test Name'
    subject.email = 'invalid-email'
    expect(subject).to_not be_valid
    expect(subject.errors[:email]).to include("is invalid")
  end
end