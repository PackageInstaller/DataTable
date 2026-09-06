local BM_Halloween = class("BM_Halloween")

function BM_Halloween:Ctor()
  self._halloween = NekoData.Data.activities.halloween
end

function BM_Halloween:GetInitialRemainTime()
  return self._halloween.initialRemainTime
end

function BM_Halloween:GetStartTime()
  return self._halloween.startTime
end

function BM_Halloween:GetRemainTime()
  return self:GetInitialRemainTime() - (ServerGameTimer.GetServerTimeForecast() - self:GetStartTime())
end

function BM_Halloween:GetIsOpen()
  return self._halloween.isOpen
end

function BM_Halloween:GetIsOpenTask()
  return self._halloween.isOpenTask
end

function BM_Halloween:GetPumpkinReward()
  return self._halloween.pumpkinReward
end

function BM_Halloween:GetPumpkinPieReward()
  return self._halloween.pumpkinPieReward, self._halloween.pumpkinPieRewardItemOnceNum, self._halloween.pumpkinPieRewardItemTotalNum
end

function BM_Halloween:GetPumpkinExistsList()
  return self._halloween.pumpkinExistsList
end

function BM_Halloween:GetPumpkinRefreshTime()
  return self._halloween.pumpkinRefreshTime
end

function BM_Halloween:HalloweenShowRedDot()
  local havePumpkinNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Pumpkin)
  if self._halloween.pumpkinReward then
    for key, value in pairs(self._halloween.pumpkinReward) do
      if value == 0 then
        local record = self:GetHalloweenAwardRecorder(key)
        if record and havePumpkinNum >= record.neednum then
          return true
        end
      end
    end
  end
  return false
end

function BM_Halloween:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:HalloweenShowRedDot() or NekoData.BehaviorManager.BM_ActivityTasks:HalloweenShowRedDot() and self:GetIsOpenTask() or NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenHalloweenDialog) ~= nil or NekoData.BehaviorManager.BM_Shop:GetHalloweenRedPoint() == 1 and NekoData.BehaviorManager.BM_Shop:GetHalloweenShopOpenState() == 1
end

function BM_Halloween:GetHalloweenAwardRecorder(needID)
  return NekoData.DataManager.DM_Activity:GetManager(DataCommon.HalloweenActivityID):GetHalloweenAwardRecorder(needID)
end

function BM_Halloween:SendCClickPumpkin(pumpkinId)
  if not self:GetIsOpen() then
    return
  end
  local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.cclickpumpkin")
  if protocolSend then
    protocolSend.pumpkinId = pumpkinId
    protocolSend:Send()
  end
end

function BM_Halloween:GetPumpkinPieRewardSort(itemID)
  return NekoData.DataManager.DM_Activity:GetManager(DataCommon.HalloweenActivityID):GetPumpkinPieRewardSort(itemID)
end

return BM_Halloween
