-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/common/slogin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLogin = dataclass("SLogin", require("framework.net.protocol"))
SLogin.ProtocolType = 102
SLogin.MaxSize = 256
SLogin.userid = 0
SLogin.token = ""
SLogin.needActive = 0
SLogin.serverId = 0
SLogin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLogin
  ((SLogin.super).Ctor)(self, client)
end

SLogin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.token) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.needActive) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.serverId) then
    return false
  end
  return true
end

SLogin.Unmarshal = function(self, buffer)
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
  return ret
end

return SLogin

