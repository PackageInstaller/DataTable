local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartFoolsDayBattle = dataclass("CStartFoolsDayBattle", require("framework.net.protocol"))
CStartFoolsDayBattle.ProtocolType = 2633
CStartFoolsDayBattle.MaxSize = 65535
CStartFoolsDayBattle.battleType = 0
CStartFoolsDayBattle.battleId = 0
CStartFoolsDayBattle.COPY_BATTLE = 1
CStartFoolsDayBattle.FLOOR = 2

function CStartFoolsDayBattle:Ctor(client)
  CStartFoolsDayBattle.super.Ctor(self, client)
end

function CStartFoolsDayBattle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleId) then
    return false
  end
  return true
end

function CStartFoolsDayBattle:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartFoolsDayBattle
