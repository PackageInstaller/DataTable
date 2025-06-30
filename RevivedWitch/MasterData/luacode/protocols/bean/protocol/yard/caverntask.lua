-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/yard/caverntask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CavernTask = dataclass("CavernTask")
CavernTask.statue = 0
CavernTask.Id = 0
CavernTask.cavernId = 0
CavernTask.progress = 0
CavernTask.leftReceiveTime = 0
CavernTask.leftDeadline = 0
CavernTask.exploreTimes = 0
CavernTask.LOCK = 0
CavernTask.UNLOCKING = 1
CavernTask.UnReceive = 2
CavernTask.DEADLINE = 3
CavernTask.PROCESSING = 4
CavernTask.Ctor = function(self)
  -- function num : 0_0
  self.product = {}
  self.roles = {}
end

CavernTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.statue) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.Id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.cavernId) then
    return false
  end
  local length = (table.slen)(self.product)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.product)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.progress) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftReceiveTime) then
    return false
  end
  local length = (table.slen)(self.roles)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.roles)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftDeadline) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.exploreTimes) then
    return false
  end
  return true
end

CavernTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    (self.product)[i] = ((require("protocols.bean.protocol.yard.production")).Create)()
    if not ((self.product)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R9 in 'UnsetPending'

    (self.roles)[i] = ((require("protocols.bean.protocol.yard.role")).Create)()
    if not ((self.roles)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CavernTask

