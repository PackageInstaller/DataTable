-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cchristmassupport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChristmasSupport = dataclass("CChristmasSupport", require("framework.net.protocol"))
CChristmasSupport.ProtocolType = 2564
CChristmasSupport.MaxSize = 65535
CChristmasSupport.num = 0
CChristmasSupport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChristmasSupport
  ((CChristmasSupport.super).Ctor)(self, client)
end

CChristmasSupport.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  return true
end

CChristmasSupport.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChristmasSupport

