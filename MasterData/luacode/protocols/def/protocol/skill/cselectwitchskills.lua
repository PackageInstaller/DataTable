local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSelectWitchSkills = dataclass("CSelectWitchSkills", require("framework.net.protocol"))
CSelectWitchSkills.ProtocolType = 2105
CSelectWitchSkills.MaxSize = 65535

function CSelectWitchSkills:Ctor(client)
  CSelectWitchSkills.super.Ctor(self, client)
  self.skillItemIds = {}
end

function CSelectWitchSkills:Marshal(buffer)
  local length = table.slen(self.skillItemIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillItemIds[i]) then
      return false
    end
  end
  return true
end

function CSelectWitchSkills:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.skillItemIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CSelectWitchSkills
