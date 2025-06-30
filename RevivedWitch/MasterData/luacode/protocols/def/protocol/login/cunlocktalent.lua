-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cunlocktalent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlockTalent = dataclass("CUnlockTalent", require("framework.net.protocol"))
CUnlockTalent.ProtocolType = 1076
CUnlockTalent.MaxSize = 65535
CUnlockTalent.roleId = 0
CUnlockTalent.pos = 0
CUnlockTalent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlockTalent
  ((CUnlockTalent.super).Ctor)(self, client)
end

CUnlockTalent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pos) then
    return false
  end
  return true
end

CUnlockTalent.Unmarshal = function(self, buffer)
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

return CUnlockTalent

