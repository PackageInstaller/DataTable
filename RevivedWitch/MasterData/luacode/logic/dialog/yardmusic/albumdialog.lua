-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/albumdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local Item = require("logic.manager.experimental.types.item")
local SongStatus = (LuaNetManager.GetBeanDef)("protocol.yard.song")
local AlbumDialog = class("AlbumDialog", Dialog)
AlbumDialog.AssetBundleName = "ui/layouts.yard"
AlbumDialog.AssetName = "MusicPlayerAldum"
AlbumDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlbumDialog, _ENV
  ((AlbumDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._currencies = {[1] = DataCommon.SoulDropID, [2] = DataCommon.ManaID}
end

AlbumDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._iBtn = self:GetChild("Ibtn")
  self._currencyPanel = self:GetChild("TopGroup")
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  self._width = (self._currencyPanel):GetRectSize()
  self._anchoredx = (self._currencyPanel):GetAnchoredPosition()
  self._albumImg = self:GetChild("MusicPlayerMainCell/AldumImage")
  self._playing = self:GetChild("NowPlay")
  self._playing_musicName = self:GetChild("NowPlay/Music")
  self._playing_musicAuthor = self:GetChild("NowPlay/Author")
  self._select_lock = self:GetChild("MusicPlayerMainCell/Lock")
  self._select_lock_musicName = self:GetChild("MusicPlayerMainCell/Lock/Music")
  self._select_lock_musicAuthor = self:GetChild("MusicPlayerMainCell/Lock/Actor")
  self._select_lock_condition = self:GetChild("MusicPlayerMainCell/Lock/TxtLimit")
  self._select_lock_cost = self:GetChild("MusicPlayerMainCell/Lock/MusicCost")
  self._select_lock_cost_currencies = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R5 in 'UnsetPending'

    (self._select_lock_cost_currencies)[i] = {icon = self:GetChild("MusicPlayerMainCell/Lock/MusicCost/MusicCost" .. i), num = self:GetChild("MusicPlayerMainCell/Lock/MusicCost/MusicCost" .. i .. "/Num")}
  end
  self._select_lock_cost_buyBtn = self:GetChild("MusicPlayerMainCell/Lock/MusicCost/CancelBtn")
  self._progress = self:GetChild("Collecting/Txt")
  self._cellPanel = self:GetChild("Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, true, true, true)
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._select_lock_cost_buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self._playing):Subscribe_PointerClickEvent(self.OnPlayingPanelClicked, self)
  self:RefreshCurrencyPanel()
  self:RefreshPlaying()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUnlockSong, Common.n_UnlockSong, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshPlaying, Common.n_PlayingIdChanged, nil)
end

AlbumDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  ;
  (self._currencyFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("yardmusic.unlockmusicdialog")
end

AlbumDialog.RefreshCurrencyPanel = function(self)
  -- function num : 0_3
  local cellPanelWidth = self._width / 3 * #self._currencies
  ;
  (self._currencyPanel):SetSize(0, cellPanelWidth, 0, self._height)
  ;
  (self._currencyPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._currencyFrame):ReloadAllCell()
end

AlbumDialog.RefreshPlaying = function(self)
  -- function num : 0_4 , upvalues : _ENV, CAudioPlayerCell
  local musicId = ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingId()
  local record = CAudioPlayerCell:GetRecorder(musicId)
  ;
  (self._playing_musicName):SetText((TextManager.GetText)(record.audioName))
  ;
  (self._playing_musicAuthor):SetText((TextManager.GetText)(record.author))
end

AlbumDialog.OnUnlockSong = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, SongStatus
  self:RefreshCurrencyPanel()
  ;
  (self._progress):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1852, {((NekoData.BehaviorManager).BM_YardMusic):GetUnlockMusicNum(((self._data).record).id), ((NekoData.BehaviorManager).BM_YardMusic):GetAlbumMusicTotalNum(((self._data).record).id)}))
  local id = (notification.userInfo).id
  local index = nil
  for i,v in ipairs((self._data).musicList) do
    if v.id == id then
      index = i
      v.status = SongStatus.unlock
      break
    end
  end
  do
    if index then
      (self._cellFrame):FireEvent("MusicUnlocked", ((self._data).musicList)[index])
    end
    if id == (self._selectMusic).id then
      self:SelectMusic(((self._data).musicList)[index], true, true)
    end
  end
end

AlbumDialog.SetData = function(self, data)
  -- function num : 0_6 , upvalues : _ENV, CImagePathTable, SongStatus
  self._data = data
  ;
  ((NekoData.BehaviorManager).BM_YardMusic):CheckedAlbum(((self._data).record).id)
  ;
  (self._progress):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1852, {((NekoData.BehaviorManager).BM_YardMusic):GetUnlockMusicNum(((self._data).record).id), ((NekoData.BehaviorManager).BM_YardMusic):GetAlbumMusicTotalNum(((self._data).record).id)}))
  if not CImagePathTable:GetRecorder(((self._data).record).album) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._albumImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local firstNewMusicIndex = nil
  for i,v in ipairs((self._data).musicList) do
    if not v.floor and v.status == SongStatus.NEW then
      firstNewMusicIndex = i
      break
    end
  end
  do
    ;
    (self._cellFrame):ReloadAllCell()
    if firstNewMusicIndex then
      (self._cellFrame):MoveTopToIndex(firstNewMusicIndex)
    else
      ;
      (self._cellFrame):MoveToTop()
    end
    self:SelectMusic(nil, true)
  end
