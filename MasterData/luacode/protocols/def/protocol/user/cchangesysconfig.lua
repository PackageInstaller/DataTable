local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeSysConfig = dataclass("CChangeSysConfig", require("framework.net.protocol"))
CChangeSysConfig.ProtocolType = 2241
CChangeSysConfig.MaxSize = 65535

function CChangeSysConfig:Ctor(client)
  CChangeSysConfig.super.Ctor(self, client)
  self.configs = {}
end

function CChangeSysConfig:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.configs)) then
    return false
  end
  for key, value in pairs(self.configs) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CChangeSysConfig:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.configs[key] = value
  end
  return ret
end

return CChangeSysConfig
