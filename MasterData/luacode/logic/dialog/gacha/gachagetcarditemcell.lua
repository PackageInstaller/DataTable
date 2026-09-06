local Item = require("logic.manager.experimental.types.item")
local GachaGetCardItemCell = class("GachaGetCardItemCell", Dialog)
GachaGetCardItemCell.AssetBundleName = "ui/layouts.gacha"
GachaGetCardItemCell.AssetName = "GachaGetCardItemCell"

function GachaGetCardItemCell:Ctor(...)
  GachaGetCardItemCell.super.Ctor(self, ...)
end

function GachaGetCardItemCell:OnCreate()
  self._icon = self:GetChild("Back/Icon")
  self._num = self:GetChild("Back/Num")
end

function GachaGetCardItemCell:OnDestroy()
end

function GachaGetCardItemCell:RefreshCell(data)
  local item = Item.Create(data.itemId)
  local image = item:GetIcon()
  self._icon:SetSprite(image.assetBundle, image.assetName)
  self._num:SetText(data.itemNum)
end

return GachaGetCardItemCell
