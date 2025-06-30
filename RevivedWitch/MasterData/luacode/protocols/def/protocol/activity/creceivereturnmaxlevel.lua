-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivereturnmaxlevel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveReturnMaxLevel = dataclass("CReceiveReturnMaxLevel", require("framework.net.protocol"))
CReceiveReturnMaxLevel.ProtocolType = 2741
CReceiveReturnMaxLevel.MaxSize = 65535
CReceiveReturnMaxLevel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveReturnMaxLevel
  ((CReceiveReturnMaxLevel.super).Ctor)(self, client)
end

CReceiveReturnMaxLevel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CReceiveReturnMaxLevel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CReceiveReturnMaxLevel

