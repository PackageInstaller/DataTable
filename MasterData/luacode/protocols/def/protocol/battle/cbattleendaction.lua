local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBattleEndAction = dataclass("CBattleEndAction", require("framework.net.protocol"))
CBattleEndAction.ProtocolType = 1944
CBattleEndAction.MaxSize = 65535
CBattleEndAction.battleid = 0

function CBattleEndAction:Ctor(client)
  CBattleEndAction.super.Ctor(self, client)
end

function CBattleEndAction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleid) then
    return false
  end
  return true
end

function CBattleEndAction:Unmarshal(buffer)
  local ret = true
  ret, self.battleid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBattleEndAction
