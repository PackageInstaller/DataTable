-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cstrengthenequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStrengthenEquip = dataclass("CStrengthenEquip", require("framework.net.protocol"))
CStrengthenEquip.ProtocolType = 1221
CStrengthenEquip.MaxSize = 65535
CStrengthenEquip.equipKey = 0
CStrengthenEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStrengthenEquip
  ((CStrengthenEquip.super).Ctor)(self, client)
  self.costEquip = {}
  self.stuffs = {}
end

CStrengthenEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  local length = (table.slen)(self.costEquip)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.costEquip)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.stuffs)) then
    return false
  end
  for key,value in pairs(self.stuffs) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC52) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC52) then
      return false
    end
  end
  return true
end

CStrengthenEquip.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC60: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.stuffs)[key] = value
  end
  return ret
end

return CStrengthenEquip

