-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/sstartguide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SStartGuide = dataclass("SStartGuide", require("framework.net.protocol"))
SStartGuide.ProtocolType = 2213
SStartGuide.MaxSize = 65535
SStartGuide.guide = 0
SStartGuide.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SStartGuide
  ((SStartGuide.super).Ctor)(self, client)
end

SStartGuide.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.guide) then
    return false
  end
  return true
end

SStartGuide.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartGuide

