local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BattleVerifyInfo = dataclass("BattleVerifyInfo")
BattleVerifyInfo.ptype = 0
BattleVerifyInfo.step = 0

function BattleVerifyInfo:Ctor()
  self.content = require("protocols.bean.protocol.battle.battleverifyproparam").Create()
end

function BattleVerifyInfo:Marshal(buffer)
  if not self.content:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ptype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.step) then
    return false
  end
  return true
end

function BattleVerifyInfo:Unmarshal(buffer)
  local ret = true
  if not self.content:Unmarshal(buffer) then
    return false
  end
  ret, self.ptype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.step = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BattleVerifyInfo
