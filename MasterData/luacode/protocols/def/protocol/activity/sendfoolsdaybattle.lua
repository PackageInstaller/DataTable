local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEndFoolsDayBattle = dataclass("SEndFoolsDayBattle", require("framework.net.protocol"))
SEndFoolsDayBattle.ProtocolType = 2634
SEndFoolsDayBattle.MaxSize = 65535
SEndFoolsDayBattle.battleType = 0
SEndFoolsDayBattle.result = 0

function SEndFoolsDayBattle:Ctor(client)
  SEndFoolsDayBattle.super.Ctor(self, client)
end

function SEndFoolsDayBattle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SEndFoolsDayBattle:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SEndFoolsDayBattle
