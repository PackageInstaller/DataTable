-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/rolereset/srolereset.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleReset = dataclass("SRoleReset", require("framework.net.protocol"))
SRoleReset.ProtocolType = 1088
SRoleReset.MaxSize = 65535
SRoleReset.roleId = 0
SRoleReset.isPreview = 0
SRoleReset.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleReset
  ((SRoleReset.super).Ctor)(self, client)
  self.itemList = {}
end

SRoleReset.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isPreview) then
    return false
  end
  local length = (table.slen)(self.itemList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.itemList)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SRoleReset.Unmarshal = function(self, buffer)
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.itemList)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.itemList)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRoleReset

