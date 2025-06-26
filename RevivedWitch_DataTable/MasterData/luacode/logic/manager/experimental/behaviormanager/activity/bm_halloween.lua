-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_halloween.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Halloween = class("BM_Halloween")
BM_Halloween.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._halloween = ((NekoData.Data).activities).halloween
end

BM_Halloween.GetInitialRemainTime = function(self)
  -- function num : 0_1
  return (self._halloween).initialRemainTime
end

BM_Halloween.GetStartTime = function(self)
  -- function num : 0_2
  return (self._halloween).startTime
end

BM_Halloween.GetRemainTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return self:GetInitialRemainTime() - ((ServerGameTimer.GetServerTimeForecast)() - self:GetStartTime())
end

BM_Halloween.GetIsOpen = function(self)
  -- function num : 0_4
  return (self._halloween).isOpen
end

BM_Halloween.GetIsOpenTask = function(self)
  -- function num : 0_5
  return (self._halloween).isOpenTask
end

BM_Halloween.GetPumpkinReward = function(self)
  -- function num : 0_6
  return (self._halloween).pumpkinReward
end

BM_Halloween.GetPumpkinPieReward = function(self)
  -- function num : 0_7
  return (self._halloween).pumpkinPieReward, (self._halloween).pumpkinPieRewardItemOnceNum, (self._halloween).pumpkinPieRewardItemTotalNum
end

BM_Halloween.GetPumpkinExistsList = function(self)
  -- function num : 0_8
  return (self._halloween).pumpkinExistsList
end

BM_Halloween.GetPumpkinRefreshTime = function(self)
  -- function num : 0_9
  return (self._halloween).pumpkinRefreshTime
end

BM_Halloween.HalloweenShowRedDot = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local havePumpkinNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.Pumpkin)
  if (self._halloween).pumpkinReward then
    for key,value in pairs((self._halloween).pumpkinReward) do
      if value == 0 then
        local record = self:GetHalloweenAwardRecorder(key)
        if record and record.neednum <= havePumpkinNum then
          return true
        end
      end
    end
  end
  do
    return false
  end
end

BM_Halloween.ShowRedDot = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self:GetIsOpen() then
    return false
  end
  do return self:HalloweenShowRedDot() or (((NekoData.BehaviorManager).BM_ActivityTasks):HalloweenShowRedDot() and self:GetIsOpenTask()) or ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenHalloweenDialog) ~= nil or (((NekoData.BehaviorManager).BM_Shop):GetHalloweenRedPoint() == 1 and ((NekoData.BehaviorManager).BM_Shop):GetHalloweenShopOpenState() == 1) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Halloween.GetHalloweenAwardRecorder = function(self, needID)
  -- function num : 0_12 , upvalues : _ENV
  return (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.HalloweenActivityID)):GetHalloweenAwardRecorder(needID)
end

BM_Halloween.SendCClickPumpkin = function(self, pumpkinId)
  -- function num : 0_13 , upvalues : _ENV
  if not self:GetIsOpen() then
    return 
  end
  local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.cclickpumpkin")
  if protocolSend then
    protocolSend.pumpkinId = pumpkinId
    protocolSend:Send()
  end
end

BM_Halloween.GetPumpkinPieRewardSort = function(self, itemID)
  -- function num : 0_14 , upvalues : _ENV
  return (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.HalloweenActivityID)):GetPumpkinPieRewardSort(itemID)
end

return BM_Halloween

