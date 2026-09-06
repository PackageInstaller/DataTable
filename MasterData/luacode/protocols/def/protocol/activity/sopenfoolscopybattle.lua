local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenFoolsCopyBattle = dataclass("SOpenFoolsCopyBattle", require("framework.net.protocol"))
SOpenFoolsCopyBattle.ProtocolType = 2636
SOpenFoolsCopyBattle.MaxSize = 65535

function SOpenFoolsCopyBattle:Ctor(client)
  SOpenFoolsCopyBattle.super.Ctor(self, client)
  self.battleInfo = {}
end

function SOpenFoolsCopyBattle:Marshal(buffer)
  local length = table.slen(self.battleInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.battleInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenFoolsCopyBattle:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.battleInfo[i] = require("protocols.bean.protocol.activity.foolsdaycopybattle").Create()
    if not self.battleInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenFoolsCopyBattle
