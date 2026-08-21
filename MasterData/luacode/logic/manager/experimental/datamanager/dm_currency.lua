-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_currency.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Currency = class("DM_Currency")
local CNotice = (BeanManager.GetTableByName)("notice.cnotice")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
DM_Currency.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._currency = (NekoData.Data).currency
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._currency).spirit = nil
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._currency).deltaSpirit = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._currency).nextSpiritLeftTime = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Currency.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._currency).spirit = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._currency).deltaSpirit = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._currency).nextSpiritLeftTime = 0
  for key,value in pairs((self._currency).moneyInfo) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

    ((self._currency).moneyInfo)[key] = 0
  end
end

DM_Currency.OnSReqcoinnum = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  for moneyid,num in pairs(protocol.money) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    ((self._currency).moneyInfo)[moneyid] = num
  end
end

DM_Currency.OnSResSpirit = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CNotice, CSpirit
  local preDeltaSpirit = (self._currency).deltaSpirit
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._currency).spirit = protocol.spirit
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._currency).deltaSpirit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit - (self._currency).spirit
  local needNotification = ((NekoData.BehaviorManager).BM_Game):GetIfNeedSpriteFullNotification()
  if needNotification and preDeltaSpirit ~= (self._currency).deltaSpirit then
    local spiritNoticeRecorder = CNotice:GetRecorder(2)
    local lastTime = (self._currency).deltaSpirit * (CSpirit:GetRecorder(1)).time
    if lastTime > 0 then
      ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("spirit")
      LogInfoFormat("DM_Currency", "scheduling spirit full worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "spirit", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
      ;
      ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "spirit", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
    end
  end
  do
    -- DECOMPILER ERROR at PC86: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._currency).nextSpiritLeftTime = protocol.leftTime
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._currency).spiritRecoverTimes = protocol.recoverTimes
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._currency).moneyInfo)[DataCommon.SpiritID] = protocol.spirit
  end
end

DM_Currency.OnSRefreshLampStand = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self._currency).moneyInfo)[DataCommon.WhiteLight] = (protocol.lampStand).white
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._currency).moneyInfo)[DataCommon.DarkLight] = (protocol.lampStand).dark
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._currency).moneyInfo)[DataCommon.ColorLight] = (protocol.lampStand).mix
end

DM_Currency.OnSSpringSpirit = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self._currency).moneyInfo)[DataCommon.SpringFestivalFu] = protocol.spirit
end

DM_Currency.OnUpdate = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if (self._currency).nextSpiritLeftTime > 0 then
    (self._currency).nextSpiritLeftTime = (self._currency).nextSpiritLeftTime - (notification.userInfo).unscaledDeltaTime * 1000
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    if (self._currency).nextSpiritLeftTime <= 0 then
      (self._currency).deltaSpirit = (self._currency).deltaSpirit - 1
      local csend = (LuaNetManager.CreateProtocol)("protocol.item.creqspirit")
      csend:Send()
    end
  end
end

return DM_Currency

