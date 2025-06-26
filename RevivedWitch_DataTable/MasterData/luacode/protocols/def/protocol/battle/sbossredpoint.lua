-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sbossredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBossRedPoint = dataclass("SBossRedPoint", require("framework.net.protocol"))
SBossRedPoint.ProtocolType = 4128
SBossRedPoint.MaxSize = 65535
SBossRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBossRedPoint
  ((SBossRedPoint.super).Ctor)(self, client)
end

SBossRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SBossRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SBossRedPoint

