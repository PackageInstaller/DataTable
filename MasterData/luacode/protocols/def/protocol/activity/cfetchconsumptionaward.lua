local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchConsumptionAward = dataclass("CFetchConsumptionAward", require("framework.net.protocol"))
CFetchConsumptionAward.ProtocolType = 2733
CFetchConsumptionAward.MaxSize = 65535
CFetchConsumptionAward.taskId = 0

function CFetchConsumptionAward:Ctor(client)
  CFetchConsumptionAward.super.Ctor(self, client)
end

function CFetchConsumptionAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskId) then
    return false
  end
  return true
end

function CFetchConsumptionAward:Unmarshal(buffer)
  local ret = true
  ret, self.taskId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchConsumptionAward
