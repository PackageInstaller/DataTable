-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copendoubleelevenactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenDoubleElevenActivity = dataclass("COpenDoubleElevenActivity", require("framework.net.protocol"))
COpenDoubleElevenActivity.ProtocolType = 2521
COpenDoubleElevenActivity.MaxSize = 65535
COpenDoubleElevenActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenDoubleElevenActivity
  ((COpenDoubleElevenActivity.super).Ctor)(self, client)
end

COpenDoubleElevenActivity.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenDoubleElevenActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenDoubleElevenActivity

