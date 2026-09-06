local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRecordWhiteValentineRoleId = dataclass("CRecordWhiteValentineRoleId", require("framework.net.protocol"))
CRecordWhiteValentineRoleId.ProtocolType = 2620
CRecordWhiteValentineRoleId.MaxSize = 65535
CRecordWhiteValentineRoleId.roleId = 0

function CRecordWhiteValentineRoleId:Ctor(client)
  CRecordWhiteValentineRoleId.super.Ctor(self, client)
end

function CRecordWhiteValentineRoleId:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CRecordWhiteValentineRoleId:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordWhiteValentineRoleId
