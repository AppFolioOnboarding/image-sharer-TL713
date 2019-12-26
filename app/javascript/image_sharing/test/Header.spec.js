/* eslint-env mocha */

import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import Header from '../components/Header';

describe('<Header />', () => {
  it('should display text correctly', () => {
    const wrapper = shallow(<Header title="123" />);
    const header = wrapper.find('.js-title');

    expect(header).to.have.length(1);
    expect(header.text()).to.equal('123');
  });
});
