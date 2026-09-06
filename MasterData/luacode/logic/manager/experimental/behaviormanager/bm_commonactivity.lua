local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local CActiveMainModCfg = BeanManager.GetTableByName("activity.cactivemainmodcfg")
local CActiveMissionModReward = BeanManager.GetTableByName("mission.cactivemissionmodreward")
local CActiveShopModCfg = BeanManager.GetTableByName("activity.cactiveshopmodcfg")
local CActiveSkinShop = BeanManager.GetTableByName("activity.cactiveskinshop")
local BM_CommonActivity = class("BM_CommonActivity")
BM_CommonActivity.TabType = {
  Task = 1,
  Shop = 2,
  FacePhoto = 3
}

function BM_CommonActivity:Ctor()
  self._data = NekoData.Data.taskshopactivity
end

function BM_CommonActivity:GetIsOpen(actId)
  if not self._data.actInfo[actId] then
    return false
  end
  if self._data.actInfo[actId].leftTime <= 0 then
    return false
  end
  return true
end

function BM_CommonActivity:GetActInfoInfo(actId)
  return self._data.actInfo[actId]
end

function BM_CommonActivity:ShowRedDot(actId)
  if self:GetIsOpen(actId) then
    local subTabTypeCfgList = self:GetSubtabTypeCfgList(actId)
    for _, v in ipairs(subTabTypeCfgList) do
      if self:GetRedDot(actId, v.cfg.tabType) then
        return true
      end
    end
  end
end

function BM_CommonActivity:GetRedDot(actId, tabType)
  if tabType == BM_CommonActivity.TabType.Task then
    if self:HasTaskAward(actId) then
      return true
    end
    if self:HasProcessAward(actId) then
      return true
    end
  elseif tabType == BM_CommonActivity.TabType.Shop then
    if self:HasFreeGood() then
      return true
    end
  elseif tabType == BM_CommonActivity.TabType.FacePhoto then
  else
    LogErrorFormat("BM_CommonActivity", "Unhandled Tab Type: %s", tabType)
  end
end

function BM_CommonActivity:GetActivityShopID(actId)
  local result = DataCommon.CommonActivity.Shop.ShopId
  return result
end

function BM_CommonActivity:GetActivityTaskTypeID(actId)
  local result = CActivityTasks.TASK_SHOP
  return result
end

function BM_CommonActivity:IsShopTabType(tabType)
  if tabType == BM_CommonActivity.TabType.Shop then
    return true
  end
end

function BM_CommonActivity:GetPageName(tabType)
  if tabType == BM_CommonActivity.TabType.FacePhoto then
    return "activity.activitycommon.mainpage"
  elseif tabType == BM_CommonActivity.TabType.Task then
    return "activity.activitycommon.taskpage"
  elseif tabType == BM_CommonActivity.TabType.Shop then
    return "activity.activitycommon.shopmainpage"
  end
end

function BM_CommonActivity:OpenActivityDialog(id)
  if id == 0 then
    return
  end
  if self:GetIsOpen(id) then
    local dialog = DialogManager.CreateSingletonDialog("activity.activitycommon.maindialog")
    dialog:SetData(id)
  end
end

function BM_CommonActivity:GetSubtabTypeCfgList(actId)
  local result = {}
  for _, v in ipairs(CActiveMainModCfg:GetAllIds()) do
    local record = CActiveMainModCfg:GetRecorder(v)
    if tonumber(record.activeID) == actId then
      table.insert(result, {
        cfg = record,
        reddot = self:GetRedDot(actId, record.tabType)
      })
    end
  end
  table.sort(result, function(a, b)
    return a.cfg.tabSort > b.cfg.tabSort
  end)
  for i, v in ipairs(result) do
    result[i].id = i
  end
  return result
end

function BM_CommonActivity:GetProcessAwardCfgList(actId)
  local result = {}
  if self._data.actInfo[actId] then
    for _, v in ipairs(self._data.actInfo[actId].awardIdList) do
      local record = CActiveMissionModReward:GetRecorder(v)
      if record then
        table.insert(result, {
          cfg = record,
          isReceived = self._data.actInfo[actId].receivedList[v]
        })
      else
        LogErrorFormat("BM_CommonActivity", "CActiveMissionModReward No Have Id:%s", v)
      end
    end
  end
  return result
end

function BM_CommonActivity:GetProcessAwardNeedCurrencyId(actId)
  if self._data.actInfo[actId] then
    for _, v in ipairs(self._data.actInfo[actId].awardIdList) do
      local record = CActiveMissionModReward:GetRecorder(v)
      if record then
        return record.needItem
      else
        LogErrorFormat("BM_CommonActivity", "CActiveMissionModReward No Have Id:%s", v)
      end
    end
  end
end

function BM_CommonActivity:GetProcessAwardCfg(awardId, activeID)
  local record = CActiveMissionModReward:GetRecorder(awardId)
  if record and record.activeID == activeID then
    return record
  end
end

function BM_CommonActivity:FacePhotoTabRedDot(actId)
  if not self:GetIsOpen(actId) then
    return false
  end
end

function BM_CommonActivity:TaskTabRedDot(actId)
  if not self:GetIsOpen(actId) then
    return false
  end
  if self:HasTaskAward(actId) then
    return true
  end
  if self:HasProcessAward(actId) then
    return true
  end
end

function BM_CommonActivity:ShopTabRedDot(actId)
  if not self:GetIsOpen(actId) then
    return false
  end
  if self:HasFreeGood(actId) then
    return true
  end
end

function BM_CommonActivity:HasProcessAward(actId)
  if not self:GetIsOpen(actId) then
    return
  end
  local needCurrency = self:GetProcessAwardNeedCurrencyId(actId)
  local curNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(needCurrency)
  local awardList = self:GetProcessAwardCfgList(actId)
  for _, v in ipairs(awardList) do
    if not v.isReceived and curNum >= v.cfg.needNum then
      return v.cfg.id
    end
  end
end

function BM_CommonActivity:GetTaskList(actId)
  local taskType = self:GetActivityTaskTypeID(actId)
  return NekoData.BehaviorManager.BM_ActivityTasks:GetTasks(taskType)
end

function BM_CommonActivity:HasTaskAward(actId)
  local taskType = self:GetActivityTaskTypeID(actId)
  return NekoData.BehaviorManager.BM_ActivityTasks:HaveFinishedTask(taskType)
end

function BM_CommonActivity:HasFreeGood(actId)
  local shopId = self:GetActivityShopID(actId)
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(shopId) or {}
  local allFreeSoldOut = true
  for _, good in ipairs(shopData) do
    if good.discountPrice == 0 then
      allFreeSoldOut = true
      if good.goodRemain ~= 0 then
        allFreeSoldOut = false
        break
      end
    end
  end
  return not allFreeSoldOut
end

function BM_CommonActivity:GetShopGoodStyleCfg(actId)
  return CActiveShopModCfg:GetRecorder(actId)
end

function BM_CommonActivity:GetSkillSellTimeCfgList(actId)
  local result = {}
  for _, id in ipairs(CActiveSkinShop:GetAllIds()) do
    local record = CActiveSkinShop:GetRecorder(id)
    if record and record.activeID == actId then
      table.insert(result, {cfg = record})
    end
  end
  return result
end

return BM_CommonActivity
