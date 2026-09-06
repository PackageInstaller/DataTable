local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBuyEquipChest = dataclass("CBuyEquipChest", require("framework.net.protocol"))
CBuyEquipChest.ProtocolType = 3633
CBuyEquipChest.MaxSize = 65535
CBuyEquipChest.chestID = 0

function CBuyEquipChest:Ctor(client)
  CBuyEquipChest.super.Ctor(self, client)
end

function CBuyEquipChest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chestID) then
    return false
  end
  return true
end

function CBuyEquipChest:Unmarshal(buffer)
  local ret = true
  ret, self.chestID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyEquipChest
