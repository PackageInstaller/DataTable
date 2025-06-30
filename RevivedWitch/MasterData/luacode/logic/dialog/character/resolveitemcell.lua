-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/resolveitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResolveItemCell = class("ResolveItemCell", Dialog)
ResolveItemCell.AssetBundleName = "ui/layouts.bag"
ResolveItemCell.AssetName = "ItemCell"
ResolveItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResolveItemCell
  ((ResolveItemCell.super).Ctor)(self, ...)
end

ResolveItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._select = self:GetChild("_BackGround/Select")
  self._count = self:GetChild("_Count")
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ResolveItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

ResolveItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = data:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetNumber(data:GetCount())
end

ResolveItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._cellData})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return ResolveItemCell

