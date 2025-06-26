-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_dragonboatfestival.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_DragonBoatFestival = class("DM_DragonBoatFestival")
DM_DragonBoatFestival.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._dragonboatfestival = ((NekoData.Data).activities).dragonboatfestival
  self:Clear()
end

DM_DragonBoatFestival.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._dragonboatfestival).isOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).totalRemainTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).startTime = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).wishIsOpen = false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).shopIsOpen = false
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).redDotList = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).currPoolId = -1
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dragonboatfestival).currPoolItem = {}
end

DM_DragonBoatFestival.OnSDragonBoatFestivalInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._dragonboatfestival).isOpen = protocol.actOpen ~= 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).totalRemainTime = protocol.leftTime
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).startTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).wishIsOpen = protocol.wishOpen ~= 0
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).shopIsOpen = protocol.shopOpen ~= 0
  for key,_ in pairs((self._dragonboatfestival).redDotList) do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

    ((self._dragonboatfestival).redDotList)[key] = nil
  end
  for _,value in pairs(protocol.redpoint) do
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ((self._dragonboatfestival).redDotList)[value] = true
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DM_DragonBoatFestival.OnSDragonBoatFestivalWish = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._dragonboatfestival).minPoolId = math.maxinteger
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).maxPoolId = math.mininteger
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).poolIds = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dragonboatfestival).currPoolId = protocol.currPoolId
  for key,_ in pairs((self._dragonboatfestival).currPoolItem) do
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

    ((self._dragonboatfestival).currPoolItem)[key] = nil
  end
  for _,value in ipairs(protocol.dragonBoatItemPool) do
    local tmpPoolTbl = {}
    for index2,value2 in ipairs(value.itemId) do
      local tmpTable = {}
      tmpTable.itemId = value2
      tmpTable.itemNum = (value.itemNum)[index2]
      tmpTable.isGet = tmpTable.itemNum == 0
      ;
      (table.insert)(tmpPoolTbl, tmpTable)
    end
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._dragonboatfestival).currPoolItem)[value.poolId] = tmpPoolTbl
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'

    if (self._dragonboatfestival).maxPoolId < value.poolId then
      (self._dragonboatfestival).maxPoolId = value.poolId
    end
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R8 in 'UnsetPending'

    if value.poolId < (self._dragonboatfestival).minPoolId then
      (self._dragonboatfestival).minPoolId = value.poolId
    end
    ;
    (table.insert)((self._dragonboatfestival).poolIds, value.poolId)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

return DM_DragonBoatFestival

