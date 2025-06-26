-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cbookactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBookActivity = dataclass("CBookActivity", require("framework.net.protocol"))
CBookActivity.ProtocolType = 2429
CBookActivity.MaxSize = 65535
CBookActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBookActivity
  ((CBookActivity.super).Ctor)(self, client)
end

CBookActivity.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CBookActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CBookActivity

