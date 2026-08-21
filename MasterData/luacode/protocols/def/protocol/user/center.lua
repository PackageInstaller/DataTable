-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/center.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CEnter = dataclass("CEnter", require("framework.net.protocol"))
CEnter.ProtocolType = 2201
CEnter.MaxSize = 65535
CEnter.deepLink = 0
CEnter.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CEnter
  ((CEnter.super).Ctor)(self, client)
end

CEnter.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.deepLink) then
    return false
  end
  return true
end

CEnter.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnter

