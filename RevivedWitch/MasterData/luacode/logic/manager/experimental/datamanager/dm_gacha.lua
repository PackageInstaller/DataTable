-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_gacha.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Gacha = class("DM_Gacha")
DM_Gacha.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._gacha = (NekoData.Data).gacha
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).pools = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).convertItems = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).drawTimes = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).baodiNum = -1
end

DM_Gacha.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while ((self._gacha).pools)[#(self._gacha).pools] do
    (table.remove)((self._gacha).pools, #(self._gacha).pools)
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).convertItems = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).drawTimes = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gacha).baodiNum = -1
end

DM_Gacha.OnSRefreshCardui = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  while ((self._gacha).pools)[#(self._gacha).pools] do
    (table.remove)((self._gacha).pools, #(self._gacha).pools)
  end
  for k,v in pairs(protocol.pools) do
    local pool = {}
    pool.id = k
    pool.value = v
    ;
    (table.insert)((self._gacha).pools, pool)
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gacha).drawTimes = protocol.drawTimes
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gacha).curDayTimes = protocol.curDayTimes
end

DM_Gacha.OnSUpdateCardPools = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  while ((self._gacha).pools)[#(self._gacha).pools] do
    (table.remove)((self._gacha).pools, #(self._gacha).pools)
  end
  for k,v in pairs(protocol.pools) do
    local pool = {}
    pool.id = k
    pool.value = v
    ;
    (table.insert)((self._gacha).pools, pool)
  end
end

DM_Gacha.OnSDrawCard = function(self, items, baodiNum, shareState, curDayTimes)
  -- function num : 0_4 , upvalues : _ENV
  for _,v in ipairs(items) do
    local flag = true
    for _,w in ipairs((self._gacha).convertItems) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    do
      do
        if flag then
          (table.insert)((self._gacha).convertItems, v)
        end
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gacha).baodiNum = baodiNum
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gacha).shareState = shareState
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gacha).curDayTimes = curDayTimes
end

DM_Gacha.OnSBeforeDrawCard = function(self, baodiNum, shareState)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._gacha).baodiNum = baodiNum
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gacha).shareState = shareState
end

DM_Gacha.OnSCommonGainRole = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in ipairs(protocol.crystals) do
    local flag = true
    for _,w in ipairs((self._gacha).convertItems) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    do
      do
        if flag then
          (table.insert)((self._gacha).convertItems, v)
        end
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local itemList = {}
  for _,v in ipairs(protocol.items) do
    local flag = true
    for _,w in ipairs(itemList) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    do
      do
        if flag then
          (table.insert)(itemList, v)
        end
        -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for i,v in ipairs(itemList) do
    (table.insert)((self._gacha).convertItems, v)
  end
end

DM_Gacha.SBeforeDrawCard = function(self, drawTimes)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gacha).drawTimes = drawTimes
end

return DM_Gacha

