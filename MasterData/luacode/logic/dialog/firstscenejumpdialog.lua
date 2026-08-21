-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/firstscenejumpdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FirstSceneJumpDialog = class("FirstSceneJumpDialog", Dialog)
FirstSceneJumpDialog.AssetBundleName = "ui/layouts.login"
FirstSceneJumpDialog.AssetName = "FastLogin"
FirstSceneJumpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FirstSceneJumpDialog
  ((FirstSceneJumpDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

FirstSceneJumpDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._scenemap = self:GetChild("scenemap")
  self._baseScene = self:GetChild("BaseScene")
  self._w1Scene = self:GetChild("W1Scene")
  ;
  (self._scenemap):SetActive(((NekoData.BehaviorManager).BM_Game):IsGM())
  ;
  (self._baseScene):SetActive(((NekoData.BehaviorManager).BM_Game):IsGM())
  ;
  (self._w1Scene):SetActive(((NekoData.BehaviorManager).BM_Game):IsGM())
  ;
  (self._scenemap):Subscribe_PointerClickEvent(self.OnSceneMapClicked, self)
  ;
  (self._baseScene):Subscribe_PointerClickEvent(self.OnBaseSceneClicked, self)
  ;
  (self._w1Scene):Subscribe_PointerClickEvent(self.OnW1SceneClicked, self)
end

FirstSceneJumpDialog.OnDestroy = function(self)
  -- function num : 0_2
end

FirstSceneJumpDialog.OnSceneMapClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LogInfo("FirstSceneJumpDialog", "跳转探索场景")
  local dialog = (DialogManager.GetDialog)("guide.moveguidedialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("guide.moveguidedialog")
  end
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centerdungeon")
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 11000
  csend.lineupId = 1
  LogInfoFormat("FirstSceneJumpDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

FirstSceneJumpDialog.OnBaseSceneClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LogInfo("FirstSceneJumpDialog", "跳转主城场景")
  local dialog = (DialogManager.GetDialog)("guide.moveguidedialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("guide.moveguidedialog")
  end
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
  csend:Send()
end

FirstSceneJumpDialog.OnW1SceneClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LogInfo("FirstSceneJumpDialog", "跳转魔法森林")
  local dialog = (DialogManager.GetDialog)("guide.moveguidedialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("guide.moveguidedialog")
  end
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centerdungeon")
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 30003
  csend.lineupId = 1
  LogInfoFormat("FirstSceneJumpDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

return FirstSceneJumpDialog

