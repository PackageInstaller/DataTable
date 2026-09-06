local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local ShopAccumulationItemCell = class("ShopAccumulationItemCell", Dialog)
ShopAccumulationItemCell.AssetBundleName = "ui/layouts.baseshop"
ShopAccumulationItemCell.AssetName = "AccumulationCellItem"

function ShopAccumulationItemCell:Ctor(...)
  ShopAccumulationItemCell.super.Ctor(self, ...)
  self._item = nil
  self._cellData = nil
end

function ShopAccumulationItemCell:OnCreate()
  self._itemFrameImage = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIconImage = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemCountText = self:GetChild("Panel/ItemCell/_Count")
  self._selectImage = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._selectImage:Subscribe_PointerClickEvent(self.OnSelectImageClicked, self)
end

function ShopAccumulationItemCell:OnDestroy()
end

function ShopAccumulationItemCell:RefreshCell(data)
  self._item = Item.Create(data.itemID)
  local iconRecord = self._item:GetIcon()
  self._itemFrameImage:SetSprite(self._item:GetPinJiImageAB())
  self._itemIconImage:SetSprite(self._item:GetIconAB())
  self._itemCountText:SetText(NumberManager.GetShowNumber(data.itemCount))
end

function ShopAccumulationItemCell:OnSelectImageClicked()
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
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
      tipsDialog:Init(data, false)
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

return ShopAccumulationItemCell
