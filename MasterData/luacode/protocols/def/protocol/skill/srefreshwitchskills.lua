local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshWitchSkills = dataclass("SRefreshWitchSkills", require("framework.net.protocol"))
SRefreshWitchSkills.ProtocolType = 2106
SRefreshWitchSkills.MaxSize = 65535

function SRefreshWitchSkills:Ctor(client)
  SRefreshWitchSkills.super.Ctor(self, client)
  self.changedSkills = {}
end

function SRefreshWitchSkills:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.changedSkills)) then
    return false
  end
  for key, value in pairs(self.changedSkills) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt16(buffer, value) then
      return false
    end
  end
  return true
end

function SRefreshWitchSkills:Unmarshal(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt16(buffer)
    if not ret then
      return ret
    end
    self.changedSkills[key] = value
  end
  return ret
end

return SRefreshWitchSkills
