-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.login"
MainDialog.AssetName = "MainDialog"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._scene1 = self:GetChild("scene1")
  self._scenemap = self:GetChild("scenemap")
  self._baseScene = self:GetChild("BaseScene")
  self._w1Scene = self:GetChild("W1Scene")
  ;
  (self._scene1):Subscribe_PointerClickEvent(self.OnScene1Clicked, self)
  ;
  (self._scenemap):Subscribe_PointerClickEvent(self.OnSceneMapClicked, self)
  ;
  (self._baseScene):Subscribe_PointerClickEvent(self.OnBaseSceneClicked, self)
  ;
  (self._w1Scene):Subscribe_PointerClickEvent(self.OnW1SceneClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(1)
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
end

MainDialog.OnScene1Clicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LogInfo("MainDialog", "跳转初章场景")
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centerdungeon")
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 30002
  csend.lineupId = 1
  LogInfoFormat("MainDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

MainDialog.OnSceneMapClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LogInfo("MainDialog", "跳转探索场景")
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centerdungeon")
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 11000
  csend.lineupId = 1
  LogInfoFormat("MainDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

MainDialog.OnBaseSceneClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LogInfo("MainDialog", "跳转主城场景")
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
  csend:Send()
end

MainDialog.OnW1SceneClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LogInfo("MainDialog", "跳转魔法森林")
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centerdungeon")
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 30003
  csend.lineupId = 1
  LogInfoFormat("MainDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

return MainDialog

