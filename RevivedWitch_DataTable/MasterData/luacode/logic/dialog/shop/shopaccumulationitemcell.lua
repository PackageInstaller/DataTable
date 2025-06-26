-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopaccumulationitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local ShopAccumulationItemCell = class("ShopAccumulationItemCell", Dialog)
ShopAccumulationItemCell.AssetBundleName = "ui/layouts.baseshop"
ShopAccumulationItemCell.AssetName = "AccumulationCellItem"
ShopAccumulationItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopAccumulationItemCell
  ((ShopAccumulationItemCell.super).Ctor)(self, ...)
  self._item = nil
  self._cellData = nil
end

ShopAccumulationItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemFrameImage = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIconImage = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemCountText = self:GetChild("Panel/ItemCell/_Count")
  self._selectImage = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  ;
  (self._selectImage):Subscribe_PointerClickEvent(self.OnSelectImageClicked, self)
end

ShopAccumulationItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopAccumulationItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data.itemID)
  local iconRecord = (self._item):GetIcon()
  ;
  (self._itemFrameImage):SetSprite((self._item):GetPinJiImageAB())
  ;
  (self._itemIconImage):SetSprite((self._item):GetIconAB())
  ;
  (self._itemCountText):SetText((NumberManager.GetShowNumber)(data.itemCount))
end

ShopAccumulationItemCell.OnSelectImageClicked = function(self)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if (self._item):GetItemType() == ItemTypeEnum.EQUIP then
    tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
    if tipsDialog then
      tipsDialog:Init((self._item):GetID())
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      local data = {}
      data.item = self._item
      tipsDialog:Init(data, false)
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

return ShopAccumulationItemCell

