local TableFrame = require("framework.ui.frame.table.tableframe")
local CallRankCellHelper = require("logic.dialog.activity.chrismascall.callrankcellhelper")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TopToBottom = 4
local CallRankDialog = class("CallRankDialog", Dialog)
CallRankDialog.AssetBundleName = "ui/layouts.activitychristmascall"
CallRankDialog.AssetName = "ActivityChristmasCallRank"

function CallRankDialog:Ctor(...)
  CallRankDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._playerRankData = nil
  self._totalRankData = {}
end

function CallRankDialog:OnCreate()
  self._backBtn = self:GetChild("Back/CloseBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._noRank = self:GetChild("NoRank")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._activityChristmasCallRankCell = self:GetChild("ActivityChristmasCallRankCell")
  self._playerCallRankCellHelper = CallRankCellHelper.Create(self._activityChristmasCallRankCell, true)
  self._timeText = self:GetChild("Back/Time")
  self._text1 = self:GetChild("Back/Text")
  LuaNotificationCenter.AddObserver(self, self.RefreshRankData, Common.n_OnSSimpleRank, nil)
  self:SetStaticRes()
  self:SetData()
end

function CallRankDialog:SetStaticRes()
  self._text1:SetText(TextManager.GetText(CStringRes:GetRecorder(1690).msgTextID, self._exchangeNum))
  self._timeText:SetText(TextManager.GetText(CStringRes:GetRecorder(1667).msgTextID, self._exchangeNum))
end

function CallRankDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  if self._playerCallRankCellHelper then
    self._playerCallRankCellHelper:OnDestroy()
  end
end

function CallRankDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm:SendCSimpleRank()
  self:RefreshRankData()
end

function CallRankDialog:RefreshRankData(notification)
  local rankData = NekoData.BehaviorManager.BM_SimpleRank:GetChristmasCallRankData()
  if rankData == nil then
    return
  end
  rankData = rankData[0]
  self._noRank:SetActive(next(rankData.totalRanking) == nil)
  for key, _ in pairs(self._totalRankData) do
    self._totalRankData[key] = nil
  end
  for _, value in ipairs(rankData.totalRanking) do
    table.insert(self._totalRankData, {
      remoteData = value,
      localData = self._bm:GetRewardCfgByRank(value.rank)
    })
  end
  self._playerRankData = {
    remoteData = rankData.playerRanking,
    localData = self._bm:GetRewardCfgByRank(rankData.playerRanking.rank)
  }
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  if self._playerCallRankCellHelper then
    self._playerCallRankCellHelper:RefreshCell(self._playerRankData)
  end
end

function CallRankDialog:OnBackBtnClicked()
  self:Destroy()
end

function CallRankDialog:CellAtIndex(frame, index)
  return "activity.chrismascall.callrankcell"
end

function CallRankDialog:NumberOfCell(frame, index)
  return #self._totalRankData
end

function CallRankDialog:DataAtIndex(frame, index)
  return self._totalRankData[index]
end

function CallRankDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return CallRankDialog
