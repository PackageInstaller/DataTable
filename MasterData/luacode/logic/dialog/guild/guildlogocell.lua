-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildlogocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local GuildLogoCell = class("GuildLogoCell", Dialog)
GuildLogoCell.AssetBundleName = "ui/layouts.guild"
GuildLogoCell.AssetName = "GuildLogoCell"
GuildLogoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildLogoCell
  ((GuildLogoCell.super).Ctor)(self, ...)
end

GuildLogoCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("LogoBack")
  self._logo = self:GetChild("Logo")
  self._select = self:GetChild("Select")
  ;
  (self._logo):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GuildLogoCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : CGuildHead, CImagePath, _ENV
  local recorder = CGuildHead:GetRecorder(data.id)
  if not CImagePath:GetRecorder(recorder.UiId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._logo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

GuildLogoCell.OnCellClicked = function(self)
  -- function num : 0_3
  (self._delegate):OnCellClicked(self._cellData)
end

GuildLogoCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if eventName == "Select" then
    if arg == (self._cellData).id then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return GuildLogoCell

