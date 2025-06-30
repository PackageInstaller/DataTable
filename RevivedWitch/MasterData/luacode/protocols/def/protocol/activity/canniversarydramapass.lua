-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/canniversarydramapass.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAnniversaryDramaPass = dataclass("CAnniversaryDramaPass", require("framework.net.protocol"))
CAnniversaryDramaPass.ProtocolType = 2684
CAnniversaryDramaPass.MaxSize = 65535
CAnniversaryDramaPass.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAnniversaryDramaPass
  ((CAnniversaryDramaPass.super).Ctor)(self, client)
end

CAnniversaryDramaPass.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CAnniversaryDramaPass.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CAnniversaryDramaPass

