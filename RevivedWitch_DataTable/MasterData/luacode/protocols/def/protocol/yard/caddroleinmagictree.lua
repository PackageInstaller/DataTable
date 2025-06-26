-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/caddroleinmagictree.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAddRoleInMagicTree = dataclass("CAddRoleInMagicTree", require("framework.net.protocol"))
CAddRoleInMagicTree.ProtocolType = 2329
CAddRoleInMagicTree.MaxSize = 65535
CAddRoleInMagicTree.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAddRoleInMagicTree
  ((CAddRoleInMagicTree.super).Ctor)(self, client)
  self.roleIds = {}
end

CAddRoleInMagicTree.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
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

CAddRoleInMagicTree.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CAddRoleInMagicTree

