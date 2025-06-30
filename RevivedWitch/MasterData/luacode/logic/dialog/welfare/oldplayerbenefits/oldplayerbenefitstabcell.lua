-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/oldplayerbenefits/oldplayerbenefitstabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ColumnNum = 3
local moneyNum = (((BeanManager.GetTableByName)("welfare.coldplayerwelfare")):GetRecorder(1)).moneyNum
local pageName = {2214, 2215, 2216}
local OldPlayerBenefitsTabCell = class("OldPlayerBenefitsTabCell", Dialog)
OldPlayerBenefitsTabCell.AssetBundleName = "ui/layouts.welfare"
OldPlayerBenefitsTabCell.AssetName = "WelfareFeedback"
OldPlayerBenefitsTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OldPlayerBenefitsTabCell, _ENV
  ((OldPlayerBenefitsTabCell.super).Ctor)(self, ...)
  self._init = false
  self._curPageID = 0
  self._cellData = {}
  self._protocolData = nil
  self._activityClose = false
  self._activityTask = nil
  self._activityId = (DataCommon.Activities).OldPlayerBenefits
end

OldPlayerBenefitsTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, pageName, moneyNum
  self._rewardPanel = self:GetChild("BackImage/Frame")
  self._rewardFrame = (TableFrame.Create)(self._rewardPanel, self, true, true, true)
  self.threeCompoent = {}
  for i = 1, 3 do
    do
      local compoent = {}
      compoent.btn = self:GetChild("OngoingBtn" .. i)
      ;
      (compoent.btn):Subscribe_PointerClickEvent(function(self)
    -- function num : 0_1_0 , upvalues : i
    self:SelectPage(i)
  end
, self)
      compoent.btn_text = self:GetChild("OngoingBtn" .. i .. "/_Text")
      ;
      (compoent.btn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(pageName[i]))
      compoent.btn_RedDot = self:GetChild("OngoingBtn" .. i .. "/RedDot")
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.threeCompoent)[i] = compoent
    end
  end
  self._timeTxt = self:GetChild("TxtFrame/Time")
  self._buyBtn = self:GetChild("BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.BuyBtnClick, self)
  self._buyBtn_Text = self:GetChild("BuyBtn/Text")
  ;
  (self._buyBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2226, {moneyNum}))
end

OldPlayerBenefitsTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._rewardFrame):Destroy()
end

local FirstCanGetIndex = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not self._activityClose then
    for i,v in ipairs(self._cellData) do
      if v.hasReward then
        return i
      end
    end
  end
end

OldPlayerBenefitsTabCell.RefreshTabCell = function(self, refresh, notChangeSlidePos)
  -- function num : 0_4 , upvalues : _ENV
  if not self._init or refresh then
    local data = ((NekoData.BehaviorManager).BM_Welfare):GetOldPlayerWelfareInfo()
    if not data then
      self._activityClose = true
    end
    if self._activityClose and self._activityTask then
      (GameTimer.RemoveTask)(self._activityTask)
      self._activityTask = nil
    end
    for i = 1, 3 do
      (((self.threeCompoent)[i]).btn_RedDot):SetActive(((NekoData.BehaviorManager).BM_Welfare):HasCanReceiveOldPlayerWelfareByPageID(i))
    end
    self._leftTime = ((NekoData.BehaviorManager).BM_Activity):GetOtherActivityLeftTimeWithActivityId(self._activityId)
    self:RefreshTime()
    if not self._activityTask then
      self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshTime()
  end
)
    end
    self:SelectPage(self._curPageID)
    self.isPay = ((NekoData.BehaviorManager).BM_Welfare):IsPayOldPlayerWelfare()
    ;
    (self._buyBtn):SetActive(not self.isPay)
  end
end

OldPlayerBenefitsTabCell.RefreshTime = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStringRes
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = (math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1042)).msgTextID)
    if day > 0 then
      local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1043)).msgTextID)
      ;
      (self._timeTxt):SetText(str .. day .. str1)
    else
      do
        if hour > 0 then
          local str2 = (TextManager.GetText)((CStringRes:GetRecorder(1044)).msgTextID)
          ;
          (self._timeTxt):SetText(str .. hour .. str2)
        else
          do
            local str3 = (TextManager.GetText)((CStringRes:GetRecorder(1045)).msgTextID)
            ;
            (self._timeTxt):SetText(str .. min .. str3)
          end
        end
      end
    end
  end
end

OldPlayerBenefitsTabCell.SelectPage = function(self, index)
  -- function num : 0_6
  local lastId = self._curPageID
  if index == 0 then
    index = 1
  end
  self._curPageID = index
  self:RefreshrewardFrame(self._curPageID == lastId)
  for i = 1, 3 do
    (((self.threeCompoent)[i]).btn):SetSelected(i == self._curPageID)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

OldPlayerBenefitsTabCell.RefreshrewardFrame = function(self, notChangeSlidePos)
  -- function num : 0_7 , upvalues : _ENV, FirstCanGetIndex
  self._cellData = ((NekoData.BehaviorManager).BM_Welfare):GetOldPlayerWelfarePageInfoByPageID(self._curPageID)
  local lastPos = (self._rewardFrame):GetCurrentPosition()
  local firstCanGetIndex = FirstCanGetIndex(self)
  ;
  (self._rewardFrame):ReloadAllCell()
  if firstCanGetIndex then
    (self._rewardFrame):MoveTopToIndex(firstCanGetIndex)
  else
    if notChangeSlidePos and lastPos then
      (self._rewardFrame):MoveToAssignedPos(lastPos)
    else
      ;
      (self._rewardFrame):MoveToTop()
    end
  end
end

OldPlayerBenefitsTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._cellData
end

OldPlayerBenefitsTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "welfare.oldplayerbenefits.rewardprogresscell"
end

OldPlayerBenefitsTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._cellData)[index]
end

OldPlayerBenefitsTabCell.BuyBtnClick = function(self)
  -- function num : 0_11 , upvalues : _ENV, moneyNum
  local hasDiamond = ((NekoData.BehaviorManager).BM_Currency):GetDiamond()
  if moneyNum <= hasDiamond then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(148, {moneyNum}, function()
    -- function num : 0_11_0 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cunlockhigholdplayerwelfare")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_11_1 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
  end
end

return OldPlayerBenefitsTabCell

