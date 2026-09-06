local DM_SBattleEnd = class("DM_SBattleEnd")

function DM_SBattleEnd:Ctor()
  self._sbattleendinfo = NekoData.Data.sbattleendinfo
  self._sbattleendinfo.protocol = {}
end

function DM_SBattleEnd:Clear()
  for k, v in pairs(self._sbattleendinfo.protocol) do
    self._sbattleendinfo.protocol[k] = nil
  end
end

function DM_SBattleEnd:OnSBattleEnd(protocol)
  self:Clear()
  self._sbattleendinfo.protocol = protocol
end

return DM_SBattleEnd
