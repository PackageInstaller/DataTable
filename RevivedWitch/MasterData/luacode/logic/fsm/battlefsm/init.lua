-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/init.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("BattleFSM", "Init Enter")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("chat.chatmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("debug.gmorderdialog")
  ;
  (DialogManager.DestroySingletonDialog)("character.newcharacterinfodialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonskillbanner")
  ;
  (DialogManager.DestroySingletonDialog)("systemsetting.systemsettingdialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonconquestdialog")
  ;
  (DialogManager.DestroySingletonDialog)("confirmbox.secondconfirmdialog")
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleFSM", "Init Exit")
end

return State

