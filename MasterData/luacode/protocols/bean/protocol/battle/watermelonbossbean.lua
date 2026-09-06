local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local WatermelonBossBean = dataclass("WatermelonBossBean")
WatermelonBossBean.id = 0
WatermelonBossBean.status = 0
WatermelonBossBean.damage = 0
WatermelonBossBean.rank = 0
WatermelonBossBean.awardStatue = 0

function WatermelonBossBean:Ctor()
end

function WatermelonBossBean:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.damage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardStatue) then
    return false
  end
  return true
end

function WatermelonBossBean:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.damage = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.awardStatue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return WatermelonBossBean
