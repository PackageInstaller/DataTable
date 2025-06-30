-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/resourcepass.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ResourcePass = dataclass("ResourcePass")
ResourcePass.status = 0
ResourcePass.level = 0
ResourcePass.process = 0
ResourcePass.spirit = 0
ResourcePass.first = 0
ResourcePass.LOCK = 0
ResourcePass.UNCLEAR = 1
ResourcePass.CLEAR = 2
ResourcePass.Ctor = function(self)
  -- function num : 0_0
  self.firstItems = {}
  self.randItems = {}
  self.activityItems = {}
end

ResourcePass.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.process) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.spirit) then
    return false
  end
  local length = (table.slen)(self.firstItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.firstItems)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.randItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.randItems)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.activityItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.activityItems)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.first) then
    return false
  end
  return true
end

ResourcePass.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

    (self.firstItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.firstItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R9 in 'UnsetPending'

    (self.randItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.randItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R10 in 'UnsetPending'

    (self.activityItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.activityItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ResourcePass

