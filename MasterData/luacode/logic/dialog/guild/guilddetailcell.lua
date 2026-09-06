local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
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

local JobColor = {
  [1] = 29,
  [2] = 30,
  [3] = 31
}
local GuildDetailCell = class("GuildDetailCell", Dialog)
GuildDetailCell.AssetBundleName = "ui/layouts.guild"
GuildDetailCell.AssetName = "GuildDetailCell"

function GuildDetailCell:Ctor(...)
  GuildDetailCell.super.Ctor(self, ...)
end

function GuildDetailCell:OnCreate()
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._lv = self:GetChild("Back/LvBack/Level")
  self._name = self:GetChild("Back/NameBack/Name")
  self._onLinePanel = self:GetChild("Back/Online")
  self._lastActivePanel = self:GetChild("Back/Num")
  self._lastActiveNum = self:GetChild("Back/Num/Num")
  self._contributionValue = self:GetChild("Back/Contribute/Num")
  self._job = self:GetChild("Back/Job")
  self._jobText = self:GetChild("Back/JobTxt")
  self._jobTextStr = self._jobText:GetText()
  self._photoFrame:Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
end

function GuildDetailCell:RefreshCell(data)
  local imageRecord
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.avatarId)
  if headPhotoRecord then
    imageRecord = CImagePath:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildDetailCell", "userInfo.avatarId %s is wrong", data.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePath:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildDetailCell", "userInfo.frameId %s is wrong", data.frameId)
  end
  self._lv:SetText(data.userLevel)
  self._name:SetText(data.username)
  self._contributionValue:SetText(data.donate)
  self._onLinePanel:SetActive(data.lastTime == 0)
  self._lastActivePanel:SetActive(data.lastTime ~= 0)
  if data.lastTime ~= 0 then
    local str = GetTimeStr(data.lastTime)
    self._lastActiveNum:SetText(str)
  end
  local jobstr = NekoData.BehaviorManager.BM_Guild:GetJobStr(data.position)
  local colorId = JobColor[data.position]
  if colorId then
    jobstr = "<color=#" .. CWordColor:GetRecorder(colorId).wordcolor .. ">" .. jobstr .. "</color>"
    local jobTextStr
    jobTextStr = "<color=#" .. CWordColor:GetRecorder(colorId).wordcolor .. ">" .. self._jobTextStr .. "</color>"
    self._jobText:SetText(jobTextStr)
  else
    self._jobText:SetText(self._jobTextStr)
  end
  self._job:SetText(jobstr)
end

function GuildDetailCell:OnPhotoClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  protocol.userId = self._cellData.userId
  protocol:Send()
end

return GuildDetailCell
