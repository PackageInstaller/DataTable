-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cspringspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSpringSpirit = dataclass("CSpringSpirit", require("framework.net.protocol"))
CSpringSpirit.ProtocolType = 2581
CSpringSpirit.MaxSize = 65535
CSpringSpirit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSpringSpirit
  ((CSpringSpirit.super).Ctor)(self, client)
end

CSpringSpirit.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CSpringSpirit.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CSpringSpirit

