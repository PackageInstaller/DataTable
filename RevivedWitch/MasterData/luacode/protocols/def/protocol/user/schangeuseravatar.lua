-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/schangeuseravatar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeUserAvatar = dataclass("SChangeUserAvatar", require("framework.net.protocol"))
SChangeUserAvatar.ProtocolType = 2225
SChangeUserAvatar.MaxSize = 65535
SChangeUserAvatar.avatarId = 0
SChangeUserAvatar.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeUserAvatar
  ((SChangeUserAvatar.super).Ctor)(self, client)
end

SChangeUserAvatar.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.avatarId) then
    return false
  end
  return true
end

SChangeUserAvatar.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserAvatar

