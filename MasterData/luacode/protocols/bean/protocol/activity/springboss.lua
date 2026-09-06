local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SpringBoss = dataclass("SpringBoss")
SpringBoss.bossId = 0
SpringBoss.bloodVolume = 0
SpringBoss.state = 0
SpringBoss.UNLOCK = 0
SpringBoss.PROCESS = 1
SpringBoss.DEFEAT = 2
SpringBoss.OPENBOX = 3

function SpringBoss:Ctor()
end

function SpringBoss:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bloodVolume) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SpringBoss:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bloodVolume = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SpringBoss
