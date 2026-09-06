local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchSkinCollectAward = dataclass("CFetchSkinCollectAward", require("framework.net.protocol"))
CFetchSkinCollectAward.ProtocolType = 1271
CFetchSkinCollectAward.MaxSize = 65535
CFetchSkinCollectAward.taskId = 0

function CFetchSkinCollectAward:Ctor(client)
  CFetchSkinCollectAward.super.Ctor(self, client)
end

function CFetchSkinCollectAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskId) then
    return false
  end
  return true
end

function CFetchSkinCollectAward:Unmarshal(buffer)
  local ret = true
  ret, self.taskId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchSkinCollectAward
