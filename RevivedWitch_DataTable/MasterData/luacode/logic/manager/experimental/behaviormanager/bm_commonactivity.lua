-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_commonactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local CActiveMainModCfg = (BeanManager.GetTableByName)("activity.cactivemainmodcfg")
local CActiveMissionModReward = (BeanManager.GetTableByName)("mission.cactivemissionmodreward")
local CActiveShopModCfg = (BeanManager.GetTableByName)("activity.cactiveshopmodcfg")
local CActiveSkinShop = (BeanManager.GetTableByName)("activity.cactiveskinshop")
local BM_CommonActivity = class("BM_CommonActivity")
BM_CommonActivity.TabType = {Task = 1, Shop = 2, FacePhoto = 3}
BM_CommonActivity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).taskshopactivity
end

BM_CommonActivity.GetIsOpen = function(self, actId)
  -- function num : 0_1
  if not ((self._data).actInfo)[actId] then
    return false
  end
  if (((self._data).actInfo)[actId]).leftTime <= 0 then
    return false
  end
  return true
end

BM_CommonActivity.GetActInfoInfo = function(self, actId)
  -- function num : 0_2
  return ((self._data).actInfo)[actId]
end

BM_CommonActivity.ShowRedDot = function(self, actId)
  -- function num : 0_3 , upvalues : _ENV
  if self:GetIsOpen(actId) then
    local subTabTypeCfgList = self:GetSubtabTypeCfgList(actId)
    for _,v in ipairs(subTabTypeCfgList) do
      if self:GetRedDot(actId, (v.cfg).tabType) then
        return true
      end
    end
  end
end

BM_CommonActivity.GetRedDot = function(self, actId, tabType)
  -- function num : 0_4 , upvalues : BM_CommonActivity, _ENV
  if tabType == (BM_CommonActivity.TabType).Task then
    if self:HasTaskAward(actId) then
      return true
    end
    if self:HasProcessAward(actId) then
      return true
    end
  else
    if tabType == (BM_CommonActivity.TabType).Shop and self:HasFreeGood() then
      return true
    end
  end
  if tabType == (BM_CommonActivity.TabType).FacePhoto then
    LogErrorFormat("BM_CommonActivity", "Unhandled Tab Type: %s", tabType)
  end
end

BM_CommonActivity.GetActivityShopID = function(self, actId)
  -- function num : 0_5 , upvalues : _ENV
  local result = ((DataCommon.CommonActivity).Shop).ShopId
  return result
end

BM_CommonActivity.GetActivityTaskTypeID = function(self, actId)
  -- function num : 0_6 , upvalues : CActivityTasks
  local result = CActivityTasks.TASK_SHOP
  return result
end

BM_CommonActivity.IsShopTabType = function(self, tabType)
  -- function num : 0_7 , upvalues : BM_CommonActivity
  if tabType == (BM_CommonActivity.TabType).Shop then
    return true
  end
end

BM_CommonActivity.GetPageName = function(self, tabType)
  -- function num : 0_8 , upvalues : BM_CommonActivity
  if tabType == (BM_CommonActivity.TabType).FacePhoto then
    return "activity.activitycommon.mainpage"
  else
    if tabType == (BM_CommonActivity.TabType).Task then
      return "activity.activitycommon.taskpage"
    else
      if tabType == (BM_CommonActivity.TabType).Shop then
        return "activity.activitycommon.shopmainpage"
      end
    end
  end
end

BM_CommonActivity.OpenActivityDialog = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  if id == 0 then
    return 
  end
  if self:GetIsOpen(id) then
    local dialog = (DialogManager.CreateSingletonDialog)("activity.activitycommon.maindialog")
    dialog:SetData(id)
  end
end

