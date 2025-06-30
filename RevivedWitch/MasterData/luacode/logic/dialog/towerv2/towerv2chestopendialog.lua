-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2chestopendialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cgoblinchesteffectconfig = (BeanManager.GetTableByName)("dungeonselect.cgoblinchesteffectconfig")
local TowerV2ChestDialog = require("logic.dialog.towerv2.towerv2chestdialog")
local TowerV2ChestOpenDialog = class("TowerEventBoxTips", Dialog)
TowerV2ChestOpenDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2ChestOpenDialog.AssetName = "TowerEventBoxOpen"
local BoxOpenType = {Gold = 1, Bad = 2}
TowerV2ChestOpenDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2ChestOpenDialog
  ((TowerV2ChestOpenDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2ChestOpenDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

TowerV2ChestOpenDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TowerV2ChestOpenDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : BoxOpenType, TowerV2ChestDialog
  self._data = data
  if data.resultType == BoxOpenType.Gold or not data.resultType and data.type == (TowerV2ChestDialog.BoxType).Gold then
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

TowerV2ChestOpenDialog.OnAnimationEnd = function(self, handler, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  if not (self._data).choice then
    ((NekoData.BehaviorManager).BM_TowerV2):ChooseEvent(((NekoData.BehaviorManager).BM_TowerV2):GetCurrentFloorID(), (self._data).index - 1, stateName ~= "BoxOpenNormal" and stateName ~= "BoxOpenGold" and stateName ~= "BoxOpenBad" or 0)
    ;
    (DialogManager.DestroySingletonDialog)("towerv2.towerv2chestdialog")
    self:Destroy()
  end
end

return TowerV2ChestOpenDialog

