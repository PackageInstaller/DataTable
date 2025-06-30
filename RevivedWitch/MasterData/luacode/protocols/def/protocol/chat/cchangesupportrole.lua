-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/cchangesupportrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeSupportRole = dataclass("CChangeSupportRole", require("framework.net.protocol"))
CChangeSupportRole.ProtocolType = 1140
CChangeSupportRole.MaxSize = 65535
CChangeSupportRole.roleId = 0
CChangeSupportRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeSupportRole
  ((CChangeSupportRole.super).Ctor)(self, client)
end

CChangeSupportRole.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CChangeSupportRole.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeSupportRole

