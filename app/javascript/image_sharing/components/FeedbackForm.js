import React, { Component } from 'react';

class FeedbackForm extends Component {
  constructor(props) {
    super(props);
    this.state = { feedback: '' };
  }

  handleChange = (event) => {
    this.setState({ feedback: event.target.value });
  }

  render() {
    const center = {
      textAlign: 'center'
    };

    return (
      <div style={center}>
        <form action="" onSubmit={this.handleSubmit}>
          <div>
            <h1>Your feedbacks:</h1>
          </div>
          <div>
            <textarea
              type="text"
              value={this.state.feedback}
              onChange={this.handleChange}
              rows={20}
              cols={100}
            />
          </div>
          <div> <input type="submit" value="Submit" /> </div>
        </form>
      </div>
    );
  }
}

export default FeedbackForm;
