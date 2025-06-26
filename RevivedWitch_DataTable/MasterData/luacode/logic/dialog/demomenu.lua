-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/demomenu.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DemoMenuDialog = class("DemoMenuDialog", Dialog)
DemoMenuDialog.AssetBundleName = "ui/layouts"
DemoMenuDialog.AssetName = "DemoMenu"
DemoMenuDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DemoMenuDialog
  ((DemoMenuDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

DemoMenuDialog.OnCreate = function(self)
  -- function num : 0_1
  self._sceneBattle = self:GetChild("BattleBtn")
  self._sceneEdit = self:GetChild("EditBtn")
  self._sceneFirst = self:GetChild("FirstSceneBtn")
  ;
  (self._sceneBattle):Subscribe_PointerClickEvent(self.OnSceneBattleClicked, self)
  ;
  (self._sceneEdit):Subscribe_PointerClickEvent(self.OnSceneEditClicked, self)
  ;
  (self._sceneFirst):Subscribe_PointerClickEvent(self.OnSceneFirstClicked, self)
end

DemoMenuDialog.OnDestroy = function(self)
  -- function num : 0_2
end

DemoMenuDialog.OnSceneBattleClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (GameScene.LoadInGame)()
  ;
  (GameScene.LoadTestBattleScene)()
  ;
  (DialogManager.DestroySingletonDialog)("demomenu")
end

DemoMenuDialog.OnSceneEditClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (GameScene.LoadInGame)()
  ;
  (GameScene.LoadEditScene)()
  ;
  (DialogManager.DestroySingletonDialog)("demomenu")
end

DemoMenuDialog.OnSceneFirstClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (GameScene.LoadInGame)()
  ;
  (GameScene.LoadFirstScene)()
  ;
  (DialogManager.DestroySingletonDialog)("demomenu")
end

return DemoMenuDialog

