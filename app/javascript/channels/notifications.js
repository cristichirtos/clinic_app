import consumer from './consumer'

consumer.subscriptions.create({ channel: 'NotificationsChannel' }, {
  received(data) {
    console.log('primit');
    $("#notifications").removeClass('hidden')
    return $('#notifications').append(this.renderMessage(data));
  },
  renderMessage(data) {
    console.log(data.content)
    return "<p> <b>" + data.sender + ": </b>" + data.content + "</p>";
  }
});
