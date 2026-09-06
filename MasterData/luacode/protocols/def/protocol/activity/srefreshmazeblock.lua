local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshMazeBlock = dataclass("SRefreshMazeBlock", require("framework.net.protocol"))
SRefreshMazeBlock.ProtocolType = 2686
SRefreshMazeBlock.MaxSize = 65535
SRefreshMazeBlock.pos = 0

function SRefreshMazeBlock:Ctor(client)
  SRefreshMazeBlock.super.Ctor(self, client)
  self.blocks = {}
  self.itemInfo = {}
end

function SRefreshMazeBlock:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.blocks)) then
    return false
  end
  for key, value in pairs(self.blocks) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pos) then
    return false
  end
  local length = table.slen(self.itemInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshMazeBlock:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.activity.mazeawardblock").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.blocks[key] = value
  end
  ret, self.pos = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemInfo[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshMazeBlock
