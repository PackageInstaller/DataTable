local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local GuildLevelRankCell = class("GuildLevelRankCell", Dialog)
GuildLevelRankCell.AssetBundleName = "ui/layouts.guild"
GuildLevelRankCell.AssetName = "LevelRankCell"

function GuildLevelRankCell:Ctor(...)
  GuildLevelRankCell.super.Ctor(self, ...)
end

function GuildLevelRankCell:OnCreate()
  self._back = self:GetChild("Back")
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._name = self:GetChild("Back/NameBack/Name")
  self._lv = self:GetChild("Back/Level/LevelNum")
  self._expNum = self:GetChild("Back/ExpNum")
  self._rankNum = self:GetChild("Back/RankNum/Num")
  self._iBtn = self:GetChild("Back/Ibtn")
  self._joinBtn = self:GetChild("Back/JoinBtn")
  self._back:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._joinBtn:Subscribe_PointerClickEvent(self.OnJoinBtnClicked, self)
end

function GuildLevelRankCell:RefreshCell(data)
  self._data = data.data
  self._index = data.index
  self._name:SetText(self._data.partyName)
  self._lv:SetText(self._data.partyLv)
  self._expNum:SetText(self._data.partyExp)
  self._rankNum:SetText(self._index)
  local headPhotoRecord = CGuildHead:GetRecorder(self._data.avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePath:GetRecorder(headPhotoRecord.UiId) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildLevelRankCell", "GuildHeadID %s Cannot Find", tostring(self._data.avatarId))
  end
end

function GuildLevelRankCell:OnJoinBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = {
      self._data.partyId
    }
    csend:Send()
  end
end

function GuildLevelRankCell:OnIBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.ccheckpartyinfo")
  if csend then
    csend.partyId = self._data.partyId
    csend:Send()
  end
end

return GuildLevelRankCell
