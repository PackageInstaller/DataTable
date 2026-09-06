local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateExploreState = dataclass("SUpdateExploreState", require("framework.net.protocol"))
SUpdateExploreState.ProtocolType = 1929
SUpdateExploreState.MaxSize = 65535

function SUpdateExploreState:Ctor(client)
  SUpdateExploreState.super.Ctor(self, client)
  self.traps = {}
  self.switches = {}
end

function SUpdateExploreState:Marshal(buffer)
  local length = table.slen(self.traps)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.traps[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.switches)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.switches[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SUpdateExploreState:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.traps[i] = require("protocols.bean.protocol.battle.exploreinstance").Create()
    if not self.traps[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.switches[i] = require("protocols.bean.protocol.battle.switchesinstance").Create()
    if not self.switches[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateExploreState
