local BM_SBattleStart = class("BM_SBattleStart")

function BM_SBattleStart:Ctor()
  self._sbattlestartinfo = NekoData.Data.sbattlestartinfo
end

function BM_SBattleStart:GetProtocol()
  return self._sbattlestartinfo.protocol
end

function BM_SBattleStart:GetBattleType()
  return self._sbattlestartinfo.protocol.battleType
end

function BM_SBattleStart:GetLineId()
  return self._sbattlestartinfo.protocol.lineId
end

function BM_SBattleStart:GetLeftRoleMap()
  return self._sbattlestartinfo.protocol.left
end

return BM_SBattleStart
