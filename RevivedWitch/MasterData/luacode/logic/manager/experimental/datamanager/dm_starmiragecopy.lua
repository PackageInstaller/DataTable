-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_starmiragecopy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_CopyBase = require("logic.manager.experimental.datamanager.dm_copybase")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CStarrymirrorfuncunlock = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorfuncunlock")
local DM_StarMirageCopy = class("DM_StarMirageCopy", DM_CopyBase)
DM_StarMirageCopy.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : _ENV, CStarrymirrorlevel, CStarrymirrorfuncunlock, DM_StarMirageCopy
  self._data = (NekoData.Data).starMirageCopy
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).baseData = {}
  local other = {LevelCfg = CStarrymirrorlevel, FunctionUnlockCfg = CStarrymirrorfuncunlock, Type = ((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Type, Function = ((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Function}
  ;
  ((DM_StarMirageCopy.super).Ctor)(self, (self._data).baseData, other)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).dailySupplyData = nil
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).accumulateRewardList = {}
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).accumulatePoints = {}
end

DM_StarMirageCopy.Clear = function(self)
  -- function num : 0_1 , upvalues : DM_StarMirageCopy, _ENV
  ((DM_StarMirageCopy.super).Clear)(self)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dailySupplyData = nil
  while ((self._data).accumulateRewardList)[#(self._data).accumulateRewardList] do
    (table.remove)((self._data).accumulateRewardList, #(self._data).accumulateRewardList)
  end
  for k,v in pairs((self._data).accumulatePoints) do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data).accumulatePoints)[k] = nil
  end
end

DM_StarMirageCopy.OnSActivityDailySupply = function(self, protocol)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).dailySupplyData = protocol.supply
end

DM_StarMirageCopy.OnSGetPointsCollection = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  while ((self._data).accumulateRewardList)[#(self._data).accumulateRewardList] do
    (table.remove)((self._data).accumulateRewardList, #(self._data).accumulateRewardList)
  end
  for i,v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirageCopy", "-OnSGetPointsCollection- stageId = %s, status = %s ---", v.id, v.status)
    local data = {}
    data.stageId = v.id
    data.status = v.status
    ;
    (table.insert)((self._data).accumulateRewardList, data)
  end
  for k,v in pairs(protocol.points) do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).accumulatePoints)[k] = v
    LogInfoFormat("DM_StarMirageCopy", "-OnSGetPointsCollection- itemId = %s, num = %s ---", k, v)
  end
end

DM_StarMirageCopy.OnSRefreshPointsTasks = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirageCopy", "-OnSRefreshPointsTasks- stageId = %s, status = %s ---", v.id, v.status)
    for _,data in ipairs((self._data).accumulateRewardList) do
      if v.id == data.stageId then
        data.status = v.status
      end
    end
  end
end

return DM_StarMirageCopy

