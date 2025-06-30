-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshmailredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshMailRedPoint = dataclass("SRefreshMailRedPoint", require("framework.net.protocol"))
SRefreshMailRedPoint.ProtocolType = 2534
SRefreshMailRedPoint.MaxSize = 65535
SRefreshMailRedPoint.redPoint = 0
SRefreshMailRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshMailRedPoint
  ((SRefreshMailRedPoint.super).Ctor)(self, client)
end

SRefreshMailRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.redPoint) then
    return false
  end
  return true
end

SRefreshMailRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshMailRedPoint

