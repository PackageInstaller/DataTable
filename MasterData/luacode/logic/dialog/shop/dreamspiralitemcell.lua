local Item = require("logic.manager.experimental.types.item")
local DreamSpiralItemCell = class("DreamSpiralItemCell", Dialog)
DreamSpiralItemCell.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralItemCell.AssetName = "BattlePassBuyItemCell"

function DreamSpiralItemCell:Ctor(...)
  DreamSpiralItemCell.super.Ctor(self, ...)
end

function DreamSpiralItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._select:SetActive(false)
  self._icon:Subscribe_PointerClickEvent(self.ItemClick, self)
end

function DreamSpiralItemCell:OnDestroy()
end

function DreamSpiralItemCell:ItemClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    local d = self._data
    tipsDialog:Init({
      item = Item.Create(d:GetID())
    })
    local width, height = self._icon:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._icon:GetLocalPointInUiRootPanel())
  end
end

function DreamSpiralItemCell:RefreshCell(data)
  self._data = data
  local imageRecord = data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data:GetCount())
end

return DreamSpiralItemCell
