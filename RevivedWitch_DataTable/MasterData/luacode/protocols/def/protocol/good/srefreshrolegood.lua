-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/good/srefreshrolegood.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshRoleGood = dataclass("SRefreshRoleGood", require("framework.net.protocol"))
SRefreshRoleGood.ProtocolType = 3402
SRefreshRoleGood.MaxSize = 65535
SRefreshRoleGood.roleId = 0
SRefreshRoleGood.level = 0
SRefreshRoleGood.progress = 0
SRefreshRoleGood.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshRoleGood
  ((SRefreshRoleGood.super).Ctor)(self, client)
end

SRefreshRoleGood.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.progress) then
    return false
  end
  return true
end

SRefreshRoleGood.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshRoleGood

