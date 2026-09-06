local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshSkinCollectTask = dataclass("SRefreshSkinCollectTask", require("framework.net.protocol"))
SRefreshSkinCollectTask.ProtocolType = 1270
SRefreshSkinCollectTask.MaxSize = 65535
SRefreshSkinCollectTask.TO_FINISH = 0
SRefreshSkinCollectTask.TO_FETCH = 1
SRefreshSkinCollectTask.FETCHED = 2

function SRefreshSkinCollectTask:Ctor(client)
  SRefreshSkinCollectTask.super.Ctor(self, client)
  self.tasks = {}
end

function SRefreshSkinCollectTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.tasks)) then
    return false
  end
  for key, value in pairs(self.tasks) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SRefreshSkinCollectTask:Unmarshal(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.tasks[key] = value
  end
  return ret
end

return SRefreshSkinCollectTask
