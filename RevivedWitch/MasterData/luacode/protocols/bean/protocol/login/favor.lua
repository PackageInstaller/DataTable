-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/login/favor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Favor = dataclass("Favor")
Favor.favorLv = 0
Favor.favorExp = 0
Favor.Ctor = function(self)
  -- function num : 0_0
  self.favorAward = {}
end

Favor.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.favorLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.favorExp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.favorAward)) then
    return false
  end
  for key,value in pairs(self.favorAward) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not value:Marshal(R9_PC34) then
      return false
    end
  end
  return true
end

Favor.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
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
    -- DECOMPILER ERROR at PC47: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.favorAward)[key] = value
  end
  return ret
end

return Favor

