-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cgetroleskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetRoleSkin = dataclass("CGetRoleSkin", require("framework.net.protocol"))
CGetRoleSkin.ProtocolType = 1249
CGetRoleSkin.MaxSize = 65535
CGetRoleSkin.roleId = 0
CGetRoleSkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetRoleSkin
  ((CGetRoleSkin.super).Ctor)(self, client)
end

CGetRoleSkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CGetRoleSkin.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetRoleSkin

