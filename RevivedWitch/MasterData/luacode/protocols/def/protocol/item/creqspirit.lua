-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/creqspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReqSpirit = dataclass("CReqSpirit", require("framework.net.protocol"))
CReqSpirit.ProtocolType = 1233
CReqSpirit.MaxSize = 65535
CReqSpirit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReqSpirit
  ((CReqSpirit.super).Ctor)(self, client)
end

CReqSpirit.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CReqSpirit.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CReqSpirit

