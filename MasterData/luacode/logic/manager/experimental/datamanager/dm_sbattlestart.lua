local DM_SBattleStart = class("DM_SBattleStart")

function DM_SBattleStart:Ctor()
  self._sbattlestartinfo = NekoData.Data.sbattlestartinfo
  self._sbattlestartinfo.protocol = {}
end

function DM_SBattleStart:Clear()
  for k, v in pairs(self._sbattlestartinfo.protocol) do
    self._sbattlestartinfo.protocol[k] = nil
  end
end

function DM_SBattleStart:OnSBattleStart(protocol, type)
  self:Clear()
  self._sbattlestartinfo.protocol = protocol
  LuaNotificationCenter.PostNotification(Common.n_BattleStart)
end

return DM_SBattleStart
