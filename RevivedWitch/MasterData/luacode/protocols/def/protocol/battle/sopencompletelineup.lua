-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sopencompletelineup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenCompleteLineup = dataclass("SOpenCompleteLineup", require("framework.net.protocol"))
SOpenCompleteLineup.ProtocolType = 4125
SOpenCompleteLineup.MaxSize = 65535
SOpenCompleteLineup.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenCompleteLineup
  ((SOpenCompleteLineup.super).Ctor)(self, client)
  self.completeLineups = {}
end

SOpenCompleteLineup.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.completeLineups)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.completeLineups)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SOpenCompleteLineup.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.completeLineups)[i] = ((require("protocols.bean.protocol.battle.completelineup")).Create)()
    if not ((self.completeLineups)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenCompleteLineup

