-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildcheckcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local JobEnum = (LuaNetManager.GetProtocolDef)("protocol.party.cdealmemberapply")
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local GetTimeStr = function(ms)
  -- function num : 0_0 , upvalues : SecToDay, _ENV, CStringRes, SecToHour
  local sec = ms // 1000
  local str = nil
  if SecToDay * 7 < sec then
    sec = SecToDay * 7 - 1
    str = (TextManager.GetText)((CStringRes:GetRecorder(1463)).msgTextID)
    local day = (os.date)("!%d", sec)
    str = (string.gsub)(str, "%$parameter1%$", tonumber(day))
  else
    do
      if SecToDay < sec then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1463)).msgTextID)
        local day = (os.date)("!%d", sec)
        str = (string.gsub)(str, "%$parameter1%$", tonumber(day))
      else
        do
          if SecToHour < sec then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1462)).msgTextID)
            local hour = (os.date)("!%H", sec)
            str = (string.gsub)(str, "%$parameter1%$", tonumber(hour))
          else
            do
              str = (TextManager.GetText)((CStringRes:GetRecorder(1461)).msgTextID)
              do
                local min = (os.date)("!%M", sec)
                str = (string.gsub)(str, "%$parameter1%$", tonumber(min))
                return str
              end
            end
          end
        end
      end
    end
  end
end

local GuildCheckCell = class("GuildCheckCell", Dialog)
GuildCheckCell.AssetBundleName = "ui/layouts.guild"
GuildCheckCell.AssetName = "GuildCheckCell"
GuildCheckCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GuildCheckCell
  ((GuildCheckCell.super).Ctor)(self, ...)
end

GuildCheckCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : JobEnum
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._lv = self:GetChild("Back/LvBack/Level")
  self._name = self:GetChild("Back/NameBack/Name")
  self._time = self:GetChild("Back/Time/Num")
  self._refuseBtn = self:GetChild("Back/RefuseBtn")
  self._agreeBtn = self:GetChild("Back/AgreeBtn")
  ;
  (self._refuseBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_0 , upvalues : self, JobEnum
    self:DealMemberApply(JobEnum.REFUSE)
  end
, self)
  ;
  (self._agreeBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_1 , upvalues : self, JobEnum
    self:DealMemberApply(JobEnum.ACCEPT)
  end
, self)
  ;
  (self._photoFrame):Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
end

GuildCheckCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : HeadPhotoTable, CImagePath, _ENV, HeadPhotoFrameTable, GetTimeStr
  local imageRecord = nil
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildCheckCell", "userInfo.avatarId %s is wrong", data.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.frameId)
  if headPhotoFrameRecord then
    if not CImagePath:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildCheckCell", "userInfo.frameId %s is wrong", data.frameId)
  end
  ;
  (self._lv):SetText(data.userLevel)
  ;
  (self._name):SetText(data.username)
  local str = GetTimeStr(data.applyTime)
  ;
  (self._time):SetText(str)
end

GuildCheckCell.OnPhotoClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = (self._cellData).userId
  protocol:Send()
end

GuildCheckCell.DealMemberApply = function(self, operate)
  -- function num : 0_5 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cdealmemberapply")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    csend.userId = (self._cellData).userId
    csend.operate = operate
    csend:Send()
  end
end

return GuildCheckCell

