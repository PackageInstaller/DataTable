-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/creplacerolesincavern.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReplaceRolesInCavern = dataclass("CReplaceRolesInCavern", require("framework.net.protocol"))
CReplaceRolesInCavern.ProtocolType = 2323
CReplaceRolesInCavern.MaxSize = 65535
CReplaceRolesInCavern.id = 0
CReplaceRolesInCavern.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReplaceRolesInCavern
  ((CReplaceRolesInCavern.super).Ctor)(self, client)
  self.roleIds = {}
end

CReplaceRolesInCavern.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  local length = (table.slen)(self.roleIds)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.roleIds)[i]) then
      return false
    end
  end
  return true
end

CReplaceRolesInCavern.Unmarshal = function(self, buffer)
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
  return ret
end

return CReplaceRolesInCavern

