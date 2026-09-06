local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local GuildDonateConFirmItemCell = class("GuildDonateConFirmItemCell", Dialog)
GuildDonateConFirmItemCell.AssetBundleName = "ui/layouts.guild"
GuildDonateConFirmItemCell.AssetName = "GuildDonateConFirmItemCell"

function GuildDonateConFirmItemCell:Ctor(...)
  GuildDonateConFirmItemCell.super.Ctor(self, ...)
  self._selectCount = 0
end

function GuildDonateConFirmItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._select:SetActive(false)
end

function GuildDonateConFirmItemCell:OnDestroy()
end

function GuildDonateConFirmItemCell:RefreshCell(data)
  local item = NekoData.BehaviorManager.BM_BagInfo:GetItem(data.itemKey)
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data.count)
end

return GuildDonateConFirmItemCell
