local DM_Currency = class("DM_Currency")
local CNotice = BeanManager.GetTableByName("notice.cnotice")
local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")

function DM_Currency:Ctor()
  self._currency = NekoData.Data.currency
  self._currency.spirit = nil
  self._currency.deltaSpirit = 0
  self._currency.nextSpiritLeftTime = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Currency:Clear()
  self._currency.spirit = nil
  self._currency.deltaSpirit = 0
  self._currency.nextSpiritLeftTime = 0
  for key, value in pairs(self._currency.moneyInfo) do
    self._currency.moneyInfo[key] = 0
  end
end

function DM_Currency:OnSReqcoinnum(protocol)
  for moneyid, num in pairs(protocol.money) do
    self._currency.moneyInfo[moneyid] = num
  end
end

function DM_Currency:OnSResSpirit(protocol)
  local preDeltaSpirit = self._currency.deltaSpirit
  self._currency.spirit = protocol.spirit
  self._currency.deltaSpirit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit - self._currency.spirit
  local needNotification = NekoData.BehaviorManager.BM_Game:GetIfNeedSpriteFullNotification()
  if needNotification and preDeltaSpirit ~= self._currency.deltaSpirit then
    local spiritNoticeRecorder = CNotice:GetRecorder(2)
    local lastTime = self._currency.deltaSpirit * CSpirit:GetRecorder(1).time
    if 0 < lastTime then
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.CancelSchedulingWorkerByType("spirit")
      LogInfoFormat("DM_Currency", "scheduling spirit full worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "spirit", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), lastTime)
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "spirit", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), lastTime, TextManager.GetText(spiritNoticeRecorder.titleID))
    end
  end
  self._currency.nextSpiritLeftTime = protocol.leftTime
  self._currency.spiritRecoverTimes = protocol.recoverTimes
  self._currency.moneyInfo[DataCommon.SpiritID] = protocol.spirit
end

function DM_Currency:OnSRefreshLampStand(protocol)
  self._currency.moneyInfo[DataCommon.WhiteLight] = protocol.lampStand.white
  self._currency.moneyInfo[DataCommon.DarkLight] = protocol.lampStand.dark
  self._currency.moneyInfo[DataCommon.ColorLight] = protocol.lampStand.mix
end

function DM_Currency:OnSSpringSpirit(protocol)
  self._currency.moneyInfo[DataCommon.SpringFestivalFu] = protocol.spirit
end

function DM_Currency:OnUpdate(notification)
  if self._currency.nextSpiritLeftTime > 0 then
    self._currency.nextSpiritLeftTime = self._currency.nextSpiritLeftTime - notification.userInfo.unscaledDeltaTime * 1000
    if self._currency.nextSpiritLeftTime <= 0 then
      self._currency.deltaSpirit = self._currency.deltaSpirit - 1
      local csend = LuaNetManager.CreateProtocol("protocol.item.creqspirit")
      csend:Send()
    end
  end
end

return DM_Currency
