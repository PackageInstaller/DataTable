local FirstSceneJumpDialog = class("FirstSceneJumpDialog", Dialog)
FirstSceneJumpDialog.AssetBundleName = "ui/layouts.login"
FirstSceneJumpDialog.AssetName = "FastLogin"

function FirstSceneJumpDialog:Ctor(...)
  FirstSceneJumpDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function FirstSceneJumpDialog:OnCreate()
  self._scenemap = self:GetChild("scenemap")
  self._baseScene = self:GetChild("BaseScene")
  self._w1Scene = self:GetChild("W1Scene")
  self._scenemap:SetActive(NekoData.BehaviorManager.BM_Game:IsGM())
  self._baseScene:SetActive(NekoData.BehaviorManager.BM_Game:IsGM())
  self._w1Scene:SetActive(NekoData.BehaviorManager.BM_Game:IsGM())
  self._scenemap:Subscribe_PointerClickEvent(self.OnSceneMapClicked, self)
  self._baseScene:Subscribe_PointerClickEvent(self.OnBaseSceneClicked, self)
  self._w1Scene:Subscribe_PointerClickEvent(self.OnW1SceneClicked, self)
end

function FirstSceneJumpDialog:OnDestroy()
end

function FirstSceneJumpDialog:OnSceneMapClicked()
  LogInfo("FirstSceneJumpDialog", "跳转探索场景")
  local dialog = DialogManager.GetDialog("guide.moveguidedialog")
  if dialog then
    DialogManager.DestroySingletonDialog("guide.moveguidedialog")
  end
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
  local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 11000
  csend.lineupId = 1
  LogInfoFormat("FirstSceneJumpDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

function FirstSceneJumpDialog:OnBaseSceneClicked()
  LogInfo("FirstSceneJumpDialog", "跳转主城场景")
  local dialog = DialogManager.GetDialog("guide.moveguidedialog")
  if dialog then
    DialogManager.DestroySingletonDialog("guide.moveguidedialog")
  end
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
  csend:Send()
end

function FirstSceneJumpDialog:OnW1SceneClicked()
  LogInfo("FirstSceneJumpDialog", "跳转魔法森林")
  local dialog = DialogManager.GetDialog("guide.moveguidedialog")
  if dialog then
    DialogManager.DestroySingletonDialog("guide.moveguidedialog")
  end
  DialogManager.DestroySingletonDialog("maindialog")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
  local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 30003
  csend.lineupId = 1
  LogInfoFormat("FirstSceneJumpDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
end

return FirstSceneJumpDialog
