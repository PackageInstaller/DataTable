local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local GuildDetailDialog = class("GuildDetailDialog", Dialog)
GuildDetailDialog.AssetBundleName = "ui/layouts.guild"
GuildDetailDialog.AssetName = "GuildDetail"

function GuildDetailDialog:Ctor(...)
  GuildDetailDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GuildDetailDialog:OnCreate()
  self._name = self:GetChild("Back/Title")
  self._logo = self:GetChild("Back/IntroductionBack")
  self._lv = self:GetChild("Back/Level/LevelNum")
  self._introText = self:GetChild("Back/IntroductionBack/Txt")
  self._mamberCount = self:GetChild("Back/Num/Num")
  self._mamberCountMax = self:GetChild("Back/Num/NumMax")
  self._conditionText = self:GetChild("Back/Condition/Txt2")
  self._joinBtn = self:GetChild("Back/JoinBtn")
  self._panel = self:GetChild("Back/Frame")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._guildIdText = self:GetChild("ID/IDNum")
  self._guildIdCopyBtn = self:GetChild("CopyBtn")
  self._joinBtn:Subscribe_PointerClickEvent(self.OnJoinlBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._guildIdCopyBtn:Subscribe_PointerClickEvent(self.OnCopyBtnClicked, self)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  LuaNotificationCenter.AddObserver(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
end

function GuildDetailDialog:OnDestroy()
  self._frame:Destroy()
end

function GuildDetailDialog:Init(data)
  self._guildId = data.partyInfo.partyId
  self._guildIdText:SetText(self._guildId)
  self._data = data.allMember
  local headPhotoRecord = CGuildHead:GetRecorder(data.partyInfo.avatarId)
  local imageRecord = CImagePath:GetRecorder(headPhotoRecord.UiId) or DataCommon.DefaultImageAsset
  self._logo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(data.partyInfo.partyName)
  self._lv:SetText(data.partyInfo.partyLv)
  local intro
  if data.partyDeclaration and #data.partyDeclaration > 0 then
    intro = data.partyDeclaration
  else
    intro = NekoData.BehaviorManager.BM_Message:GetString(1518)
  end
  self._introText:SetText(data.partyDeclaration)
  self._mamberCount:SetText(data.partyInfo.enterNum)
  self._mamberCountMax:SetText(data.partyInfo.totalNum)
  local str
  if data.partyInfo.autoAcceptApply == 1 then
    str = TextManager.GetText(CStringRes:GetRecorder(1447).msgTextID)
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1446).msgTextID)
  end
  self._conditionText:SetText(str)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GuildDetailDialog:NumberOfCell(frame)
  return #self._data
end

function GuildDetailDialog:CellAtIndex(frame)
  return "guild.guilddetailcell"
end

function GuildDetailDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function GuildDetailDialog:OnJoinlBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = {
      self._guildId
    }
    csend:Send()
  end
  self:Destroy()
end

function GuildDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildDetailDialog:OnSOpenParty()
  self:Destroy()
end

function GuildDetailDialog:OnCopyBtnClicked()
  self:GetRootWindow():CopyToClipBoard(tostring(self._guildId))
  NekoData.BehaviorManager.BM_Message:SendMessageById(100079)
end

return GuildDetailDialog
