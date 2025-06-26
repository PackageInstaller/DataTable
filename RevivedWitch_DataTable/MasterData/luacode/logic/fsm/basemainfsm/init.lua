-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/init.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaManager = (CS.PixelNeko).LuaManager
local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local UIBackManager = ((CS.PixelNeko).P1).UIBackManager
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("BaseMainFSM", "Init Enter")
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BaseMainFSM", "Init Exit")
end

return State

