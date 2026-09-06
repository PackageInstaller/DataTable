local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SModifyItemNum = dataclass("SModifyItemNum", require("framework.net.protocol"))
SModifyItemNum.ProtocolType = 1204
SModifyItemNum.MaxSize = 65535
SModifyItemNum.bagType = 0
SModifyItemNum.itemKey = 0
SModifyItemNum.itemNum = 0

function SModifyItemNum:Ctor(client)
  SModifyItemNum.super.Ctor(self, client)
  self.delTime = {}
end

function SModifyItemNum:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bagType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  local length = table.slen(self.delTime)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.delTime[i]) then
      return false
    end
  end
  return true
end

function SModifyItemNum:Unmarshal(buffer)
  local ret = true
  ret, self.bagType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemKey = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.delTime[i] = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SModifyItemNum
