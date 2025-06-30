-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildsearchcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local GuildSearchCell = class("GuildSearchCell", Dialog)
GuildSearchCell.AssetBundleName = "ui/layouts.guild"
GuildSearchCell.AssetName = "GuildSearchCell"
GuildSearchCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildSearchCell
  ((GuildSearchCell.super).Ctor)(self, ...)
end

GuildSearchCell.OnCreate = function(self)
  -- function num : 0_1
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
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._joinBtn):Subscribe_PointerClickEvent(self.OnJoinBtnClicked, self)
end

GuildSearchCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, CGuildHead, CImagePath
  (self._name):SetText(data.partyName)
  ;
  (self._num):SetText(data.enterNum)
  ;
  (self._numMax):SetText(data.totalNum)
  ;
  (self._lv):SetText(data.partyLv)
  local str = nil
  if data.autoAcceptApply == 1 then
    str = (TextManager.GetText)((CStringRes:GetRecorder(1447)).msgTextID)
  else
    str = (TextManager.GetText)((CStringRes:GetRecorder(1446)).msgTextID)
  end
  ;
  (self._txt):SetText(str)
  local headPhotoRecord = CGuildHead:GetRecorder(data.avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      LogErrorFormat("GuildSearchCell", "GuildHeadID %s Cannot Find", tostring(data.avatarId))
    end
  end
end

GuildSearchCell.OnJoinBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = {(self._cellData).partyId}
    csend:Send()
  end
end

GuildSearchCell.OnIBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartyinfo")
  if csend then
    csend.partyId = (self._cellData).partyId
    csend:Send()
  end
end

return GuildSearchCell

