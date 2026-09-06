local CAudioPlayerCell = BeanManager.GetTableByName("courtyard.caudioplayercell")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UnlockMusicDialog = class("UnlockMusicDialog", Dialog)
UnlockMusicDialog.AssetBundleName = "ui/layouts.yard"
UnlockMusicDialog.AssetName = "MusicPlayerUnlockMusic"

function UnlockMusicDialog:Ctor(...)
  UnlockMusicDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._gameTimerID = nil
  self._itemList = {}
end

function UnlockMusicDialog:OnCreate()
  self._itemsPanel = self:GetChild("Back/Frame")
  self._itemsFrame = TableFrame.Create(self._itemsPanel, self, false, false)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function UnlockMusicDialog:OnDestroy()
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  self._itemsFrame:Destroy()
end

function UnlockMusicDialog:SetData(musicId)
  self._musicId = musicId
  local record = CAudioPlayerCell:GetRecorder(musicId)
  self._itemsEnough = true
  for i, v in ipairs(record.unlockItems) do
    local haveNum = 0
    if string.sub(v, 1, 2) == "35" then
      haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v)
    else
      haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
    end
    if self._itemsEnough and haveNum < record.itemsAmount[i] then
      self._itemsEnough = false
    end
    table.insert(self._itemList, {
      id = v,
      num = record.itemsAmount[i]
    })
  end
  self._itemsFrame:ReloadAllCell()
  local width, height = self._itemsPanel:GetRectSize()
  local cellPanelWidth = width * #self._itemList
  local cellPanelHeight = self._itemsFrame:GetTotalLength()
  local rootWindowAnchoredx, rootWindowAnchoredy = self._itemsPanel:GetAnchoredPosition()
  self._itemsPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  self._itemsPanel:SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
  self._itemsFrame:ReloadAllCell()
end

function UnlockMusicDialog:NumberOfCell(frame, index)
  return #self._itemList
end

function UnlockMusicDialog:CellAtIndex(frame, index)
  return "yardmusic.unlockmusiccell"
end

function UnlockMusicDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

function UnlockMusicDialog:OnBackBtnClicked()
  self:Destroy()
end

function UnlockMusicDialog:OnConfirmBtnClicked()
  if self._itemsEnough then
    local cunlockSong = LuaNetManager.CreateProtocol("protocol.yard.cunlocksong")
    cunlockSong.id = self._musicId
    cunlockSong:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100261)
    if not self._gameTimerID then
      self._gameTimerID = GameTimer.AddTask(1, 0, function()
        self._itemsFrame:FireEvent("ShowTips")
      end)
    end
  end
end

return UnlockMusicDialog
