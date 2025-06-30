-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivemaxlevel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveMaxLevel = dataclass("CReceiveMaxLevel", require("framework.net.protocol"))
CReceiveMaxLevel.ProtocolType = 2409
CReceiveMaxLevel.MaxSize = 65535
CReceiveMaxLevel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveMaxLevel
  ((CReceiveMaxLevel.super).Ctor)(self, client)
end

CReceiveMaxLevel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CReceiveMaxLevel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CReceiveMaxLevel

