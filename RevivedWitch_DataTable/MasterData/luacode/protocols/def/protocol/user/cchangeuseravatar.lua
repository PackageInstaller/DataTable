-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/cchangeuseravatar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeUserAvatar = dataclass("CChangeUserAvatar", require("framework.net.protocol"))
CChangeUserAvatar.ProtocolType = 2224
CChangeUserAvatar.MaxSize = 65535
CChangeUserAvatar.avatarId = 0
CChangeUserAvatar.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeUserAvatar
  ((CChangeUserAvatar.super).Ctor)(self, client)
end

CChangeUserAvatar.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  return true
end

CChangeUserAvatar.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserAvatar

