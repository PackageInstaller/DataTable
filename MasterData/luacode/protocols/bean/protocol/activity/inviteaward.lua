local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local InviteAward = dataclass("InviteAward")
InviteAward.rewardID = 0
InviteAward.rewardState = 0
InviteAward.progress = 0
InviteAward.notget = 0
InviteAward.get = 1
InviteAward.gotten = 2

function InviteAward:Ctor()
end

function InviteAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardState) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.progress) then
    return false
  end
  return true
end

function InviteAward:Unmarshal(buffer)
  local ret = true
  ret, self.rewardID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rewardState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.progress = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return InviteAward
