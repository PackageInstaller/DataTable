local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local DailyGiftBuyCell = class("DailyGiftBuyCell", Dialog)
DailyGiftBuyCell.AssetBundleName = "ui/layouts.baseshop"
DailyGiftBuyCell.AssetName = "DayGiftBuyCell"

function DailyGiftBuyCell:Ctor(...)
  DailyGiftBuyCell.super.Ctor(self, ...)
  self._item = nil
end

function DailyGiftBuyCell:OnCreate()
  self._itemName = self:GetChild("ItemName")
  self._itemNum = self:GetChild("ItemNum")
  self._itemBack = self:GetChild("ItemBack")
  self._tiemIcon = self:GetChild("ItemBack/Item")
  self._itemNumTextX = self:GetChild("Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function DailyGiftBuyCell:OnDestroy()
end

function DailyGiftBuyCell:RefreshCell(data)
  local item = Item.Create(data.id)
  self._item = item
  self._itemName:SetText(item:GetName())
  self._itemNum:SetText(data.count)
  self._itemNumTextX:SetActive(item:GetID() ~= DataCommon.SpriteEvidence)
  if item:GetID() == DataCommon.SpriteEvidence then
    self._itemNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(2097))
  end
  local imageRecord = item:GetPinJiImage()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  self._tiemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function DailyGiftBuyCell:OnCellClicked()
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
  else
    tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      local data = {}
      data.item = self._item
      tipsDialog:Init(data)
    end
  end
end

return DailyGiftBuyCell
