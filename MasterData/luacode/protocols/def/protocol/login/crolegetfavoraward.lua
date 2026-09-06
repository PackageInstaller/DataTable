local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleGetFavorAward = dataclass("CRoleGetFavorAward", require("framework.net.protocol"))
CRoleGetFavorAward.ProtocolType = 1026
CRoleGetFavorAward.MaxSize = 65535
CRoleGetFavorAward.id = 0

function CRoleGetFavorAward:Ctor(client)
  CRoleGetFavorAward.super.Ctor(self, client)
end

function CRoleGetFavorAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CRoleGetFavorAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleGetFavorAward
