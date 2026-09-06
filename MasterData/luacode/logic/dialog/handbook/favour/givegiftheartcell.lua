local GiveGiftHeartCell = class("GiveGiftHeartCell", Dialog)
GiveGiftHeartCell.AssetBundleName = "ui/layouts.tujian"
GiveGiftHeartCell.AssetName = "FavourGiveHeartCell"

function GiveGiftHeartCell:Ctor(...)
  GiveGiftHeartCell.super.Ctor(self, ...)
end

function GiveGiftHeartCell:OnCreate()
end

function GiveGiftHeartCell:OnDestroy()
end

function GiveGiftHeartCell:RefreshCell(data)
end

return GiveGiftHeartCell
