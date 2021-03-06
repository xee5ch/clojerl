-module('clojerl.IReduce').

-clojure(true).
-protocol(true).

-export([reduce/2, reduce/3]).

-type type() :: any().

-callback reduce(type(), any()) -> any().
-callback reduce(type(), any(), any()) -> any().

-spec reduce(type(), any()) -> any().
reduce(Coll, Fun) ->
  clj_protocol:resolve(?MODULE, reduce, Coll, Fun).

-spec reduce(type(), any(), any()) -> any().
reduce(Coll, Fun, Val) ->
  clj_protocol:resolve(?MODULE, reduce, Coll, Fun, Val).
