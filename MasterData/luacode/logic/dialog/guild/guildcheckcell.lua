local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local JobEnum = LuaNetManager.GetProtocolDef("protocol.party.cdealmemberapply")
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60

local function GetTimeStr(ms)
  local sec = ms // 1000
  local str
  if sec > SecToDay * 7 then
    sec = SecToDay * 7 - 1
    str = TextManager.GetText(CStringRes:GetRecorder(1463).msgTextID)
    local day = os.date("!%d", sec)
    str = string.gsub(str, "%$parameter1%$", tonumber(day))
  elseif sec > SecToDay then
    str = TextManager.GetText(CStringRes:GetRecorder(1463).msgTextID)
    local day = os.date("!%d", sec)
    str = string.gsub(str, "%$parameter1%$", tonumber(day))
  elseif sec > SecToHour then
    str = TextManager.GetText(CStringRes:GetRecorder(1462).msgTextID)
    local hour = os.date("!%H", sec)
    str = string.gsub(str, "%$parameter1%$", tonumber(hour))
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1461).msgTextID)
    local min = os.date("!%M", sec)
    str = string.gsub(str, "%$parameter1%$", tonumber(min))
  end
  return str
end

local GuildCheckCell = class("GuildCheckCell", Dialog)
GuildCheckCell.AssetBundleName = "ui/layouts.guild"
GuildCheckCell.AssetName = "GuildCheckCell"

function GuildCheckCell:Ctor(...)
  GuildCheckCell.super.Ctor(self, ...)
end

function GuildCheckCell:OnCreate()
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._lv = self:GetChild("Back/LvBack/Level")
  self._name = self:GetChild("Back/NameBack/Name")
  self._time = self:GetChild("Back/Time/Num")
  self._refuseBtn = self:GetChild("Back/RefuseBtn")
  self._agreeBtn = self:GetChild("Back/AgreeBtn")
  self._refuseBtn:Subscribe_PointerClickEvent(function()
    self:DealMemberApply(JobEnum.REFUSE)
  end, self)
  self._agreeBtn:Subscribe_PointerClickEvent(function()
    self:DealMemberApply(JobEnum.ACCEPT)
  end, self)
  self._photoFrame:Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
end

function GuildCheckCell:RefreshCell(data)
  local imageRecord
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.avatarId)
  if headPhotoRecord then
    imageRecord = CImagePath:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildCheckCell", "userInfo.avatarId %s is wrong", data.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePath:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildCheckCell", "userInfo.frameId %s is wrong", data.frameId)
  end
  self._lv:SetText(data.userLevel)
  self._name:SetText(data.username)
  local str = GetTimeStr(data.applyTime)
  self._time:SetText(str)
end

function GuildCheckCell:OnPhotoClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  protocol.userId = self._cellData.userId
  protocol:Send()
end

function GuildCheckCell:DealMemberApply(operate)
  local csend = LuaNetManager.CreateProtocol("protocol.party.cdealmemberapply")
  if csend then
    csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
    csend.userId = self._cellData.userId
    csend.operate = operate
    csend:Send()
  end
end

return GuildCheckCell
