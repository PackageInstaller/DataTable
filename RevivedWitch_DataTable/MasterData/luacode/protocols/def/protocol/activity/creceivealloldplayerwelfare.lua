-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivealloldplayerwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveAllOldPlayerWelfare = dataclass("CReceiveAllOldPlayerWelfare", require("framework.net.protocol"))
CReceiveAllOldPlayerWelfare.ProtocolType = 2736
CReceiveAllOldPlayerWelfare.MaxSize = 65535
CReceiveAllOldPlayerWelfare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveAllOldPlayerWelfare
  ((CReceiveAllOldPlayerWelfare.super).Ctor)(self, client)
end

CReceiveAllOldPlayerWelfare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CReceiveAllOldPlayerWelfare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CReceiveAllOldPlayerWelfare

