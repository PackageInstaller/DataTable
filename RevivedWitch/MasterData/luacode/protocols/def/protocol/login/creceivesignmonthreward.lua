-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/creceivesignmonthreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveSignMonthReward = dataclass("CReceiveSignMonthReward", require("framework.net.protocol"))
CReceiveSignMonthReward.ProtocolType = 1092
CReceiveSignMonthReward.MaxSize = 65535
CReceiveSignMonthReward.signNum = 0
CReceiveSignMonthReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveSignMonthReward
  ((CReceiveSignMonthReward.super).Ctor)(self, client)
end

CReceiveSignMonthReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.signNum) then
    return false
  end
  return true
end

CReceiveSignMonthReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSignMonthReward

