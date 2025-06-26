-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sroleupdateproperties.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleUpdateProperties = dataclass("SRoleUpdateProperties", require("framework.net.protocol"))
SRoleUpdateProperties.ProtocolType = 1020
SRoleUpdateProperties.MaxSize = 65535
SRoleUpdateProperties.roleId = 0
SRoleUpdateProperties.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleUpdateProperties
  ((SRoleUpdateProperties.super).Ctor)(self, client)
  self.properties = {}
end

SRoleUpdateProperties.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.properties)) then
    return false
  end
  for key,value in pairs(self.properties) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
  end
  return true
end

SRoleUpdateProperties.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
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
    -- DECOMPILER ERROR at PC37: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.properties)[key] = value
  end
  return ret
end

return SRoleUpdateProperties

