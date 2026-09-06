local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SResourcePanel = dataclass("SResourcePanel", require("framework.net.protocol"))
SResourcePanel.ProtocolType = 1935
SResourcePanel.MaxSize = 65535

function SResourcePanel:Ctor(client)
  SResourcePanel.super.Ctor(self, client)
  self.words = {}
end

function SResourcePanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.words)) then
    return false
  end
  for key, value in pairs(self.words) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SResourcePanel:Unmarshal(buffer)
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
    value = require("protocols.bean.protocol.battle.resourceword").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.words[key] = value
  end
  return ret
end

return SResourcePanel
