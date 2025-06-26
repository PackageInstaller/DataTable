-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbacktaskredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBackTaskRedPoint = dataclass("SBackTaskRedPoint", require("framework.net.protocol"))
SBackTaskRedPoint.ProtocolType = 2573
SBackTaskRedPoint.MaxSize = 65535
SBackTaskRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBackTaskRedPoint
  ((SBackTaskRedPoint.super).Ctor)(self, client)
end

SBackTaskRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SBackTaskRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SBackTaskRedPoint

