-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cbuymonthsignnum.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyMonthSignNum = dataclass("CBuyMonthSignNum", require("framework.net.protocol"))
CBuyMonthSignNum.ProtocolType = 1094
CBuyMonthSignNum.MaxSize = 65535
CBuyMonthSignNum.num = 0
CBuyMonthSignNum.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyMonthSignNum
  ((CBuyMonthSignNum.super).Ctor)(self, client)
end

CBuyMonthSignNum.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  return true
end

CBuyMonthSignNum.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyMonthSignNum

