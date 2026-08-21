-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guilddonateconfirmitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local GuildDonateConFirmItemCell = class("GuildDonateConFirmItemCell", Dialog)
GuildDonateConFirmItemCell.AssetBundleName = "ui/layouts.guild"
GuildDonateConFirmItemCell.AssetName = "GuildDonateConFirmItemCell"
GuildDonateConFirmItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildDonateConFirmItemCell
  ((GuildDonateConFirmItemCell.super).Ctor)(self, ...)
  self._selectCount = 0
end

GuildDonateConFirmItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self._select):SetActive(false)
end

GuildDonateConFirmItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuildDonateConFirmItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(data.itemKey)
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetNumber(data.count)
end

return GuildDonateConFirmItemCell

