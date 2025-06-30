-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_springfestival.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SpringFestival = class("DM_SpringFestival")
DM_SpringFestival.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).springfestival
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).recorder = ((BeanManager.GetTableByName)("activity.cbossnianrankap")):GetRecorder(1)
  self:Clear()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_SpringFestival.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).bossData = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).spirit = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).battleresult = {}
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

DM_SpringFestival.OnSSpringActivity = function(self, protocol)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).state = protocol.state
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).beginTime = protocol.beginTime
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).endTime = protocol.endTime
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).bossReward = protocol.bossReward
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).rankId = protocol.rankId
end

DM_SpringFestival.SSpringRedPacketActivity = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).redPacketIsOpen = protocol.state == 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).redPacketState = protocol.redPacketState
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).redPacketStateDay = protocol.day
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_SpringFestival.SGetSpringRedPacket = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._data).redPacketState)[protocol.redPacketType] = 1
end

DM_SpringFestival.SSpringBossState = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._data).bossData).bossList = {}
  for i,v in ipairs(protocol.bossList) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    (((self._data).bossData).bossList)[v.bossId] = v
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).bossData).score = protocol.score
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).bossData).rank = protocol.rank
end

DM_SpringFestival.SSpringSpirit = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._data).spirit).spirit = protocol.spirit
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).spirit).lefttime = protocol.lefttime
end

DM_SpringFestival.SReceiveSpringBossReward = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  if ((((self._data).bossData).bossList)[protocol.bossId]).state == 2 then
    ((((self._data).bossData).bossList)[protocol.bossId]).state = 3
  else
    LogError("SReceiveSpringBossReward", "boss状态错误！")
  end
  for k,v in pairs(((self._data).bossData).bossList) do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    if v.state == 2 then
      (self._data).bossRewardRedPoint = 1
      return 
    end
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).bossRewardRedPoint = 0
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshSpringFestivalRedDot)
end

DM_SpringFestival.OnSSpringSpirit = function(self, protocol)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._data).spirit).spirit = protocol.spirit
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).spirit).lefttime = protocol.lefttime
end

DM_SpringFestival.OnUpdate = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if ((self._data).spirit).lefttime and ((self._data).spirit).lefttime > 0 then
    ((self._data).spirit).lefttime = ((self._data).spirit).lefttime - (notification.userInfo).unscaledDeltaTime * 1000
    if ((self._data).spirit).lefttime <= 0 then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cspringspirit")
      csend:Send()
    end
  end
end

DM_SpringFestival.SSpringBattleResult = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._data).battleresult).bossId = protocol.bossId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).battleresult).stage = protocol.stage
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).battleresult).score = protocol.score
end

DM_SpringFestival.SSpringBossRewardRedPoint = function(self, protocol)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).bossRewardRedPoint = protocol.show
end

DM_SpringFestival.OnSSendSpringShopActivity = function(self, protocol)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).springShopIsOpen = protocol.state == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return DM_SpringFestival

