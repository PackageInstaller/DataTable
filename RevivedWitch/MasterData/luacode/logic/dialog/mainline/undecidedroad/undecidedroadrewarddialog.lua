-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadrewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadRewardDialog = class("UndecidedRoadRewardDialog", Dialog)
UndecidedRoadRewardDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRewardDialog.AssetName = "ActivityRoadReward"
UndecidedRoadRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadRewardDialog
  ((UndecidedRoadRewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._dataList = {}
end

UndecidedRoadRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._getBtn = self:GetChild("BackImage/GetBtn")
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._tips = self:GetChild("BackImage/Tips")
  self._timetxt = self:GetChild("BackImage/TimeTxt")
  self._panel = self:GetChild("BackImage/Frame")
  self._scrollBar = self:GetChild("BackImage/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(2)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAward, Common.n_RefreshUndecidedRoadAward, nil)
end

UndecidedRoadRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

UndecidedRoadRewardDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._tips):SetText((TextManager.GetText)(1901016))
  local endTime = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetAwardEndTime()
  local str = (string.gsub)((TextManager.GetText)(1901017), "%$parameter1%$", endTime)
  ;
  (self._timetxt):SetText(str)
  local haveAvailable = ((NekoData.BehaviorManager).BM_UndecidedRoad):HaveAvailable()
  ;
  (self._getBtn):SetInteractable(haveAvailable)
  self._dataList = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetRewardList()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  if haveAvailable then
    for k,v in ipairs(self._dataList) do
      if v.status == 1 then
        (self._frame):MoveTopToIndex(k)
        return 
      end
    end
  else
    do
      for k,v in ipairs(self._dataList) do
        if v.status == 0 then
          (self._frame):MoveTopToIndex(k)
          return 
        end
      end
    end
  end
end

UndecidedRoadRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._dataList
end

UndecidedRoadRewardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "mainline.undecidedroad.undecidedroadrewardcell"
end

UndecidedRoadRewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._dataList)[index]
end

UndecidedRoadRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

UndecidedRoadRewardDialog.RefreshAward = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  local lastPos = (self._frame):GetCurrentPosition()
  self._dataList = ((NekoData.BehaviorManager).BM_UndecidedRoad):GetRewardList()
  ;
  (self._frame):ReloadAllCell()
  if lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
  local haveAvailable = ((NekoData.BehaviorManager).BM_UndecidedRoad):HaveAvailable()
  ;
  (self._getBtn):SetInteractable(haveAvailable)
end

UndecidedRoadRewardDialog.OnGetBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.creceivereward")
  if csend then
    csend.rewardId = 0
    csend:Send()
  end
end

UndecidedRoadRewardDialog.OnCurPosChange = function(self, frame, proportion)
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

return UndecidedRoadRewardDialog

