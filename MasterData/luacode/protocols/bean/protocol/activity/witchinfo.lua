local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local WitchInfo = dataclass("WitchInfo")
WitchInfo.witchLv = 0
WitchInfo.upLvAble = 0

function WitchInfo:Ctor()
end

function WitchInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.witchLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.upLvAble) then
    return false
  end
  return true
end

function WitchInfo:Unmarshal(buffer)
  local ret = true
  ret, self.witchLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.upLvAble = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return WitchInfo
