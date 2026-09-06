local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")
local PlayingMusicDialog = class("PlayingMusicDialog", Dialog)
PlayingMusicDialog.AssetBundleName = "ui/layouts.yard"
PlayingMusicDialog.AssetName = "MusicPlayerTips"

function PlayingMusicDialog:Ctor(...)
  PlayingMusicDialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function PlayingMusicDialog:OnCreate()
  self._musicName = self:GetChild("Panel/Music")
  self._musicAuthor = self:GetChild("Panel/Author")
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnPlayingIdChanged, Common.n_PlayingIdChanged, nil)
end

function PlayingMusicDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function PlayingMusicDialog:OnPlayingIdChanged()
  self._rootWindow:PlayAnimation("MusicPlayerTips")
  self:Init()
end

function PlayingMusicDialog:Init()
  local musicId = NekoData.BehaviorManager.BM_YardMusic:GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(musicId)
  self._musicName:SetText(TextManager.GetText(record.audioName))
  self._musicAuthor:SetText(TextManager.GetText(record.author))
end

function PlayingMusicDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return PlayingMusicDialog
