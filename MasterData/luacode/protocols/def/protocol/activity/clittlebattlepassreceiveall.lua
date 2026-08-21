-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/clittlebattlepassreceiveall.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLittleBattlePassReceiveAll = dataclass("CLittleBattlePassReceiveAll", require("framework.net.protocol"))
CLittleBattlePassReceiveAll.ProtocolType = 2663
CLittleBattlePassReceiveAll.MaxSize = 65535
CLittleBattlePassReceiveAll.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLittleBattlePassReceiveAll
  ((CLittleBattlePassReceiveAll.super).Ctor)(self, client)
end

CLittleBattlePassReceiveAll.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CLittleBattlePassReceiveAll.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CLittleBattlePassReceiveAll

