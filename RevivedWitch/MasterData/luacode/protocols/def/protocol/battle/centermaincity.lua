-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/centermaincity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CEnterMainCity = dataclass("CEnterMainCity", require("framework.net.protocol"))
CEnterMainCity.ProtocolType = 1952
CEnterMainCity.MaxSize = 65535
CEnterMainCity.WaitProtocol = "protocol.notify.scancelloading"
CEnterMainCity.enterCityType = 0
CEnterMainCity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CEnterMainCity
  ((CEnterMainCity.super).Ctor)(self, client)
end

CEnterMainCity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.enterCityType) then
    return false
  end
  return true
end

CEnterMainCity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnterMainCity

