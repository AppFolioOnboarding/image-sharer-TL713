/* eslint-env mocha */

import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import App from '../components/App';
import Footer from '../components/Footer';
import Header from '../components/Header';
import FeedbackForm from '../components/FeedbackForm';

describe('<App />', () => {
  it('should render <Footer />', () => {
    const stores = {
      feedbackStore: {}
    };

    const wrapper = shallow(<App.wrappedComponent stores={stores} />);
    expect(wrapper.find(Header)).to.have.length(1);
    expect(wrapper.find(Header).prop('title')).to.be.equal('Tell us what you think');
    expect(wrapper.find(FeedbackForm)).to.have.length(1);
    expect(wrapper.find(Footer)).to.have.length(1);
    expect(wrapper.find(Footer).prop('footer')).to.be.equal('Copyright: Appfolio Inc. Onboarding');
  });
});
