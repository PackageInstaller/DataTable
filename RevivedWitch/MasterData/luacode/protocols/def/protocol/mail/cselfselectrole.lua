-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/cselfselectrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSelfSelectRole = dataclass("CSelfSelectRole", require("framework.net.protocol"))
CSelfSelectRole.ProtocolType = 1415
CSelfSelectRole.MaxSize = 65535
CSelfSelectRole.mailKey = 0
CSelfSelectRole.select = 0
CSelfSelectRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSelfSelectRole
  ((CSelfSelectRole.super).Ctor)(self, client)
end

CSelfSelectRole.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.mailKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.select) then
    return false
  end
  return true
end

CSelfSelectRole.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSelfSelectRole

