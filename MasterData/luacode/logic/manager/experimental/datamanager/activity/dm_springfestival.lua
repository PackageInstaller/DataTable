local DM_SpringFestival = class("DM_SpringFestival")

function DM_SpringFestival:Ctor()
  self._data = NekoData.Data.activities.springfestival
  self._data.recorder = BeanManager.GetTableByName("activity.cbossnianrankap"):GetRecorder(1)
  self:Clear()
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_SpringFestival:Clear()
  self._data.bossData = {}
  self._data.spirit = {}
  self._data.battleresult = {}
  LuaNotificationCenter.RemoveObserver(self)
end

function DM_SpringFestival:OnSSpringActivity(protocol)
  self._data.state = protocol.state
  self._data.beginTime = protocol.beginTime
  self._data.endTime = protocol.endTime
  self._data.bossReward = protocol.bossReward
  self._data.rankId = protocol.rankId
end

function DM_SpringFestival:SSpringRedPacketActivity(protocol)
  self._data.redPacketIsOpen = protocol.state == 1
  self._data.redPacketState = protocol.redPacketState
  self._data.redPacketStateDay = protocol.day
end

function DM_SpringFestival:SGetSpringRedPacket(protocol)
  self._data.redPacketState[protocol.redPacketType] = 1
end

function DM_SpringFestival:SSpringBossState(protocol)
  self._data.bossData.bossList = {}
  for i, v in ipairs(protocol.bossList) do
    self._data.bossData.bossList[v.bossId] = v
  end
  self._data.bossData.score = protocol.score
  self._data.bossData.rank = protocol.rank
end

function DM_SpringFestival:SSpringSpirit(protocol)
  self._data.spirit.spirit = protocol.spirit
  self._data.spirit.lefttime = protocol.lefttime
end

function DM_SpringFestival:SReceiveSpringBossReward(protocol)
  if self._data.bossData.bossList[protocol.bossId].state == 2 then
    self._data.bossData.bossList[protocol.bossId].state = 3
  else
    LogError("SReceiveSpringBossReward", "boss状态错误！")
  end
  for k, v in pairs(self._data.bossData.bossList) do
    if v.state == 2 then
      self._data.bossRewardRedPoint = 1
      return
    end
  end
  self._data.bossRewardRedPoint = 0
  LuaNotificationCenter.PostNotification(Common.n_RefreshSpringFestivalRedDot)
end

function DM_SpringFestival:OnSSpringSpirit(protocol)
  self._data.spirit.spirit = protocol.spirit
  self._data.spirit.lefttime = protocol.lefttime
end

function DM_SpringFestival:OnUpdate(notification)
  if self._data.spirit.lefttime and self._data.spirit.lefttime > 0 then
    self._data.spirit.lefttime = self._data.spirit.lefttime - notification.userInfo.unscaledDeltaTime * 1000
    if self._data.spirit.lefttime <= 0 then
      local csend = LuaNetManager.CreateProtocol("protocol.activity.cspringspirit")
      csend:Send()
    end
  end
end

function DM_SpringFestival:SSpringBattleResult(protocol)
  self._data.battleresult.bossId = protocol.bossId
  self._data.battleresult.stage = protocol.stage
  self._data.battleresult.score = protocol.score
end

function DM_SpringFestival:SSpringBossRewardRedPoint(protocol)
  self._data.bossRewardRedPoint = protocol.show
end

function DM_SpringFestival:OnSSendSpringShopActivity(protocol)
  self._data.springShopIsOpen = protocol.state == 1
end

return DM_SpringFestival
