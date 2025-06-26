-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/unlockmusicdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UnlockMusicDialog = class("UnlockMusicDialog", Dialog)
UnlockMusicDialog.AssetBundleName = "ui/layouts.yard"
UnlockMusicDialog.AssetName = "MusicPlayerUnlockMusic"
UnlockMusicDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UnlockMusicDialog
  ((UnlockMusicDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._gameTimerID = nil
  self._itemList = {}
end

UnlockMusicDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._itemsPanel = self:GetChild("Back/Frame")
  self._itemsFrame = (TableFrame.Create)(self._itemsPanel, self, false, false)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

UnlockMusicDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  ;
  (self._itemsFrame):Destroy()
end

UnlockMusicDialog.SetData = function(self, musicId)
  -- function num : 0_3 , upvalues : CAudioPlayerCell, _ENV
  self._musicId = musicId
  local record = CAudioPlayerCell:GetRecorder(musicId)
  self._itemsEnough = true
  for i,v in ipairs(record.unlockItems) do
    local haveNum = 0
    if (string.sub)(v, 1, 2) == "35" then
      haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(v)
    else
      haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
    end
    if self._itemsEnough and haveNum < (record.itemsAmount)[i] then
      self._itemsEnough = false
    end
    ;
    (table.insert)(self._itemList, {id = v, num = (record.itemsAmount)[i]})
  end
  ;
  (self._itemsFrame):ReloadAllCell()
  local width, height = (self._itemsPanel):GetRectSize()
  local cellPanelWidth = width * #self._itemList
  local cellPanelHeight = (self._itemsFrame):GetTotalLength()
  local rootWindowAnchoredx, rootWindowAnchoredy = (self._itemsPanel):GetAnchoredPosition()
  ;
  (self._itemsPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._itemsPanel):SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
  ;
  (self._itemsFrame):ReloadAllCell()
end

UnlockMusicDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._itemList
end

UnlockMusicDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "yardmusic.unlockmusiccell"
end

UnlockMusicDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._itemList)[index]
end

UnlockMusicDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

UnlockMusicDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._itemsEnough then
    local cunlockSong = (LuaNetManager.CreateProtocol)("protocol.yard.cunlocksong")
    cunlockSong.id = self._musicId
    cunlockSong:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100261)
      if not self._gameTimerID then
        self._gameTimerID = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_8_0 , upvalues : self
    (self._itemsFrame):FireEvent("ShowTips")
  end
)
      end
    end
  end
end

return UnlockMusicDialog

