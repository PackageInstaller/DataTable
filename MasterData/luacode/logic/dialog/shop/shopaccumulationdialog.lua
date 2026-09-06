local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRechargeReward = BeanManager.GetTableByName("recharge.crechargerewards")
local ShopAccumulationDialog = class("ShopAccumulationDialog", Dialog)
ShopAccumulationDialog.AssetBundleName = "ui/layouts.baseshop"
ShopAccumulationDialog.AssetName = "Accumulation"

function ShopAccumulationDialog:Ctor(...)
  ShopAccumulationDialog.super.Ctor(self, ...)
  self._chargeAccumulationDataList = nil
  self._rewardFrame = nil
end

function ShopAccumulationDialog:OnCreate()
  self._rewardFrameNode = self:GetChild("CellFrame")
  self._exitButton = self:GetChild("BackBtn")
  self._totalScoreText = self:GetChild("Text/AllScoreTxt")
  self._exitButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._rewardFrame = TableFrame.Create(self._rewardFrameNode, self, false, true, false)
  LuaNotificationCenter.AddObserver(self, self.OnChargeAccumulationAddPoints, Common.n_ChargeAccumulationAddPoints, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChargeAccumulationReceiveReward, Common.n_ChargeAccumulationReceiveReward, nil)
  self:Refresh()
end

function ShopAccumulationDialog:OnDestroy()
  self._rewardFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  LuaNotificationCenter.PostNotification(Common.n_ChargeAccumultionRewardDialogWillDestroy, nil, nil)
end

function ShopAccumulationDialog:Refresh()
  local currentLevel = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationLevel()
  self._chargeAccumulationDataList = {}
  local totalRewardCount = 0
  local rewardIDList = CRechargeReward:GetAllIds()
  local totalScore = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationTotalScore()
  local totalScoreStr = CStringRes:GetRecorder(1516).msg
  local totalScoreStr = string.gsub(totalScoreStr, "%$parameter1%$", totalScore)
  self._totalScoreText:SetText(totalScoreStr)
  for k = 1, #rewardIDList do
    if totalScore >= CRechargeReward:GetRecorder(k).unlockExperience then
      totalRewardCount = totalRewardCount + 1
    else
      break
    end
  end
  for k = 1, totalRewardCount do
    local temp = {}
    temp.record = CRechargeReward:GetRecorder(k)
    if currentLevel >= temp.record.unlockLevel then
      temp.isUnlock = true
      local hasGotten = NekoData.BehaviorManager.BM_Shop:HasGottenAccumulationReward(k)
      temp.hasGotten = hasGotten
    else
      temp.isUnlock = false
    end
    table.insert(self._chargeAccumulationDataList, temp)
  end
  self._rewardFrame:ReloadAllCell()
  for k, v in ipairs(self._chargeAccumulationDataList) do
    if v.isUnlock and v.hasGotten == false then
      self._rewardFrame:MoveLeftToIndex(k)
      return
    end
  end
  for k, v in ipairs(self._chargeAccumulationDataList) do
    if currentLevel + 1 == v.record.unlockLevel then
      self._rewardFrame:MoveLeftToIndex(k)
      return
    end
  end
  self._rewardFrame:MoveToRight(false)
end

function ShopAccumulationDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShopAccumulationDialog:NumberOfCell(frame)
  return #self._chargeAccumulationDataList
end

function ShopAccumulationDialog:DataAtIndex(frame, index)
  return self._chargeAccumulationDataList[index]
end

function ShopAccumulationDialog:CellAtIndex(frame, index)
  return "shop.shopaccumulationcell"
end

function ShopAccumulationDialog:OnChargeAccumulationAddPoints(notification)
  self:Refresh()
end

function ShopAccumulationDialog:OnChargeAccumulationReceiveReward(notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  self._rewardFrame:FireEvent("receivedID", userInfo)
end

return ShopAccumulationDialog
