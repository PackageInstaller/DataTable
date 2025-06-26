-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/quicklevelup/costbreakmaterialitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CostBreakMaterialItemCell = class("CostBreakMaterialItemCell", Dialog)
CostBreakMaterialItemCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CostBreakMaterialItemCell.AssetName = "CharFastlUpListCell"
CostBreakMaterialItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CostBreakMaterialItemCell
  ((CostBreakMaterialItemCell.super).Ctor)(self, ...)
end

CostBreakMaterialItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._num = self:GetChild("_Count/Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

CostBreakMaterialItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

CostBreakMaterialItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText((NumberManager.GetShowNumber)(data.num))
end

CostBreakMaterialItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  local width, height = (self:GetRootWindow()):GetRectSize()
  if tipsDialog then
    tipsDialog:Init(self._cellData)
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return CostBreakMaterialItemCell

