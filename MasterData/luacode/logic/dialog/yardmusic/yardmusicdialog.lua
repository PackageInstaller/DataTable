-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/yardmusicdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local RewardStatus = (LuaNetManager.GetBeanDef)("protocol.yard.musiccollectionrewardsstatus")
local YardMusicDialog = class("YardMusicDialog", Dialog)
YardMusicDialog.AssetBundleName = "ui/layouts.yard"
YardMusicDialog.AssetName = "MusicPlayerMain"
YardMusicDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : YardMusicDialog, _ENV
  ((YardMusicDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._currencies = {[1] = DataCommon.SoulDropID, [2] = DataCommon.ManaID}
end

YardMusicDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._collectBtn = self:GetChild("CancelBtn")
  self._collectBtn_redDot = self:GetChild("CancelBtn/Dot")
  self._playing = self:GetChild("Panel")
  self._playing_musicName = self:GetChild("Panel/Music")
  self._playing_musicAuthor = self:GetChild("Panel/Author")
  self._playing_syncToggleBtn = self:GetChild("Panel/_Toggle_0")
  self._cellPanel = self:GetChild("Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, false, true)
  self._currencyPanel = self:GetChild("TopGroup")
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  self._width = (self._currencyPanel):GetRectSize()
  self._anchoredx = (self._currencyPanel):GetAnchoredPosition()
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._collectBtn):Subscribe_PointerClickEvent(self.OnCollectBtnClicked, self)
  ;
  (self._playing_syncToggleBtn):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  ;
  (self._playing):Subscribe_PointerClickEvent(self.OnPlayingPanelClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRedDotAndNew, Common.n_BuildingGetNumChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUnlockSong, Common.n_UnlockSong, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnPlayingIdChanged, Common.n_PlayingIdChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  self:Init()
  ;
  (self:GetChild("Panel/_Toggle_0/Label")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1846))
end

YardMusicDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._cellFrame):Destroy()
  ;
  (self._currencyFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("yardmusic.albumdialog")
  ;
  (DialogManager.DestroySingletonDialog)("yardmusic.rewarddialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battleteachguidedialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battleteachguidedialog")
end

YardMusicDialog.Init = function(self)
  -- function num : 0_3
  self:RefreshCurrencyPanel()
  self:RefreshCollectBtnRedDot()
  self:RefreshPlaying()
  self:RefreshAlbum()
end

YardMusicDialog.OnRefreshRedDotAndNew = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  if (notification.userInfo).buildingId == DataCommon.YardMusic then
    self:RefreshCollectBtnRedDot()
    self:RefreshAlbum()
  end
end

YardMusicDialog.OnUnlockSong = function(self)
  -- function num : 0_5
  self:RefreshAlbum()
end

YardMusicDialog.OnPlayingIdChanged = function(self)
  -- function num : 0_6
  self:RefreshPlaying()
end

YardMusicDialog.OnRefreshCurrency = function(self)
  -- function num : 0_7
  self:RefreshCurrencyPanel()
end

YardMusicDialog.RefreshCurrencyPanel = function(self)
  -- function num : 0_8
  local cellPanelWidth = self._width / 3 * #self._currencies
  ;
  (self._currencyPanel):SetSize(0, cellPanelWidth, 0, self._height)
  ;
  (self._currencyPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._currencyFrame):ReloadAllCell()
end

YardMusicDialog.RefreshCollectBtnRedDot = function(self)
  -- function num : 0_9 , upvalues : _ENV, RewardStatus
  local show = false
  local rewards = ((NekoData.BehaviorManager).BM_YardMusic):GetRewards()
  for k,v in pairs(rewards) do
    if v.rewardStatus == RewardStatus.AVAILABLE then
      show = true
      break
    end
  end
  do
    ;
    (self._collectBtn_redDot):SetActive(show)
  end
end

YardMusicDialog.RefreshPlaying = function(self)
  -- function num : 0_10 , upvalues : _ENV, CAudioPlayerCell
  local musicId = ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(musicId)
  ;
  (self._playing_musicName):SetText((TextManager.GetText)(record.audioName))
  ;
  (self._playing_musicAuthor):SetText((TextManager.GetText)(record.author))
  ;
  (self._playing_syncToggleBtn):SetIsOnType(((NekoData.BehaviorManager).BM_YardMusic):GetSyncMainCity())
end

YardMusicDialog.RefreshAlbum = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local lastPos = (self._cellFrame):GetCurrentPosition()
  self._albumList = ((NekoData.BehaviorManager).BM_YardMusic):GetAlbumList()
  ;
  (self._cellFrame):ReloadAllCell()
  if lastPos then
    (self._cellFrame):MoveToAssignedPos(lastPos)
  end
end

YardMusicDialog.CheckedAlbum = function(self, albumData)
  -- function num : 0_12 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("yardmusic.albumdialog")):SetData(albumData)
end

YardMusicDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_13
  if frame == self._cellFrame then
    return #self._albumList
  else
    return #self._currencies
  end
end

YardMusicDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_14
  if frame == self._cellFrame then
    return "yardmusic.albumcell"
  else
    return "yardmusic.currencycell"
  end
end

YardMusicDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._cellFrame then
    return (self._albumList)[index]
  else
    return (self._currencies)[index]
  end
end

YardMusicDialog.OnCollectBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("yardmusic.rewarddialog")
end

YardMusicDialog.OnValueChanged = function(self, args, luawindow)
  -- function num : 0_17 , upvalues : _ENV
  if args ~= ((NekoData.BehaviorManager).BM_YardMusic):GetSyncMainCity() then
    ((NekoData.BehaviorManager).BM_YardMusic):SetSyncMainCity(args)
  end
end

YardMusicDialog.OnPlayingPanelClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV, CAudioPlayerCell
  local playingId = ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(playingId)
  local albumList = ((NekoData.BehaviorManager).BM_YardMusic):GetAlbumList()
  for i,v in ipairs(albumList) do
    if (v.record).id == record.album then
      local dialog = (DialogManager.CreateSingletonDialog)("yardmusic.albumdialog")
      dialog:SetData(v)
      for index,music in ipairs(v.musicList) do
        if music.id == playingId then
          dialog:JumpToPlayingCell(music, index)
        end
      end
      break
    end
  end
end

YardMusicDialog.OnIBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(((DataCommon.LocalTips).GuideOpenInstructionDialog_YardMusic).guideId)
end

YardMusicDialog.OnBackBtnClicked = function(self)
  -- function num : 0_20
  self:Destroy()
end

YardMusicDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return YardMusicDialog

