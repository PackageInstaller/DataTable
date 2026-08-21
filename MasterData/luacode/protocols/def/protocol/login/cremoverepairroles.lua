-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cremoverepairroles.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRemoveRepairRoles = dataclass("CRemoveRepairRoles", require("framework.net.protocol"))
CRemoveRepairRoles.ProtocolType = 1055
CRemoveRepairRoles.MaxSize = 65535
CRemoveRepairRoles.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRemoveRepairRoles
  ((CRemoveRepairRoles.super).Ctor)(self, client)
end

CRemoveRepairRoles.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRemoveRepairRoles.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRemoveRepairRoles

