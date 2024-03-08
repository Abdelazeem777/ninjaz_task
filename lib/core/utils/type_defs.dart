import 'dart:async';

typedef FutureCallback<T> = FutureOr<T> Function();
typedef FutureCallbackWithData<T, V> = FutureOr<T> Function(V data);
typedef FutureValueChanged<T> = FutureOr<void> Function(T);
