main() {
  final _socket = Socket();
  final eventHandlerA = (data) => print('A');
  final eventHandlerB = (data) => print('B');
  final eventHandlerC = (data) => print('C');

  _socket.on('event_a', eventHandlerA);
  print(_socket._events);
  _socket.on('event_a', eventHandlerB);
  _socket.on('event_a', eventHandlerC);
  print(_socket._events);

  // Remove eventHandlerA
  _socket.off('event_a', eventHandlerA);
  print(_socket._events);

  // Remove all handlers
  _socket.off('event_a');
  print(_socket._events);
}

typedef dynamic EventHandler<T>(T data);

class Socket {
  final Map<String, List<EventHandler>> _events = {};

  void on(String event, EventHandler handler) {
    _events.putIfAbsent(event, () => <EventHandler>[]);
    _events[event]!.add(handler);
  }

  void off(String event, [EventHandler? handler]) {
    if (handler != null) {
      _events[event]?.remove(handler);
      if (_events[event]?.isEmpty == true) {
        _events.remove(event);
      }
    } else {
      _events.remove(event);
    }
  }
}
