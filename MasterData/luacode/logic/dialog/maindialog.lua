local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.login"
MainDialog.AssetName = "MainDialog"

function MainDialog:Ctor(...)
  MainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function MainDialog:OnCreate()
  self._scene1 = self:GetChild("scene1")
  self._scenemap = self:GetChild("scenemap")
  self._baseScene = self:GetChild("BaseScene")
  self._w1Scene = self:GetChild("W1Scene")
  self._scene1:Subscribe_PointerClickEvent(self.OnScene1Clicked, self)
  self._scenemap:Subscribe_PointerClickEvent(self.OnSceneMapClicked, self)
  self._baseScene:Subscribe_PointerClickEvent(self.OnBaseSceneClicked, self)
  self._w1Scene:Subscribe_PointerClickEvent(self.OnW1SceneClicked, self)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(1)
end

function MainDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
end

function MainDialog:OnScene1Clicked()
  LogInfo("MainDialog", "跳转初章场景")
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
  local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 30002
  csend.lineupId = 1
  LogInfoFormat("MainDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

function MainDialog:OnSceneMapClicked()
  LogInfo("MainDialog", "跳转探索场景")
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
  local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 11000
  csend.lineupId = 1
  LogInfoFormat("MainDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

function MainDialog:OnBaseSceneClicked()
  LogInfo("MainDialog", "跳转主城场景")
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
  csend:Send()
end

function MainDialog:OnW1SceneClicked()
  LogInfo("MainDialog", "跳转魔法森林")
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
  local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 30003
  csend.lineupId = 1
  LogInfoFormat("MainDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

return MainDialog
