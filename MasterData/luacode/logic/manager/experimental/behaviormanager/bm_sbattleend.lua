local BM_SBattleEnd = class("BM_SBattleEnd")

function BM_SBattleEnd:Ctor()
  self._sbattleendinfo = NekoData.Data.sbattleendinfo
end

function BM_SBattleEnd:GetProtocol()
  return self._sbattleendinfo.protocol
end

function BM_SBattleEnd:GetBattleId()
  if self._sbattleendinfo.protocol.battleResult then
    return self._sbattleendinfo.protocol.battleResult.battleId
  end
end

function BM_SBattleEnd:GetBattleResult()
  if self._sbattleendinfo.protocol.battleResult then
    return self._sbattleendinfo.protocol.battleResult.result
  end
end

function BM_SBattleEnd:GetID()
  return self._sbattleendinfo.protocol.id
end

function BM_SBattleEnd:GetFailTimes()
  if self._sbattleendinfo.protocol.battleResult then
    return self._sbattleendinfo.protocol.battleResult.failTime
  end
end

function BM_SBattleEnd:GetBattleType()
  return self._sbattleendinfo.protocol.battleType
end

return BM_SBattleEnd
