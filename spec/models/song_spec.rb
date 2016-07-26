require 'rails_helper'

RSpec.describe Song, type: :model do
	subject { Song }

	describe '.text_search(query)' do
		let(:song) { create(:song) }

		context 'when query string is nil' do
			it 'returns all songs' do
				expect(subject.text_search(nil)).to eq([song])
			end
		end

		it 'Searches for songs using given query string' do
			expect(subject.text_search('Sacrifice')).to include(song)
		end

		it 'is case insenstive' do
			expect(subject.text_search('SACRIFICE')).to include(song)
		end

		it 'finds songs by album name' do
			expect(subject.text_search('Elton')).to include(song)
		end

		it 'finds songs by artist name' do
			expect(subject.text_search('Elton John')).to include(song)
		end

		it 'finds songs by artist name song title combination' do
			expect(subject.text_search('Elton Sacrifice')).to include(song)
		end

		it 'finds songs by artist name album title combination' do
			expect(subject.text_search('Elton elton')).to include(song)
		end

		it 'finds songs by song name artist name album title combination' do
			expect(subject.text_search('SACRIFICE Elton elton')).to include(song)
		end
	end
end
