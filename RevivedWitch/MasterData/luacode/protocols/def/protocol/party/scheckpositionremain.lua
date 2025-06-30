-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/scheckpositionremain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCheckPositionRemain = dataclass("SCheckPositionRemain", require("framework.net.protocol"))
SCheckPositionRemain.ProtocolType = 5025
SCheckPositionRemain.MaxSize = 65535
SCheckPositionRemain.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCheckPositionRemain
  ((SCheckPositionRemain.super).Ctor)(self, client)
  self.positionNumber = {}
end

SCheckPositionRemain.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.positionNumber)) then
    return false
  end
  for key,value in pairs(self.positionNumber) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  return true
end

SCheckPositionRemain.Unmarshal = function(self, buffer)
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
    (self.positionNumber)[key] = value
  end
  return ret
end

return SCheckPositionRemain

