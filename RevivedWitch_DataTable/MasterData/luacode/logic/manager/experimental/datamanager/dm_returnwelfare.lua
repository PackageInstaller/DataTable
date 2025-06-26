-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_returnwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_ReturnWelfare = class("DM_ReturnWelfare")
DM_ReturnWelfare.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).returnWelfare
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).returnBattlePass = nil
  self._timeCheck = 1
  self._timeCount = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_ReturnWelfare.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).backInviteProtocol = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).backTaskRewardProtocol = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).openBackPackProtocol = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).openBackGiftProtocol = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).returnBattlePass = nil
end

DM_ReturnWelfare.OnSOpenBackInvite = function(self, protocol)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).backInviteProtocol = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).backInviteProtocol).userInfo = protocol
end

DM_ReturnWelfare.OnSRefreshReward = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).backTaskRewardProtocol = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).backTaskRewardProtocol).userInfo = protocol
end

DM_ReturnWelfare.OnSOpenBackPack = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).openBackPackProtocol = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).openBackPackProtocol).userInfo = protocol
end

DM_ReturnWelfare.OnSOpenBackGift = function(self, protocol)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).openBackGiftProtocol = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).openBackGiftProtocol).userInfo = protocol
end

DM_ReturnWelfare.OnSReturnPass = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).returnBattlePass = protocol
end

DM_ReturnWelfare.OnUpdate = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  if (self._data).returnBattlePass and ((self._data).returnBattlePass).leftTime >= 0 then
    self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
    if self._timeCount < self._timeCheck then
      return 
    end
    local check = self._timeCheck
    if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
      check = (math.ceil)(self._timeCount)
    end
    self._timeCount = self._timeCount - check
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._data).returnBattlePass).leftTime = ((self._data).returnBattlePass).leftTime - check * 1000
  end
end

return DM_ReturnWelfare

