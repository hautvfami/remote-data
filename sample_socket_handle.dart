/// hautv.fami
main() {
  final _socket = Socket();
  final _eventHandler0 = (data) => print('A');
  final _eventHandler1 = (data) => print('B');
  final _eventHandler2 = (data) => print('C');

  _socket.on('event_a', _eventHandler0);
  print(_socket.events);
  _socket.on('event_a', _eventHandler1);
  _socket.on('event_a', _eventHandler2);
  print(_socket.events);

  // Remove eventHandlerA
  _socket.off('event_a', _eventHandler0);
  print(_socket.events);

  // Remove all handlers
  _socket.off('event_a');
  print(_socket.events);
}

typedef dynamic EventHandler<T>(T data);

class Socket {
  final Map<String, List<EventHandler>> events = {};

  void on(String event, EventHandler handler) {
    events.putIfAbsent(event, () => <EventHandler>[]);
    events[event]!.add(handler);
  }

  void off(String event, [EventHandler? handler]) {
    if (handler != null) {
      events[event]?.remove(handler);
      if (events[event]?.isEmpty == true) {
        events.remove(event);
      }
    } else {
      events.remove(event);
    }
  }
}
