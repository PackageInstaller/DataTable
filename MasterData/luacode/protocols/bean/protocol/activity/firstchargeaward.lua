local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FirstChargeAward = dataclass("FirstChargeAward")
FirstChargeAward.id = 0
FirstChargeAward.statue = 0

function FirstChargeAward:Ctor()
end

function FirstChargeAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  return true
end

function FirstChargeAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.statue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return FirstChargeAward
