local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local GuildSearchCell = class("GuildSearchCell", Dialog)
GuildSearchCell.AssetBundleName = "ui/layouts.guild"
GuildSearchCell.AssetName = "GuildSearchCell"

function GuildSearchCell:Ctor(...)
  GuildSearchCell.super.Ctor(self, ...)
end

function GuildSearchCell:OnCreate()
  self._back = self:GetChild("Back")
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._name = self:GetChild("Back/NameBack/Name")
  self._num = self:GetChild("Back/Num/Num")
  self._numMax = self:GetChild("Back/Num/NumMax")
  self._txt = self:GetChild("Back/Txt")
  self._iBtn = self:GetChild("Back/Ibtn")
  self._joinBtn = self:GetChild("Back/JoinBtn")
  self._lv = self:GetChild("Back/Level/LevelNum")
  self._back:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._joinBtn:Subscribe_PointerClickEvent(self.OnJoinBtnClicked, self)
end

function GuildSearchCell:RefreshCell(data)
  self._name:SetText(data.partyName)
  self._num:SetText(data.enterNum)
  self._numMax:SetText(data.totalNum)
  self._lv:SetText(data.partyLv)
  local str
  if data.autoAcceptApply == 1 then
    str = TextManager.GetText(CStringRes:GetRecorder(1447).msgTextID)
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1446).msgTextID)
  end
  self._txt:SetText(str)
  local headPhotoRecord = CGuildHead:GetRecorder(data.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePath:GetRecorder(headPhotoRecord.UiId) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildSearchCell", "GuildHeadID %s Cannot Find", tostring(data.avatarId))
  end
end

function GuildSearchCell:OnJoinBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = {
      self._cellData.partyId
    }
    csend:Send()
  end
end

function GuildSearchCell:OnIBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.ccheckpartyinfo")
  if csend then
    csend.partyId = self._cellData.partyId
    csend:Send()
  end
end

return GuildSearchCell
