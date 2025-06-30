-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guilddetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local GuildDetailDialog = class("GuildDetailDialog", Dialog)
GuildDetailDialog.AssetBundleName = "ui/layouts.guild"
GuildDetailDialog.AssetName = "GuildDetail"
GuildDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildDetailDialog
  ((GuildDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

GuildDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
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
  ;
  (self._joinBtn):Subscribe_PointerClickEvent(self.OnJoinlBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._guildIdCopyBtn):Subscribe_PointerClickEvent(self.OnCopyBtnClicked, self)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
end

GuildDetailDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildDetailDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : CGuildHead, CImagePath, _ENV, CStringRes
  self._guildId = (data.partyInfo).partyId
  ;
  (self._guildIdText):SetText(self._guildId)
  self._data = data.allMember
  local headPhotoRecord = CGuildHead:GetRecorder((data.partyInfo).avatarId)
  if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._logo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((data.partyInfo).partyName)
  ;
  (self._lv):SetText((data.partyInfo).partyLv)
  local intro = nil
  if data.partyDeclaration and #data.partyDeclaration > 0 then
    intro = data.partyDeclaration
  else
    intro = ((NekoData.BehaviorManager).BM_Message):GetString(1518)
  end
  ;
  (self._introText):SetText(data.partyDeclaration)
  ;
  (self._mamberCount):SetText((data.partyInfo).enterNum)
  ;
  (self._mamberCountMax):SetText((data.partyInfo).totalNum)
  local str = nil
  if (data.partyInfo).autoAcceptApply == 1 then
    str = (TextManager.GetText)((CStringRes:GetRecorder(1447)).msgTextID)
  else
    str = (TextManager.GetText)((CStringRes:GetRecorder(1446)).msgTextID)
  end
  ;
  (self._conditionText):SetText(str)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GuildDetailDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GuildDetailDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "guild.guilddetailcell"
end

GuildDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

GuildDetailDialog.OnJoinlBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = {self._guildId}
    csend:Send()
  end
  self:Destroy()
end

GuildDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

GuildDetailDialog.OnSOpenParty = function(self)
  -- function num : 0_9
  self:Destroy()
end

GuildDetailDialog.OnCopyBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring(self._guildId))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

return GuildDetailDialog

