require 'spec_helper'
require "rails_helper"

describe TrendingCampaign do
  include TrendingCampaign

  describe 'TrendingCampaign.all' do
    subject { TrendingCampaign.all }

    it 'should not be empty' do
      expect(subject).to be_present
    end

    it 'should return an array of hashes' do
      expect(subject.class).to eq Array
      expect(subject.sample.class).to eq Hash
    end

    it 'should return all 500 campaigns' do
      expect(subject.count).to eq 100
    end

    it 'should only contain necessary information' do
      expect(subject.sample.keys).to match_array ['title', 'baseball_card_image_url', 'tagline', 'web_url']
    end
  end

  describe 'TrendingCampaign.search' do
    before do
      allow(TrendingCampaign).to receive(:all).and_return(
        [
            {
              "title"=>"Hy - Concealed Smart Earbuds",
              "baseball_card_image_url"=>"fake_url",
              "tagline"=>"Hybrid air and bone-conduction wireless earphones for all day wear, music, calls and much more.",
              'web_url'=>'fake_url'
            },
            {
              "title"=>"Ping - The World’s Smallest Global GPS Locator",
              "baseball_card_image_url"=>"https://c1.iggcdn.com/indiegogo-media-prod-cld/image/upload/c_fill,f_auto,h_220,w_220/v1484008221/pheztr41itcjduf1int9.jpg",
              "tagline"=>"Global range, long battery life & instant locating for kids, pets, luggage – or anything that moves.",
              'web_url'=>'fake_url'
            },
            {
              "title"=>"Uuni Pro. The quad-fuelled outdoor oven",
              "baseball_card_image_url"=>"fake_url",
              "tagline"=>"The world's best outdoor oven capable of burning wood, wood pellets, charcoal or gas",
              'web_url'=>'fake_url'
            },
            {
              "title"=>"Josh McClain's 2nd Studio Album",
              "baseball_card_image_url"=>"fake_url",
              "tagline"=>"Avant garde cello-rock album explores an intense journey through light, shadows, and rebirth.",
              'web_url'=>'fake_url'
            },
            {
              "title"=>"One Note Stand Goes to BOSS 2017!",
              "baseball_card_image_url"=>"fake_url",
              "tagline"=>"The University of Texas's competitive co-ed a cappella group, One Note Stand, is attending world BOSS!",
              'web_url'=>'fake_url'
            }
        ]
      )

    end

    describe 'no parameter passed in' do
      it 'should throw an error' do
        expect { TrendingCampaign.search }.to raise_error(ArgumentError)
      end
    end

    describe 'with search param' do
      describe 'empty search string' do
        it 'shoulud return all campaigns' do
          expect( TrendingCampaign.search('').count ).to eq 5
        end
      end

      describe 'non-existing search keyword' do
        subject{ TrendingCampaign.search('&^%$#') }

        it 'should not return nil' do
          expect(subject).to_not be_nil
        end

        it 'should not return an empty array' do
          expect(subject.class).to eq Array
          expect(subject).to be_empty
        end
      end

      describe 'existing search keyword' do
        let(:expected_campaigns) {
          expected_campaigns = [
            {
              "title"=>"Ping - The World’s Smallest Global GPS Locator",
              "baseball_card_image_url"=>"https://c1.iggcdn.com/indiegogo-media-prod-cld/image/upload/c_fill,f_auto,h_220,w_220/v1484008221/pheztr41itcjduf1int9.jpg",
              "tagline"=>"Global range, long battery life & instant locating for kids, pets, luggage – or anything that moves.",
              'web_url'=>'fake_url'
            },
            {
              "title"=>"Uuni Pro. The quad-fuelled outdoor oven",
              "baseball_card_image_url"=>"fake_url",
              "tagline"=>"The world's best outdoor oven capable of burning wood, wood pellets, charcoal or gas",
              'web_url'=>'fake_url'
            },
            {
              "title"=>"One Note Stand Goes to BOSS 2017!",
              "baseball_card_image_url"=>"fake_url",
              "tagline"=>"The University of Texas's competitive co-ed a cappella group, One Note Stand, is attending world BOSS!",
              'web_url'=>'fake_url'
            }
          ]
        }
        it 'should return matching campaigns' do
          campaigns = TrendingCampaign.search('world')
          expect( campaigns.count ).to eq 3
          expect( campaigns ).to match_array(expected_campaigns)
        end

        it 'should be case-insensitive' do
          campaigns = TrendingCampaign.search('wOrlD')
          expect( campaigns ).to match_array(expected_campaigns)
          expect( campaigns ).to match_array(TrendingCampaign.search('world'))
        end
      end
    end
  end
end
