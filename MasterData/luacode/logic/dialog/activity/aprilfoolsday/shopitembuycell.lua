local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local CSkinItem = BeanManager.GetTableByName("item.cskinitem")
local ShopItemBuyCell = class("ShopItemBuyCell", Dialog)
ShopItemBuyCell.AssetBundleName = "ui/layouts.activityaprilfools"
ShopItemBuyCell.AssetName = "ActivityAprilFoolsBuyCell"
local SkinTypeId = 91

function ShopItemBuyCell:Ctor(...)
  ShopItemBuyCell.super.Ctor(self, ...)
  self._item = nil
end

function ShopItemBuyCell:OnCreate()
  self._itemName = self:GetChild("ItemName")
  self._itemNum = self:GetChild("ItemNum")
  self._itemBack = self:GetChild("ItemBack")
  self._tiemIcon = self:GetChild("ItemBack/Item")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ShopItemBuyCell:OnDestroy()
end

function ShopItemBuyCell:RefreshCell(data)
  local item = Item.Create(data.id)
  self._item = item
  self._itemName:SetText(item:GetName())
  self._itemNum:SetText(data.count)
  local imageRecord = item:GetPinJiImage()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  self._tiemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ShopItemBuyCell:OnCellClicked()
  local tipsDialog
  if self._item:GetItemType() == ItemTypeEnum.EQUIP then
    tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if tipsDialog then
      tipsDialog:Init(self._item:GetID())
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self:GetRootWindow():GetRectSize()
        local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  elseif self._item:GetItemTypeId() == SkinTypeId then
    local cfg = CSkinItem:GetRecorder(self._item:GetID())
    local dlg = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.fashionbuydialog")
    dlg:SetData({
      itemId = cfg.Skinid
    })
    self._delegate:Destroy()
  else
    tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      local data = {}
      data.item = self._item
      tipsDialog:Init(data)
    end
  end
end

return ShopItemBuyCell
