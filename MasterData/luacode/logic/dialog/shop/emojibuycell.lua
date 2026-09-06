local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CEmojiConfig = BeanManager.GetTableByName("guild.cguildemoji")
local EmojiBuyCell = class("EmojiBuyCell", Dialog)
EmojiBuyCell.AssetBundleName = "ui/layouts.baseshop"
EmojiBuyCell.AssetName = "EmojiBuyCell"

function EmojiBuyCell:Ctor(...)
  EmojiBuyCell.super.Ctor(self, ...)
end

function EmojiBuyCell:OnCreate()
  self._item = self:GetChild("Item")
  self._itemName = self:GetChild("ItemName")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function EmojiBuyCell:OnDestroy()
end

function EmojiBuyCell:RefreshCell(data)
  local record = CEmojiConfig:GetRecorder(data.id)
  if not record then
    return
  end
  local imageRecord = CImagePathTable:GetRecorder(record.EmojiId) or DataCommon.DefaultImageAsset
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = TextManager.GetText(tonumber(record.EmojiNanmeId))
  self._itemName:SetText(str)
end

function EmojiBuyCell:OnCellClicked()
end

return EmojiBuyCell
