-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/clittlebattlepassunlockhigh.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLittleBattlePassUnlockHigh = dataclass("CLittleBattlePassUnlockHigh", require("framework.net.protocol"))
CLittleBattlePassUnlockHigh.ProtocolType = 2665
CLittleBattlePassUnlockHigh.MaxSize = 65535
CLittleBattlePassUnlockHigh.WaitProtocol = "protocol.notify.scancelloading"
CLittleBattlePassUnlockHigh.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLittleBattlePassUnlockHigh
  ((CLittleBattlePassUnlockHigh.super).Ctor)(self, client)
end

CLittleBattlePassUnlockHigh.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CLittleBattlePassUnlockHigh.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CLittleBattlePassUnlockHigh

