-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cappointvicepresident.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAppointVicePresident = dataclass("CAppointVicePresident", require("framework.net.protocol"))
CAppointVicePresident.ProtocolType = 5022
CAppointVicePresident.MaxSize = 65535
CAppointVicePresident.partyId = 0
CAppointVicePresident.userId = 0
CAppointVicePresident.operate = 0
CAppointVicePresident.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAppointVicePresident
  ((CAppointVicePresident.super).Ctor)(self, client)
end

CAppointVicePresident.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.operate) then
    return false
  end
  return true
end

CAppointVicePresident.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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
  return ret
end

return CAppointVicePresident

