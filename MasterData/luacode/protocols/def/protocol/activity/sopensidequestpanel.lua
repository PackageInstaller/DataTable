local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenSideQuestPanel = dataclass("SOpenSideQuestPanel", require("framework.net.protocol"))
SOpenSideQuestPanel.ProtocolType = 2422
SOpenSideQuestPanel.MaxSize = 65536

function SOpenSideQuestPanel:Ctor(client)
  SOpenSideQuestPanel.super.Ctor(self, client)
  self.dungeons = {}
end

function SOpenSideQuestPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.dungeons)) then
    return false
  end
  for key, value in pairs(self.dungeons) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenSideQuestPanel:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.activity.sidequestdungeoninfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.dungeons[key] = value
  end
  return ret
end

return SOpenSideQuestPanel
