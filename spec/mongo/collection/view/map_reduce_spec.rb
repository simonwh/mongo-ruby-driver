require 'spec_helper'

describe Mongo::Collection::View::MapReduce do

  let(:map) do
  %Q{
  function() {
    emit(this.name, { population: this.population });
  }}
  end

  let(:reduce) do
    %Q{
    function(key, values) {
      var result = { population: 0 };
      values.forEach(function(value) {
        result.population += value.population;
      });
      return result;
    }}
  end

  let(:documents) do
    [
      { name: 'Berlin', population: 3000000 },
      { name: 'London', population: 9000000 }
    ]
  end

  let(:selector) do
    {}
  end

  let(:view_options) do
    {}
  end

  let(:view) do
    Mongo::Collection::View.new(authorized_collection, selector, view_options)
  end

  let(:options) do
    {}
  end

  before do
    authorized_collection.insert_many(documents)
  end

  after do
    authorized_collection.find.remove_many
  end

  let(:map_reduce) do
    described_class.new(view, map, reduce, options)
  end

  describe '#each' do

    context 'when no options are provided' do

      it 'iterates over the documents in the result' do
        map_reduce.each do |document|
          expect(document[:value]).to_not be_nil
        end
      end
    end

    context 'when out is inline' do

    end

    context 'when out is a collection' do

      context 'when the option is to replace' do

      end

      context 'when the option is to merge' do

      end

      context 'when the option is to reduce' do

      end
    end

    context 'when the view has a selector' do

    end

    context 'when the view has a limit' do

    end

    context 'when the view has a sort' do

    end
  end

  describe '#finalize' do

    let(:finalize) do
    %Q{
    function(key, value) {
      value.testing = test;
      return value;
    }}
    end

    let(:new_map_reduce) do
      map_reduce.finalize(finalize)
    end

    it 'sets the finalize function' do
      expect(new_map_reduce.finalize).to eq(finalize)
    end
  end

  describe '#js_mode' do

    let(:new_map_reduce) do
      map_reduce.js_mode(true)
    end

    it 'sets the js mode value' do
      expect(new_map_reduce.js_mode).to be true
    end
  end

  describe '#out' do

    let(:location) do
      { replace: 'testing' }
    end

    let(:new_map_reduce) do
      map_reduce.out(location)
    end

    it 'sets the out value' do
      expect(new_map_reduce.out).to eq(location)
    end
  end

  describe '#scope' do

    let(:object) do
      { value: 'testing' }
    end

    let(:new_map_reduce) do
      map_reduce.scope(object)
    end

    it 'sets the scope object' do
      expect(new_map_reduce.scope).to eq(object)
    end
  end
end