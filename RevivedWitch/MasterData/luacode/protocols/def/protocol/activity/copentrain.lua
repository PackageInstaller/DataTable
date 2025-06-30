-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copentrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenTrain = dataclass("COpenTrain", require("framework.net.protocol"))
COpenTrain.ProtocolType = 2483
COpenTrain.MaxSize = 65535
COpenTrain.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenTrain
  ((COpenTrain.super).Ctor)(self, client)
end

COpenTrain.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenTrain.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenTrain

