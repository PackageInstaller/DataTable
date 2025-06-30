-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/canniversaryshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAnniversaryShare = dataclass("CAnniversaryShare", require("framework.net.protocol"))
CAnniversaryShare.ProtocolType = 2694
CAnniversaryShare.MaxSize = 65535
CAnniversaryShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAnniversaryShare
  ((CAnniversaryShare.super).Ctor)(self, client)
end

CAnniversaryShare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CAnniversaryShare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CAnniversaryShare

