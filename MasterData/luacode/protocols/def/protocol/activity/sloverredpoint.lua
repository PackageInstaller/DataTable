-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sloverredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLoverRedPoint = dataclass("SLoverRedPoint", require("framework.net.protocol"))
SLoverRedPoint.ProtocolType = 2610
SLoverRedPoint.MaxSize = 65535
SLoverRedPoint.state = 0
SLoverRedPoint.LOVER_CHOCOLATE = 1
SLoverRedPoint.LOVER_FLOWER = 2
SLoverRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLoverRedPoint
  ((SLoverRedPoint.super).Ctor)(self, client)
end

SLoverRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  return true
end

SLoverRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLoverRedPoint

