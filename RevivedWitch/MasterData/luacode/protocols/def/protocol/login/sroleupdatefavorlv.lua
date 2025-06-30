-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sroleupdatefavorlv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleUpdateFavorLv = dataclass("SRoleUpdateFavorLv", require("framework.net.protocol"))
SRoleUpdateFavorLv.ProtocolType = 1019
SRoleUpdateFavorLv.MaxSize = 65535
SRoleUpdateFavorLv.id = 0
SRoleUpdateFavorLv.favorLv = 0
SRoleUpdateFavorLv.exp = 0
SRoleUpdateFavorLv.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleUpdateFavorLv
  ((SRoleUpdateFavorLv.super).Ctor)(self, client)
  self.favorAwardStatus = {}
end

SRoleUpdateFavorLv.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.favorLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.exp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.favorAwardStatus)) then
    return false
  end
  for key,value in pairs(self.favorAwardStatus) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
  end
  return true
end

SRoleUpdateFavorLv.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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
    -- DECOMPILER ERROR at PC53: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.favorAwardStatus)[key] = value
  end
  return ret
end

return SRoleUpdateFavorLv

