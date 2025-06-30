-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildlevelrankcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local GuildLevelRankCell = class("GuildLevelRankCell", Dialog)
GuildLevelRankCell.AssetBundleName = "ui/layouts.guild"
GuildLevelRankCell.AssetName = "LevelRankCell"
GuildLevelRankCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildLevelRankCell
  ((GuildLevelRankCell.super).Ctor)(self, ...)
end

GuildLevelRankCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._name = self:GetChild("Back/NameBack/Name")
  self._lv = self:GetChild("Back/Level/LevelNum")
  self._expNum = self:GetChild("Back/ExpNum")
  self._rankNum = self:GetChild("Back/RankNum/Num")
  self._iBtn = self:GetChild("Back/Ibtn")
  self._joinBtn = self:GetChild("Back/JoinBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._joinBtn):Subscribe_PointerClickEvent(self.OnJoinBtnClicked, self)
end

GuildLevelRankCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : CGuildHead, CImagePath, _ENV
  self._data = data.data
  self._index = data.index
  ;
  (self._name):SetText((self._data).partyName)
  ;
  (self._lv):SetText((self._data).partyLv)
  ;
  (self._expNum):SetText((self._data).partyExp)
  ;
  (self._rankNum):SetText(self._index)
  local headPhotoRecord = CGuildHead:GetRecorder((self._data).avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.UiId) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      LogErrorFormat("GuildLevelRankCell", "GuildHeadID %s Cannot Find", tostring((self._data).avatarId))
    end
  end
end

GuildLevelRankCell.OnJoinBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = {(self._data).partyId}
    csend:Send()
  end
end

GuildLevelRankCell.OnIBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.ccheckpartyinfo")
  if csend then
    csend.partyId = (self._data).partyId
    csend:Send()
  end
end

return GuildLevelRankCell

