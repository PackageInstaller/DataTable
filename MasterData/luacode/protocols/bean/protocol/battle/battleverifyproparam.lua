local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BattleVerifyProParam = dataclass("BattleVerifyProParam")
BattleVerifyProParam.entityId = 0
BattleVerifyProParam.skillid = 0
BattleVerifyProParam.gmresult = 0

function BattleVerifyProParam:Ctor()
end

function BattleVerifyProParam:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.entityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gmresult) then
    return false
  end
  return true
end

function BattleVerifyProParam:Unmarshal(buffer)
  local ret = true
  ret, self.entityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skillid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.gmresult = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BattleVerifyProParam
