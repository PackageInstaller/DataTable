-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ctransaction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CTransaction = dataclass("CTransaction", require("framework.net.protocol"))
CTransaction.ProtocolType = 1941
CTransaction.MaxSize = 65535
CTransaction.kind = 0
CTransaction.value = 0
CTransaction.GENERAL_EVENT = 1
CTransaction.VISIT_NPC = 2
CTransaction.DUNGEON_OPTION = 3
CTransaction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CTransaction, _ENV
  ((CTransaction.super).Ctor)(self, client)
  self.eventInitPoint = ((require("protocols.bean.protocol.battle.point")).Create)()
end

CTransaction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.value) then
    return false
  end
  if not (self.eventInitPoint):Marshal(buffer) then
    return false
  end
  return true
end

CTransaction.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.eventInitPoint):Unmarshal(buffer) then
    return false
  end
  return ret
end

return CTransaction

