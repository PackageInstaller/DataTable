-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/party/memberinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local MemberInfo = dataclass("MemberInfo")
MemberInfo.userId = 0
MemberInfo.username = ""
MemberInfo.userLevel = 0
MemberInfo.avatarId = 0
MemberInfo.frameId = 0
MemberInfo.applyTime = 0
MemberInfo.lastTime = 0
MemberInfo.position = 0
MemberInfo.identity = 0
MemberInfo.donate = 0
MemberInfo.spiritvip = 0
MemberInfo.RESIGN = -1
MemberInfo.PRESIDENT = 1
MemberInfo.VICE_PRESIDENT = 2
MemberInfo.CREAM = 3
MemberInfo.MEMBER = 4
MemberInfo.OFFLINE = 0
MemberInfo.ONLINE = 1
MemberInfo.Ctor = function(self)
  -- function num : 0_0
end

MemberInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.username) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.userLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.frameId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.applyTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.lastTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.position) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.identity) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.donate) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.spiritvip) then
    return false
  end
  return true
end

MemberInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MemberInfo

