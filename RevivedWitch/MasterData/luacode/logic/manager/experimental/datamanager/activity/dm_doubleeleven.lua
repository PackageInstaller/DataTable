-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_doubleeleven.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_DoubleEleven = class("DM_DoubleEleven")
DM_DoubleEleven.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._doubleeleven = ((NekoData.Data).activities).doubleeleven
  self:Clear()
end

DM_DoubleEleven.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._doubleeleven).isOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._doubleeleven).startTime = -1
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._doubleeleven).endTime = -1
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._doubleeleven).cardPoolID = -1
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._doubleeleven).openCards = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._doubleeleven).freeReddot = false
end

DM_DoubleEleven.OnSSendDoubleElevenActivity = function(self, protocol)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._doubleeleven).isOpen = protocol.state ~= 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._doubleeleven).startTime = protocol.startTime
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._doubleeleven).endTime = protocol.endTime
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_DoubleEleven.OnSOpenDoubleElevenActivity = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._doubleeleven).cardPoolID = protocol.poolId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._doubleeleven).openCards = protocol.openCards
end

DM_DoubleEleven.OnSOpenDoubleElevenCard = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._doubleeleven).cardPoolID = protocol.poolId
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._doubleeleven).openCards)[protocol.position] = {itemId = (protocol.itemInfo).id, itemNum = (protocol.itemInfo).number}
end

DM_DoubleEleven.ClearCardsData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for key,_ in pairs((self._doubleeleven).openCards) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._doubleeleven).openCards)[key] = nil
  end
end

DM_DoubleEleven.OnSActivityShopRedDot = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._doubleeleven).freeReddot = true
end

return DM_DoubleEleven

