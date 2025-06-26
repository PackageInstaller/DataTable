-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/schangesupportrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeSupportRole = dataclass("SChangeSupportRole", require("framework.net.protocol"))
SChangeSupportRole.ProtocolType = 1142
SChangeSupportRole.MaxSize = 65535
SChangeSupportRole.roleIds = 0
SChangeSupportRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeSupportRole
  ((SChangeSupportRole.super).Ctor)(self, client)
end

SChangeSupportRole.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleIds) then
    return false
  end
  return true
end

SChangeSupportRole.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeSupportRole

