require 'spec_helper'
require "rails_helper"

describe SearchController do
  describe 'GET #index' do
    subject { get :index }

    it 'responds successfully with 200 status code' do
      expect(subject).to be_success
      expect(subject).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(subject).to render_template('index')
    end

    describe 'with no param' do
      before do
        allow(TrendingCampaign).to receive(:all).and_return( [ {foo: 'bar', bar: 'foo'}] )
      end

      it 'loads all of the trending campaigns into @result' do
        subject
        expect(assigns(:result)).to match_array([ {foo: 'bar', bar: 'foo'}])
      end
    end

    describe 'with search param' do
      subject { get :index, search: 'indiegogo' }
      before do
        allow(TrendingCampaign).to receive(:search).and_return( [ {foo: 'bar', bar: 'foo'}] )
      end

      it 'loads search trending campaigns into @result' do
        subject
        expect(assigns(:result)).to match_array([ {foo: 'bar', bar: 'foo'}])
      end
    end
  end
end