BM_CommonActivity.GetSubtabTypeCfgList = function(self, actId)
  -- function num : 0_10 , upvalues : _ENV, CActiveMainModCfg
  local result = {}
  for _,v in ipairs(CActiveMainModCfg:GetAllIds()) do
    local record = CActiveMainModCfg:GetRecorder(v)
    if tonumber(record.activeID) == actId then
      (table.insert)(result, {cfg = record, reddot = self:GetRedDot(actId, record.tabType)})
    end
  end
  ;
  (table.sort)(result, function(a, b)
    -- function num : 0_10_0
    do return (b.cfg).tabSort < (a.cfg).tabSort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(result) do
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

    (result[i]).id = i
  end
  return result
end

BM_CommonActivity.GetProcessAwardCfgList = function(self, actId)
  -- function num : 0_11 , upvalues : _ENV, CActiveMissionModReward
  local result = {}
  if ((self._data).actInfo)[actId] then
    for _,v in ipairs((((self._data).actInfo)[actId]).awardIdList) do
      local record = CActiveMissionModReward:GetRecorder(v)
      if record then
        (table.insert)(result, {cfg = record, isReceived = ((((self._data).actInfo)[actId]).receivedList)[v]})
      else
        LogErrorFormat("BM_CommonActivity", "CActiveMissionModReward No Have Id:%s", v)
      end
    end
  end
  do
    return result
  end
end

BM_CommonActivity.GetProcessAwardNeedCurrencyId = function(self, actId)
  -- function num : 0_12 , upvalues : _ENV, CActiveMissionModReward
  if ((self._data).actInfo)[actId] then
    for _,v in ipairs((((self._data).actInfo)[actId]).awardIdList) do
      local record = CActiveMissionModReward:GetRecorder(v)
      if record then
        return record.needItem
      else
        LogErrorFormat("BM_CommonActivity", "CActiveMissionModReward No Have Id:%s", v)
      end
    end
  end
end

BM_CommonActivity.GetProcessAwardCfg = function(self, awardId, activeID)
  -- function num : 0_13 , upvalues : CActiveMissionModReward
  local record = CActiveMissionModReward:GetRecorder(awardId)
  if record and record.activeID == activeID then
    return record
  end
end

BM_CommonActivity.FacePhotoTabRedDot = function(self, actId)
  -- function num : 0_14
  if not self:GetIsOpen(actId) then
    return false
  end
end

BM_CommonActivity.TaskTabRedDot = function(self, actId)
  -- function num : 0_15
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

BM_CommonActivity.ShopTabRedDot = function(self, actId)
  -- function num : 0_16
  if not self:GetIsOpen(actId) then
    return false
  end
  if self:HasFreeGood(actId) then
    return true
  end
end

BM_CommonActivity.HasProcessAward = function(self, actId)
  -- function num : 0_17 , upvalues : _ENV
  if not self:GetIsOpen(actId) then
    return 
  end
  local needCurrency = self:GetProcessAwardNeedCurrencyId(actId)
  local curNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(needCurrency)
  local awardList = self:GetProcessAwardCfgList(actId)
  for _,v in ipairs(awardList) do
    if not v.isReceived and (v.cfg).needNum <= curNum then
      return (v.cfg).id
    end
  end
end

BM_CommonActivity.GetTaskList = function(self, actId)
  -- function num : 0_18 , upvalues : _ENV
  local taskType = self:GetActivityTaskTypeID(actId)
  return ((NekoData.BehaviorManager).BM_ActivityTasks):GetTasks(taskType)
end

BM_CommonActivity.HasTaskAward = function(self, actId)
  -- function num : 0_19 , upvalues : _ENV
  local taskType = self:GetActivityTaskTypeID(actId)
  return ((NekoData.BehaviorManager).BM_ActivityTasks):HaveFinishedTask(taskType)
end

BM_CommonActivity.HasFreeGood = function(self, actId)
  -- function num : 0_20 , upvalues : _ENV
  local shopId = self:GetActivityShopID(actId)
  if not ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(shopId) then
    local shopData = {}
  end
  local allFreeSoldOut = true
  for _,good in ipairs(shopData) do
    if good.discountPrice == 0 then
      allFreeSoldOut = true
      if good.goodRemain ~= 0 then
        allFreeSoldOut = false
        break
      end
    end
  end
  do
    return not allFreeSoldOut
  end
end

BM_CommonActivity.GetShopGoodStyleCfg = function(self, actId)
  -- function num : 0_21 , upvalues : CActiveShopModCfg
  return CActiveShopModCfg:GetRecorder(actId)
end

BM_CommonActivity.GetSkillSellTimeCfgList = function(self, actId)
  -- function num : 0_22 , upvalues : _ENV, CActiveSkinShop
  local result = {}
  for _,id in ipairs(CActiveSkinShop:GetAllIds()) do
    local record = CActiveSkinShop:GetRecorder(id)
    if record and record.activeID == actId then
      (table.insert)(result, {cfg = record})
    end
  end
  return result
end

return BM_CommonActivity

