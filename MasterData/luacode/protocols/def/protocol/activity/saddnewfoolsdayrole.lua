local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddNewFoolsDayRole = dataclass("SAddNewFoolsDayRole", require("framework.net.protocol"))
SAddNewFoolsDayRole.ProtocolType = 2628
SAddNewFoolsDayRole.MaxSize = 65535
SAddNewFoolsDayRole.Id = 0

function SAddNewFoolsDayRole:Ctor(client)
  SAddNewFoolsDayRole.super.Ctor(self, client)
end

function SAddNewFoolsDayRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.Id) then
    return false
  end
  return true
end

function SAddNewFoolsDayRole:Unmarshal(buffer)
  local ret = true
  ret, self.Id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddNewFoolsDayRole
