-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/resolveequipitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResolveEquipItemCell = class("ResolveEquipItemCell", Dialog)
ResolveEquipItemCell.AssetBundleName = "ui/layouts.equip"
ResolveEquipItemCell.AssetName = "EquipResolveItemCell"
ResolveEquipItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResolveEquipItemCell
  ((ResolveEquipItemCell.super).Ctor)(self, ...)
end

ResolveEquipItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._count = self:GetChild("_Count/Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ResolveEquipItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

ResolveEquipItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local imageRecord = data:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetText((NumberManager.GetShowNumber)(data:GetCount()))
end

ResolveEquipItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._cellData})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return ResolveEquipItemCell

