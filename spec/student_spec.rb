require_relative '../student'
require 'rspec'

describe Student do
    before :each do
        classroom1 = double(:students => [])
        allow(classroom1).to receive(:label) { 'Math_class'}
        @student = Student.new(classroom1, 14, "Bob")
    end
    
    it "creates a student" do
        expect(@student.name).to eq "Bob"
        expect(@student.classroom.label).to eq "Math_class"
    end
    
    it "can use service" do
        expect(@student.can_use_services?).to eq true
    end

    it "play hooky displays a string" do
        expect(@student.play_hooky).to eq '¯(ツ)/¯'
    end

end