-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/charresolveshopsoldcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CharResolveShopSoldCell = class("CharResolveShopSoldCell", Dialog)
CharResolveShopSoldCell.AssetBundleName = "ui/layouts.baseshop"
CharResolveShopSoldCell.AssetName = "CharResolveShopSoldCell"
CharResolveShopSoldCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharResolveShopSoldCell
  ((CharResolveShopSoldCell.super).Ctor)(self, ...)
end

CharResolveShopSoldCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

CharResolveShopSoldCell.OnDestroy = function(self)
  -- function num : 0_2
end

CharResolveShopSoldCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data.itemid)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText((NumberManager.GetShowNumber)(data.num))
end

CharResolveShopSoldCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return CharResolveShopSoldCell