end

AlbumDialog.SelectMusic = function(self, musicData, refresh, fromMouseClick)
  -- function num : 0_7 , upvalues : SongStatus, _ENV, MainLineTable, Item, CImagePathTable
  if not self._selectMusic or ((musicData and (self._selectMusic).id ~= musicData.id) or refresh) then
    local tag = false
    if not refresh then
      self._selectMusic = musicData
    end
    if not self._selectMusic or (self._selectMusic).status and (self._selectMusic).status == SongStatus.unlock then
      (self._select_lock):SetActive(false)
      if fromMouseClick and self._selectMusic and (self._selectMusic).status and (self._selectMusic).status == SongStatus.unlock then
        ((NekoData.BehaviorManager).BM_YardMusic):SetPlayingId((self._selectMusic).id)
        ;
        (self._animator):Play("MusicBox")
        tag = true
      end
    else
      ;
      (self._select_lock):SetActive(true)
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

      if (self._selectMusic).status == SongStatus.NEW then
        (self._selectMusic).status = SongStatus.lock
      end
      ;
      (self._select_lock_musicName):SetText((TextManager.GetText)(((self._selectMusic).record).audioName))
      ;
      (self._select_lock_musicAuthor):SetText((TextManager.GetText)(((self._selectMusic).record).author))
      if (self._selectMusic).floor then
        (self._select_lock_condition):SetActive(true)
        ;
        (self._select_lock_cost):SetActive(false)
        local mainLineRecord = MainLineTable:GetRecorder((self._selectMusic).floor)
        ;
        (self._select_lock_condition):SetText((string.gsub)((TextManager.GetText)(800222), "%$parameter1%$", mainLineRecord.floor))
      else
        do
          ;
          (self._select_lock_condition):SetActive(false)
          ;
          (self._select_lock_cost):SetActive(true)
          local unlockItems = ((self._selectMusic).record).unlockItems
          local itemsAmount = ((self._selectMusic).record).itemsAmount
          local len = #unlockItems
          for i = len + 1, 2 do
            (((self._select_lock_cost_currencies)[i]).icon):SetActive(false)
          end
          do
            local costEnough = true
            for i = 1, len do
              if (self._select_lock_cost_currencies)[i] then
                (((self._select_lock_cost_currencies)[i]).icon):SetActive(true)
                local item = (Item.Create)(unlockItems[i])
                local imageRecord = item:GetIcon()
                ;
                (((self._select_lock_cost_currencies)[i]).icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
                ;
                (((self._select_lock_cost_currencies)[i]).num):SetText(itemsAmount[i])
              else
                do
                  do
                    LogError("Data Error.")
                    if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(unlockItems[i]) < itemsAmount[i] then
                      costEnough = false
                    end
                    -- DECOMPILER ERROR at PC192: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC192: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC192: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
            if len > 0 then
              (self._select_lock_cost_buyBtn):SetActive(true)
              ;
              (self._select_lock_cost_buyBtn):SetInteractable(costEnough)
            else
              ;
              (self._select_lock_cost_buyBtn):SetActive(false)
            end
            do
              if self._selectMusic then
                if not CImagePathTable:GetRecorder(((self._selectMusic).record).albumImg) then
                  local imageRecord = DataCommon.DefaultImageAsset
                end
                ;
                (self._albumImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
              end
              ;
              (self._cellFrame):FireEvent("SelectedMusic", self._selectMusic)
              if not refresh and not tag then
                (self._animator):Play("New State")
              end
            end
          end
        end
      end
    end
  end
end

AlbumDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("yardmusic.unlockmusicdialog")):SetData((self._selectMusic).id)
end

AlbumDialog.OnPlayingPanelClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, CAudioPlayerCell
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

AlbumDialog.JumpToPlayingCell = function(self, music, index)
  -- function num : 0_10
  self:SelectMusic(music)
  ;
  (self._cellFrame):MoveTopToIndex(index)
  ;
  (self._animator):Play("MusicPlayKeep")
end

AlbumDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_11
  if frame == self._cellFrame then
    return #(self._data).musicList
  else
    return #self._currencies
  end
end

AlbumDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._cellFrame then
    return "yardmusic.musiccell"
  else
    return "yardmusic.currencycell"
  end
end

AlbumDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._cellFrame then
    return ((self._data).musicList)[index]
  else
    return (self._currencies)[index]
  end
end

AlbumDialog.OnIBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(((DataCommon.LocalTips).GuideOpenInstructionDialog_YardMusic).guideId)
end

AlbumDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

AlbumDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return AlbumDialog

