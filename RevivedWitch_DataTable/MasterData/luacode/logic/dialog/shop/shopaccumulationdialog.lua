-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopaccumulationdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRechargeReward = (BeanManager.GetTableByName)("recharge.crechargerewards")
local ShopAccumulationDialog = class("ShopAccumulationDialog", Dialog)
ShopAccumulationDialog.AssetBundleName = "ui/layouts.baseshop"
ShopAccumulationDialog.AssetName = "Accumulation"
ShopAccumulationDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopAccumulationDialog
  ((ShopAccumulationDialog.super).Ctor)(self, ...)
  self._chargeAccumulationDataList = nil
  self._rewardFrame = nil
end

ShopAccumulationDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._rewardFrameNode = self:GetChild("CellFrame")
  self._exitButton = self:GetChild("BackBtn")
  self._totalScoreText = self:GetChild("Text/AllScoreTxt")
  ;
  (self._exitButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._rewardFrame = (TableFrame.Create)(self._rewardFrameNode, self, false, true, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChargeAccumulationAddPoints, Common.n_ChargeAccumulationAddPoints, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChargeAccumulationReceiveReward, Common.n_ChargeAccumulationReceiveReward, nil)
  self:Refresh()
end

ShopAccumulationDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._rewardFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ChargeAccumultionRewardDialogWillDestroy, nil, nil)
end

ShopAccumulationDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, CRechargeReward, CStringRes
  local currentLevel = ((NekoData.BehaviorManager).BM_Shop):GetChargAccumulationLevel()
  self._chargeAccumulationDataList = {}
  local totalRewardCount = 0
  local rewardIDList = CRechargeReward:GetAllIds()
  local totalScore = ((NekoData.BehaviorManager).BM_Shop):GetChargAccumulationTotalScore()
  local totalScoreStr = (CStringRes:GetRecorder(1516)).msg
  local totalScoreStr = (string.gsub)(totalScoreStr, "%$parameter1%$", totalScore)
  ;
  (self._totalScoreText):SetText(totalScoreStr)
  for k = 1, #rewardIDList do
    if (CRechargeReward:GetRecorder(k)).unlockExperience <= totalScore then
      totalRewardCount = totalRewardCount + 1
    else
      break
    end
  end
  do
    for k = 1, totalRewardCount do
      local temp = {}
      temp.record = CRechargeReward:GetRecorder(k)
      if (temp.record).unlockLevel <= currentLevel then
        temp.isUnlock = true
        local hasGotten = ((NekoData.BehaviorManager).BM_Shop):HasGottenAccumulationReward(k)
        temp.hasGotten = hasGotten
      else
        do
          do
            temp.isUnlock = false
            ;
            (table.insert)(self._chargeAccumulationDataList, temp)
            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    ;
    (self._rewardFrame):ReloadAllCell()
    for k,v in ipairs(self._chargeAccumulationDataList) do
      if v.isUnlock and v.hasGotten == false then
        (self._rewardFrame):MoveLeftToIndex(k)
        return 
      end
    end
    for k,v in ipairs(self._chargeAccumulationDataList) do
      if currentLevel + 1 == (v.record).unlockLevel then
        (self._rewardFrame):MoveLeftToIndex(k)
        return 
      end
    end
    ;
    (self._rewardFrame):MoveToRight(false)
  end
end

ShopAccumulationDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

ShopAccumulationDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._chargeAccumulationDataList
end

ShopAccumulationDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._chargeAccumulationDataList)[index]
end

ShopAccumulationDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "shop.shopaccumulationcell"
end

ShopAccumulationDialog.OnChargeAccumulationAddPoints = function(self, notification)
  -- function num : 0_8
  self:Refresh()
end

ShopAccumulationDialog.OnChargeAccumulationReceiveReward = function(self, notification)
  -- function num : 0_9
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  ;
  (self._rewardFrame):FireEvent("receivedID", userInfo)
end

return ShopAccumulationDialog

