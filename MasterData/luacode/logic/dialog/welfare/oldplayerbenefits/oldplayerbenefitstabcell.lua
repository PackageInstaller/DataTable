local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ColumnNum = 3
local moneyNum = BeanManager.GetTableByName("welfare.coldplayerwelfare"):GetRecorder(1).moneyNum
local pageName = {
  2214,
  2215,
  2216
}
local OldPlayerBenefitsTabCell = class("OldPlayerBenefitsTabCell", Dialog)
OldPlayerBenefitsTabCell.AssetBundleName = "ui/layouts.welfare"
OldPlayerBenefitsTabCell.AssetName = "WelfareFeedback"

function OldPlayerBenefitsTabCell:Ctor(...)
  OldPlayerBenefitsTabCell.super.Ctor(self, ...)
  self._init = false
  self._curPageID = 0
  self._cellData = {}
  self._protocolData = nil
  self._activityClose = false
  self._activityTask = nil
  self._activityId = DataCommon.Activities.OldPlayerBenefits
end

function OldPlayerBenefitsTabCell:OnCreate()
  self._rewardPanel = self:GetChild("BackImage/Frame")
  self._rewardFrame = TableFrame.Create(self._rewardPanel, self, true, true, true)
  self.threeCompoent = {}
  for i = 1, 3 do
    local compoent = {}
    compoent.btn = self:GetChild("OngoingBtn" .. i)
    compoent.btn:Subscribe_PointerClickEvent(function(self)
      self:SelectPage(i)
    end, self)
    compoent.btn_text = self:GetChild("OngoingBtn" .. i .. "/_Text")
    compoent.btn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(pageName[i]))
    compoent.btn_RedDot = self:GetChild("OngoingBtn" .. i .. "/RedDot")
    self.threeCompoent[i] = compoent
  end
  self._timeTxt = self:GetChild("TxtFrame/Time")
  self._buyBtn = self:GetChild("BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.BuyBtnClick, self)
  self._buyBtn_Text = self:GetChild("BuyBtn/Text")
  self._buyBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2226, {moneyNum}))
end

function OldPlayerBenefitsTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._rewardFrame:Destroy()
end

local function FirstCanGetIndex(self)
  if not self._activityClose then
    for i, v in ipairs(self._cellData) do
      if v.hasReward then
        return i
      end
    end
  end
end

function OldPlayerBenefitsTabCell:RefreshTabCell(refresh, notChangeSlidePos)
  if not self._init or refresh then
    local data = NekoData.BehaviorManager.BM_Welfare:GetOldPlayerWelfareInfo()
    if not data then
      self._activityClose = true
    end
    if self._activityClose then
      if self._activityTask then
        GameTimer.RemoveTask(self._activityTask)
        self._activityTask = nil
      end
    else
      for i = 1, 3 do
        self.threeCompoent[i].btn_RedDot:SetActive(NekoData.BehaviorManager.BM_Welfare:HasCanReceiveOldPlayerWelfareByPageID(i))
      end
      self._leftTime = NekoData.BehaviorManager.BM_Activity:GetOtherActivityLeftTimeWithActivityId(self._activityId)
      self:RefreshTime()
      if not self._activityTask then
        self._activityTask = GameTimer.AddTask(0, 60, function()
          self:RefreshTime()
        end)
      end
      self:SelectPage(self._curPageID)
    end
    self.isPay = NekoData.BehaviorManager.BM_Welfare:IsPayOldPlayerWelfare()
    self._buyBtn:SetActive(not self.isPay)
  end
end

function OldPlayerBenefitsTabCell:RefreshTime()
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = TextManager.GetText(CStringRes:GetRecorder(1042).msgTextID)
    if 0 < day then
      local str1 = TextManager.GetText(CStringRes:GetRecorder(1043).msgTextID)
      self._timeTxt:SetText(str .. day .. str1)
    elseif 0 < hour then
      local str2 = TextManager.GetText(CStringRes:GetRecorder(1044).msgTextID)
      self._timeTxt:SetText(str .. hour .. str2)
    else
      local str3 = TextManager.GetText(CStringRes:GetRecorder(1045).msgTextID)
      self._timeTxt:SetText(str .. min .. str3)
    end
  end
end

function OldPlayerBenefitsTabCell:SelectPage(index)
  local lastId = self._curPageID
  if index == 0 then
    index = 1
  end
  self._curPageID = index
  self:RefreshrewardFrame(self._curPageID == lastId)
  for i = 1, 3 do
    self.threeCompoent[i].btn:SetSelected(i == self._curPageID)
  end
end

function OldPlayerBenefitsTabCell:RefreshrewardFrame(notChangeSlidePos)
  self._cellData = NekoData.BehaviorManager.BM_Welfare:GetOldPlayerWelfarePageInfoByPageID(self._curPageID)
  local lastPos = self._rewardFrame:GetCurrentPosition()
  local firstCanGetIndex = FirstCanGetIndex(self)
  self._rewardFrame:ReloadAllCell()
  if firstCanGetIndex then
    self._rewardFrame:MoveTopToIndex(firstCanGetIndex)
  elseif notChangeSlidePos and lastPos then
    self._rewardFrame:MoveToAssignedPos(lastPos)
  else
    self._rewardFrame:MoveToTop()
  end
end

function OldPlayerBenefitsTabCell:NumberOfCell(frame)
  return #self._cellData
end

function OldPlayerBenefitsTabCell:CellAtIndex(frame, index)
  return "welfare.oldplayerbenefits.rewardprogresscell"
end

function OldPlayerBenefitsTabCell:DataAtIndex(frame, index)
  return self._cellData[index]
end

function OldPlayerBenefitsTabCell:BuyBtnClick()
  local hasDiamond = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  if hasDiamond >= moneyNum then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(148, {moneyNum}, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.cunlockhigholdplayerwelfare")
      if protocol then
        protocol:Send()
      end
    end, {}, nil, {})
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
      NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
    end, {}, nil, {})
  end
end

return OldPlayerBenefitsTabCell
