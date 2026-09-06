local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadRewardDialog = class("UndecidedRoadRewardDialog", Dialog)
UndecidedRoadRewardDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRewardDialog.AssetName = "ActivityRoadReward"

function UndecidedRoadRewardDialog:Ctor(...)
  UndecidedRoadRewardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._dataList = {}
end

function UndecidedRoadRewardDialog:OnCreate()
  self._getBtn = self:GetChild("BackImage/GetBtn")
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._tips = self:GetChild("BackImage/Tips")
  self._timetxt = self:GetChild("BackImage/TimeTxt")
  self._panel = self:GetChild("BackImage/Frame")
  self._scrollBar = self:GetChild("BackImage/Scrollbar")
  self._scrollBar:SetScrollDirection(2)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshAward, Common.n_RefreshUndecidedRoadAward, nil)
end

function UndecidedRoadRewardDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function UndecidedRoadRewardDialog:Init()
  self._tips:SetText(TextManager.GetText(1901016))
  local endTime = NekoData.BehaviorManager.BM_UndecidedRoad:GetAwardEndTime()
  local str = string.gsub(TextManager.GetText(1901017), "%$parameter1%$", endTime)
  self._timetxt:SetText(str)
  local haveAvailable = NekoData.BehaviorManager.BM_UndecidedRoad:HaveAvailable()
  self._getBtn:SetInteractable(haveAvailable)
  self._dataList = NekoData.BehaviorManager.BM_UndecidedRoad:GetRewardList()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  if haveAvailable then
    for k, v in ipairs(self._dataList) do
      if v.status == 1 then
        self._frame:MoveTopToIndex(k)
        return
      end
    end
  else
    for k, v in ipairs(self._dataList) do
      if v.status == 0 then
        self._frame:MoveTopToIndex(k)
        return
      end
    end
  end
end

function UndecidedRoadRewardDialog:NumberOfCell(frame)
  return #self._dataList
end

function UndecidedRoadRewardDialog:CellAtIndex(frame, index)
  return "mainline.undecidedroad.undecidedroadrewardcell"
end

function UndecidedRoadRewardDialog:DataAtIndex(frame, index)
  return self._dataList[index]
end

function UndecidedRoadRewardDialog:OnBackBtnClicked()
  self:Destroy()
end

function UndecidedRoadRewardDialog:RefreshAward(notification)
  local lastPos = self._frame:GetCurrentPosition()
  self._dataList = NekoData.BehaviorManager.BM_UndecidedRoad:GetRewardList()
  self._frame:ReloadAllCell()
  if lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
  local haveAvailable = NekoData.BehaviorManager.BM_UndecidedRoad:HaveAvailable()
  self._getBtn:SetInteractable(haveAvailable)
end

function UndecidedRoadRewardDialog:OnGetBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.creceivereward")
  if csend then
    csend.rewardId = 0
    csend:Send()
  end
end

function UndecidedRoadRewardDialog:OnCurPosChange(frame, proportion)
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

return UndecidedRoadRewardDialog
