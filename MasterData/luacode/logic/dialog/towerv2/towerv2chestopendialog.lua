local cgoblinchesteffectconfig = BeanManager.GetTableByName("dungeonselect.cgoblinchesteffectconfig")
local TowerV2ChestDialog = require("logic.dialog.towerv2.towerv2chestdialog")
local TowerV2ChestOpenDialog = class("TowerEventBoxTips", Dialog)
TowerV2ChestOpenDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2ChestOpenDialog.AssetName = "TowerEventBoxOpen"
local BoxOpenType = {Gold = 1, Bad = 2}

function TowerV2ChestOpenDialog:Ctor(...)
  TowerV2ChestOpenDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2ChestOpenDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

function TowerV2ChestOpenDialog:OnDestroy()
end

function TowerV2ChestOpenDialog:Init(data)
  self._data = data
  if data.resultType == BoxOpenType.Gold or not data.resultType and data.type == TowerV2ChestDialog.BoxType.Gold then
    self:GetRootWindow():SetAnimatorInteger("type", 2)
  elseif data.resultType == BoxOpenType.Bad then
    self:GetRootWindow():SetAnimatorInteger("type", 3)
  else
    self:GetRootWindow():SetAnimatorInteger("type", 1)
  end
end

function TowerV2ChestOpenDialog:OnAnimationEnd(handler, stateName, normalizedTime)
  if stateName == "BoxOpenNormal" or stateName == "BoxOpenGold" or stateName == "BoxOpenBad" then
    NekoData.BehaviorManager.BM_TowerV2:ChooseEvent(NekoData.BehaviorManager.BM_TowerV2:GetCurrentFloorID(), self._data.index - 1, self._data.choice or 0)
  end
  DialogManager.DestroySingletonDialog("towerv2.towerv2chestdialog")
  self:Destroy()
end

return TowerV2ChestOpenDialog
