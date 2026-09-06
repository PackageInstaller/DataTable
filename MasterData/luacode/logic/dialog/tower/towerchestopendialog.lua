local cgoblinchesteffectconfig = BeanManager.GetTableByName("dungeonselect.cgoblinchesteffectconfig")
local TowerChestDialog = require("logic.dialog.tower.towerchestdialog")
local TowerChestOpenDialog = class("TowerEventBoxTips", Dialog)
TowerChestOpenDialog.AssetBundleName = "ui/layouts.mainline"
TowerChestOpenDialog.AssetName = "TowerEventBoxOpen"
local BoxOpenType = {Gold = 1, Bad = 2}

function TowerChestOpenDialog:Ctor(...)
  TowerChestOpenDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerChestOpenDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

function TowerChestOpenDialog:OnDestroy()
end

function TowerChestOpenDialog:Init(data)
  self._data = data
  if data.resultType == BoxOpenType.Gold or not data.resultType and data.type == TowerChestDialog.BoxType.Gold then
    self:GetRootWindow():SetAnimatorInteger("type", 2)
  elseif data.resultType == BoxOpenType.Bad then
    self:GetRootWindow():SetAnimatorInteger("type", 3)
  else
    self:GetRootWindow():SetAnimatorInteger("type", 1)
  end
end

function TowerChestOpenDialog:OnAnimationEnd(handler, stateName, normalizedTime)
  if stateName == "BoxOpenNormal" or stateName == "BoxOpenGold" or stateName == "BoxOpenBad" then
    NekoData.BehaviorManager.BM_Tower:OpenBox(self._data.index, self._data.choice)
  end
  DialogManager.DestroySingletonDialog("tower.towerchestdialog")
  self:Destroy()
end

return TowerChestOpenDialog
