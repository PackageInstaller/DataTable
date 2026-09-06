local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCommunityShareOpenPanel = dataclass("SCommunityShareOpenPanel", require("framework.net.protocol"))
SCommunityShareOpenPanel.ProtocolType = 2753
SCommunityShareOpenPanel.MaxSize = 65535
SCommunityShareOpenPanel.statue = 0
SCommunityShareOpenPanel.shareUrl = ""
SCommunityShareOpenPanel.pictureID = 0

function SCommunityShareOpenPanel:Ctor(client)
  SCommunityShareOpenPanel.super.Ctor(self, client)
  self.award = {}
end

function SCommunityShareOpenPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.shareUrl) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pictureID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.award)) then
    return false
  end
  for key, value in pairs(self.award) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SCommunityShareOpenPanel:Unmarshal(buffer)
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
    self.award[key] = value
  end
  return ret
end

return SCommunityShareOpenPanel
