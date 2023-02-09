require 'rspec'
require_relative '../association'
require_relative '../person'


describe Person do
  before :each do
    @person = Person.new('Abel', 27, true)
  end

  it 'initializes the person correctly' do
    expect(@person.name).to eq 'Abel'
    expect(@person.age).to eq 27
    expect(@person.parent_permission).to eq true
  end

  it 'can use service' do
    expect(@person.can_use_services?).to eq true
  end

  it 'returns correct name' do
    expect(@person.correct_name).to eq 'Abel'
  end
end

describe do
  before :each do
    @person = Person.new('yonas_is_the_best_coder_ever', 25, true)
    @base_decorator = BaseDecorator.new(@person)
    @capital_decorator = CapitalizeDecorator.new(@person)
    @trimmer_decorator = TrimmerDecorator.new(@person)
  end


  it 'Test #correct_name for BaseDecorator' do
    expect(@base_decorator.correct_name).to eq 'yonas_is_the_best_coder_ever'
  end

  it 'is inherited' do
    expect(CapitalizeDecorator < BaseDecorator).to eq true
    expect(@capital_decorator.correct_name).to eq 'Yonas_is_the_best_coder_ever'
  end

  it 'is not inherited' do
    expect(TrimmerDecorator < BaseDecorator).to eq true
    expect(@trimmer_decorator.correct_name).to eq 'yonas_is_t'
  end
end
