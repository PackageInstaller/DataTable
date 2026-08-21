-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/chavingechosnack.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CHavingEchoSnack = dataclass("CHavingEchoSnack", require("framework.net.protocol"))
CHavingEchoSnack.ProtocolType = 2710
CHavingEchoSnack.MaxSize = 65536
CHavingEchoSnack.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CHavingEchoSnack
  ((CHavingEchoSnack.super).Ctor)(self, client)
end

CHavingEchoSnack.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CHavingEchoSnack.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CHavingEchoSnack

