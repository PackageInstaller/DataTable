-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sanniversarysupply.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAnniversarySupply = dataclass("SAnniversarySupply", require("framework.net.protocol"))
SAnniversarySupply.ProtocolType = 2680
SAnniversarySupply.MaxSize = 65535
SAnniversarySupply.LOCKED = 0
SAnniversarySupply.UNLOCKED = 1
SAnniversarySupply.FETCHED = 2
SAnniversarySupply.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAnniversarySupply
  ((SAnniversarySupply.super).Ctor)(self, client)
  self.supply = {}
end

SAnniversarySupply.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.supply)) then
    return false
  end
  for key,value in pairs(self.supply) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  return true
end

SAnniversarySupply.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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
    -- DECOMPILER ERROR at PC29: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.supply)[key] = value
  end
  return ret
end

return SAnniversarySupply

