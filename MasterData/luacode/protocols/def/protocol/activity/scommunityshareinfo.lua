local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCommunityShareInfo = dataclass("SCommunityShareInfo", require("framework.net.protocol"))
SCommunityShareInfo.ProtocolType = 2749
SCommunityShareInfo.MaxSize = 65535
SCommunityShareInfo.statue = 0
SCommunityShareInfo.shareUrl = ""
SCommunityShareInfo.pictureID = 0

function SCommunityShareInfo:Ctor(client)
  SCommunityShareInfo.super.Ctor(self, client)
end

function SCommunityShareInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.shareUrl) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pictureID) then
    return false
  end
  return true
end

function SCommunityShareInfo:Unmarshal(buffer)
  local ret = true
  ret, self.statue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.shareUrl = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.pictureID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCommunityShareInfo
