local DM_ReturnWelfare = class("DM_ReturnWelfare")

function DM_ReturnWelfare:Ctor()
  self._data = NekoData.Data.returnWelfare
  self._data.returnBattlePass = nil
  self._timeCheck = 1
  self._timeCount = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_ReturnWelfare:Clear()
  self._data.backInviteProtocol = {}
  self._data.backTaskRewardProtocol = {}
  self._data.openBackPackProtocol = {}
  self._data.openBackGiftProtocol = {}
  self._data.returnBattlePass = nil
end

function DM_ReturnWelfare:OnSOpenBackInvite(protocol)
  self._data.backInviteProtocol = {}
  self._data.backInviteProtocol.userInfo = protocol
end

function DM_ReturnWelfare:OnSRefreshReward(protocol)
  self._data.backTaskRewardProtocol = {}
  self._data.backTaskRewardProtocol.userInfo = protocol
end

function DM_ReturnWelfare:OnSOpenBackPack(protocol)
  self._data.openBackPackProtocol = {}
  self._data.openBackPackProtocol.userInfo = protocol
end

function DM_ReturnWelfare:OnSOpenBackGift(protocol)
  self._data.openBackGiftProtocol = {}
  self._data.openBackGiftProtocol.userInfo = protocol
end

function DM_ReturnWelfare:OnSReturnPass(protocol)
  self._data.returnBattlePass = protocol
end

function DM_ReturnWelfare:OnUpdate(notification)
  if self._data.returnBattlePass and self._data.returnBattlePass.leftTime >= 0 then
    self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
    if self._timeCount < self._timeCheck then
      return
    end
    local check = self._timeCheck
    if notification.userInfo.unscaledDeltaTime > self._timeCheck then
      check = math.ceil(self._timeCount)
    end
    self._timeCount = self._timeCount - check
    self._data.returnBattlePass.leftTime = self._data.returnBattlePass.leftTime - check * 1000
  end
end

return DM_ReturnWelfare
