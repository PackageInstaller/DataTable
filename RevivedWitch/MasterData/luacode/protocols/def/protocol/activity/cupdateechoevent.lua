-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cupdateechoevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUpdateEchoEvent = dataclass("CUpdateEchoEvent", require("framework.net.protocol"))
CUpdateEchoEvent.ProtocolType = 2712
CUpdateEchoEvent.MaxSize = 65536
CUpdateEchoEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUpdateEchoEvent
  ((CUpdateEchoEvent.super).Ctor)(self, client)
end

CUpdateEchoEvent.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CUpdateEchoEvent.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CUpdateEchoEvent

