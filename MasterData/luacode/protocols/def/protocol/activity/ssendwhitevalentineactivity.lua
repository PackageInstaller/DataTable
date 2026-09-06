local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendWhiteValentineActivity = dataclass("SSendWhiteValentineActivity", require("framework.net.protocol"))
SSendWhiteValentineActivity.ProtocolType = 2612
SSendWhiteValentineActivity.MaxSize = 65535
SSendWhiteValentineActivity.state = 0
SSendWhiteValentineActivity.id = 0
SSendWhiteValentineActivity.rewardState = 0
SSendWhiteValentineActivity.roleId = 0

function SSendWhiteValentineActivity:Ctor(client)
  SSendWhiteValentineActivity.super.Ctor(self, client)
end

function SSendWhiteValentineActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardState) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function SSendWhiteValentineActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rewardState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendWhiteValentineActivity
