-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/secondaryitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SecondaryItemCell = class("SecondaryItemCell", Dialog)
SecondaryItemCell.AssetBundleName = "ui/layouts.yard"
SecondaryItemCell.AssetName = "YardExploreDetailCellItem"
SecondaryItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SecondaryItemCell
  ((SecondaryItemCell.super).Ctor)(self, ...)
end

SecondaryItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._backIcon = self:GetChild("ItemBack")
  self._icon = self:GetChild("ItemBack/Item")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SecondaryItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

SecondaryItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = data:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  ;
  (self._backIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

SecondaryItemCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._rootWindow):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._cellData})
    tipsDialog:SetTipsPosition(width, height, (self._rootWindow):GetLocalPointInUiRootPanel())
  end
end

return SecondaryItemCell

