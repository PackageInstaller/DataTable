-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cfetchconsumptionaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchConsumptionAward = dataclass("CFetchConsumptionAward", require("framework.net.protocol"))
CFetchConsumptionAward.ProtocolType = 2733
CFetchConsumptionAward.MaxSize = 65535
CFetchConsumptionAward.taskId = 0
CFetchConsumptionAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchConsumptionAward
  ((CFetchConsumptionAward.super).Ctor)(self, client)
end

CFetchConsumptionAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskId) then
    return false
  end
  return true
end

CFetchConsumptionAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchConsumptionAward

