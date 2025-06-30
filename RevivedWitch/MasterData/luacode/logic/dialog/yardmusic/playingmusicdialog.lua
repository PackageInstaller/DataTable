-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/playingmusicdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local PlayingMusicDialog = class("PlayingMusicDialog", Dialog)
PlayingMusicDialog.AssetBundleName = "ui/layouts.yard"
PlayingMusicDialog.AssetName = "MusicPlayerTips"
PlayingMusicDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayingMusicDialog
  ((PlayingMusicDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

PlayingMusicDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._musicName = self:GetChild("Panel/Music")
  self._musicAuthor = self:GetChild("Panel/Author")
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnPlayingIdChanged, Common.n_PlayingIdChanged, nil)
end

PlayingMusicDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

PlayingMusicDialog.OnPlayingIdChanged = function(self)
  -- function num : 0_3
  (self._rootWindow):PlayAnimation("MusicPlayerTips")
  self:Init()
end

PlayingMusicDialog.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV, CAudioPlayerCell
  local musicId = ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(musicId)
  ;
  (self._musicName):SetText((TextManager.GetText)(record.audioName))
  ;
  (self._musicAuthor):SetText((TextManager.GetText)(record.author))
end

PlayingMusicDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return PlayingMusicDialog

