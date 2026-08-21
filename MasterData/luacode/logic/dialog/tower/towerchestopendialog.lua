-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerchestopendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cgoblinchesteffectconfig = (BeanManager.GetTableByName)("dungeonselect.cgoblinchesteffectconfig")
local TowerChestDialog = require("logic.dialog.tower.towerchestdialog")
local TowerChestOpenDialog = class("TowerEventBoxTips", Dialog)
TowerChestOpenDialog.AssetBundleName = "ui/layouts.mainline"
TowerChestOpenDialog.AssetName = "TowerEventBoxOpen"
local BoxOpenType = {Gold = 1, Bad = 2}
TowerChestOpenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerChestOpenDialog
  ((TowerChestOpenDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerChestOpenDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

TowerChestOpenDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TowerChestOpenDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : BoxOpenType, TowerChestDialog
  self._data = data
  if data.resultType == BoxOpenType.Gold or not data.resultType and data.type == (TowerChestDialog.BoxType).Gold then
    (self:GetRootWindow()):SetAnimatorInteger("type", 2)
  else
    if data.resultType == BoxOpenType.Bad then
      (self:GetRootWindow()):SetAnimatorInteger("type", 3)
    else
      ;
      (self:GetRootWindow()):SetAnimatorInteger("type", 1)
    end
  end
end

TowerChestOpenDialog.OnAnimationEnd = function(self, handler, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  if stateName == "BoxOpenNormal" or stateName == "BoxOpenGold" or stateName == "BoxOpenBad" then
    ((NekoData.BehaviorManager).BM_Tower):OpenBox((self._data).index, (self._data).choice)
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towerchestdialog")
  self:Destroy()
end

return TowerChestOpenDialog

