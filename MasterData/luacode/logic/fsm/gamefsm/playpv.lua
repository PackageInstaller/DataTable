-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/playpv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local True = 1
local False = 0
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "PlayPV Enter")
  GlobalGameFSM:SetBoolean("toPalyPV", false)
  GlobalGameFSM:SetString("toLogin", "Init")
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "PlayPV Exit")
end

return State

