local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTransaction = dataclass("CTransaction", require("framework.net.protocol"))
CTransaction.ProtocolType = 1941
CTransaction.MaxSize = 65535
CTransaction.kind = 0
CTransaction.value = 0
CTransaction.GENERAL_EVENT = 1
CTransaction.VISIT_NPC = 2
CTransaction.DUNGEON_OPTION = 3

function CTransaction:Ctor(client)
  CTransaction.super.Ctor(self, client)
  self.eventInitPoint = require("protocols.bean.protocol.battle.point").Create()
end

function CTransaction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  if not self.eventInitPoint:Marshal(buffer) then
    return false
  end
  return true
end

function CTransaction:Unmarshal(buffer)
  local ret = true
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.eventInitPoint:Unmarshal(buffer) then
    return false
  end
  return ret
end

return CTransaction
