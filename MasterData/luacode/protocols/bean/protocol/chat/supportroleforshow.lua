-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/supportroleforshow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SupportRoleForShow = dataclass("SupportRoleForShow")
SupportRoleForShow.id = 0
SupportRoleForShow.breakLv = 0
SupportRoleForShow.lv = 0
SupportRoleForShow.skin = 0
SupportRoleForShow.Ctor = function(self)
  -- function num : 0_0
  self.contractSkill = {}
end

SupportRoleForShow.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.breakLv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.lv) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skin) then
    return false
  end
  local length = (table.slen)(self.contractSkill)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.contractSkill)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SupportRoleForShow.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
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

    (self.contractSkill)[i] = ((require("protocols.bean.protocol.skill.beans.skillitem")).Create)()
    if not ((self.contractSkill)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SupportRoleForShow

