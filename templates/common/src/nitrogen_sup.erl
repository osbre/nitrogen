%% -*- mode: nitrogen -*-
%% vim: ts=4 sw=4 et
-module({{name}}_sup).
-behaviour(supervisor).
-export([
    start_link/0,
    init/1
]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    application:ensure_all_started(nitrogen_core),
    application:ensure_all_started(nitro_cache),
    application:ensure_all_started(crypto),
    application:ensure_all_started(nprocreg),
    application:ensure_all_started(simple_bridge),

    %% Add global handlers here like this
    %% wf:global_handler(Module, Config),
    %% or
    %% wf:global_handler(Name, Module, Config),

    {ok, { {one_for_one, 5, 10}, []} }.
