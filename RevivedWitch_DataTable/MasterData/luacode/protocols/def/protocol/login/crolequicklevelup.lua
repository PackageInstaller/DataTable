-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/crolequicklevelup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRoleQuickLevelUP = dataclass("CRoleQuickLevelUP", require("framework.net.protocol"))
CRoleQuickLevelUP.ProtocolType = 1089
CRoleQuickLevelUP.MaxSize = 65535
CRoleQuickLevelUP.WaitProtocol = "protocol.notify.scancelloading"
CRoleQuickLevelUP.roleId = 0
CRoleQuickLevelUP.level = 0
CRoleQuickLevelUP.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRoleQuickLevelUP
  ((CRoleQuickLevelUP.super).Ctor)(self, client)
end

CRoleQuickLevelUP.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  return true
end

CRoleQuickLevelUP.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleQuickLevelUP

