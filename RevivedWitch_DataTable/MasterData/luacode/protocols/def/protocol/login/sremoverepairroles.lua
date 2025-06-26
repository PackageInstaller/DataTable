-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sremoverepairroles.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRemoveRepairRoles = dataclass("SRemoveRepairRoles", require("framework.net.protocol"))
SRemoveRepairRoles.ProtocolType = 1053
SRemoveRepairRoles.MaxSize = 65535
SRemoveRepairRoles.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRemoveRepairRoles
  ((SRemoveRepairRoles.super).Ctor)(self, client)
  self.deadRoles = {}
end

SRemoveRepairRoles.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.deadRoles)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.deadRoles)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SRemoveRepairRoles.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.deadRoles)[i] = ((require("protocols.bean.protocol.login.deadrole")).Create)()
    if not ((self.deadRoles)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRemoveRepairRoles

