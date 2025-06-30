-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cturnpresident.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CTurnPresident = dataclass("CTurnPresident", require("framework.net.protocol"))
CTurnPresident.ProtocolType = 5021
CTurnPresident.MaxSize = 65535
CTurnPresident.partyId = 0
CTurnPresident.userId = 0
CTurnPresident.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CTurnPresident
  ((CTurnPresident.super).Ctor)(self, client)
end

CTurnPresident.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  return true
end

CTurnPresident.Unmarshal = function(self, buffer)
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
  return ret
end

return CTurnPresident

