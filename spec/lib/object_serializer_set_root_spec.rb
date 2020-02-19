require 'spec_helper'

describe FastJsonapi::ObjectSerializer do
  include_context 'movie class'

  describe "#set_root" do
    let(:params) { {} }
    subject(:serializable_hash) do
      MovieSerializer.new(resource, { params: params }).serializable_hash
    end

    context 'with default' do
      let(:resource) { movie }

      before do
        MovieSerializer.set_root nil
      end

      it 'uses root of :data' do
        expect(serializable_hash[:data][:id].to_i).to eq(movie.id)
      end
    end

    context 'with custom' do
      let(:resource) { movie }

      before do
        MovieSerializer.set_root :testing
      end

      after do
        MovieSerializer.set_root nil
      end

      it 'uses root of :testing' do
        expect(serializable_hash[:testing][:id].to_i).to eq(movie.id)
      end
    end
  end
end
