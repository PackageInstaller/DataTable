-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/foresight/shopitembuycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local ShopItemBuyCell = class("ShopItemBuyCell", Dialog)
ShopItemBuyCell.AssetBundleName = "ui/layouts.baseshop"
ShopItemBuyCell.AssetName = "DayGiftBuyCell"
ShopItemBuyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopItemBuyCell
  ((ShopItemBuyCell.super).Ctor)(self, ...)
  self._item = nil
end

ShopItemBuyCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemName = self:GetChild("ItemName")
  self._itemNum = self:GetChild("ItemNum")
  self._itemBack = self:GetChild("ItemBack")
  self._tiemIcon = self:GetChild("ItemBack/Item")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopItemBuyCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopItemBuyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  local item = (Item.Create)(data.id)
  self._item = item
  ;
  (self._itemName):SetText(item:GetName())
  ;
  (self._itemNum):SetText(data.count)
  local imageRecord = item:GetPinJiImage()
  ;
  (self._itemBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  ;
  (self._tiemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

ShopItemBuyCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV, CSkinItem
  local tipsDialog = nil
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
    if (self._item):GetItemTypeId() == 91 then
      local cfg = CSkinItem:GetRecorder((self._item):GetID())
      local dlg = (DialogManager.CreateSingletonDialog)("activity.chrismascall.fashionbuydialog")
      dlg:SetData({itemId = cfg.Skinid})
      ;
      (self._delegate):Destroy()
    else
      do
        tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
        if tipsDialog then
          local data = {}
          data.item = self._item
          tipsDialog:Init(data)
        end
      end
    end
  end
end

return ShopItemBuyCell

