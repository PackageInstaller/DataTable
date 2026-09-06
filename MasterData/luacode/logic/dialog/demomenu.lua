local DemoMenuDialog = class("DemoMenuDialog", Dialog)
DemoMenuDialog.AssetBundleName = "ui/layouts"
DemoMenuDialog.AssetName = "DemoMenu"

function DemoMenuDialog:Ctor(...)
  DemoMenuDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function DemoMenuDialog:OnCreate()
  self._sceneBattle = self:GetChild("BattleBtn")
  self._sceneEdit = self:GetChild("EditBtn")
  self._sceneFirst = self:GetChild("FirstSceneBtn")
  self._sceneBattle:Subscribe_PointerClickEvent(self.OnSceneBattleClicked, self)
  self._sceneEdit:Subscribe_PointerClickEvent(self.OnSceneEditClicked, self)
  self._sceneFirst:Subscribe_PointerClickEvent(self.OnSceneFirstClicked, self)
end

function DemoMenuDialog:OnDestroy()
end

function DemoMenuDialog:OnSceneBattleClicked()
  GameScene.LoadInGame()
  GameScene.LoadTestBattleScene()
  DialogManager.DestroySingletonDialog("demomenu")
end

function DemoMenuDialog:OnSceneEditClicked()
  GameScene.LoadInGame()
  GameScene.LoadEditScene()
  DialogManager.DestroySingletonDialog("demomenu")
end

function DemoMenuDialog:OnSceneFirstClicked()
  GameScene.LoadInGame()
  GameScene.LoadFirstScene()
  DialogManager.DestroySingletonDialog("demomenu")
end

return DemoMenuDialog
