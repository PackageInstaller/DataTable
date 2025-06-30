-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/callrankdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CallRankCellHelper = require("logic.dialog.activity.chrismascall.callrankcellhelper")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TopToBottom = 4
local CallRankDialog = class("CallRankDialog", Dialog)
CallRankDialog.AssetBundleName = "ui/layouts.activitychristmascall"
CallRankDialog.AssetName = "ActivityChristmasCallRank"
CallRankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CallRankDialog
  ((CallRankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._playerRankData = nil
  self._totalRankData = {}
end

CallRankDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom, TableFrame, CallRankCellHelper, _ENV
  self._backBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._noRank = self:GetChild("NoRank")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._activityChristmasCallRankCell = self:GetChild("ActivityChristmasCallRankCell")
  self._playerCallRankCellHelper = (CallRankCellHelper.Create)(self._activityChristmasCallRankCell, true)
  self._timeText = self:GetChild("Back/Time")
  self._text1 = self:GetChild("Back/Text")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRankData, Common.n_OnSSimpleRank, nil)
  self:SetStaticRes()
  self:SetData()
end

CallRankDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._text1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1690)).msgTextID, self._exchangeNum))
  ;
  (self._timeText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1667)).msgTextID, self._exchangeNum))
end

CallRankDialog.OnDestroy = function(self)
  -- function num : 0_3
  if self._frame then
    (self._frame):Destroy()
  end
  if self._playerCallRankCellHelper then
    (self._playerCallRankCellHelper):OnDestroy()
  end
end

CallRankDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  ;
  (self._bm):SendCSimpleRank()
  self:RefreshRankData()
end

CallRankDialog.RefreshRankData = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local rankData = ((NekoData.BehaviorManager).BM_SimpleRank):GetChristmasCallRankData()
  if rankData == nil then
    return 
  end
  rankData = rankData[0]
  ;
  (self._noRank):SetActive(next(rankData.totalRanking) == nil)
  for key,_ in pairs(self._totalRankData) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

    (self._totalRankData)[key] = nil
  end
  for _,value in ipairs(rankData.totalRanking) do
    (table.insert)(self._totalRankData, {remoteData = value, localData = (self._bm):GetRewardCfgByRank(value.rank)})
  end
  self._playerRankData = {remoteData = rankData.playerRanking, localData = (self._bm):GetRewardCfgByRank((rankData.playerRanking).rank)}
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  if self._playerCallRankCellHelper then
    (self._playerCallRankCellHelper):RefreshCell(self._playerRankData)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CallRankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

CallRankDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.chrismascall.callrankcell"
end

CallRankDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._totalRankData
end

CallRankDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._totalRankData)[index]
end

CallRankDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_10
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return CallRankDialog

