-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/supdatepassiveskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdatePassiveSkill = dataclass("SUpdatePassiveSkill", require("framework.net.protocol"))
SUpdatePassiveSkill.ProtocolType = 1078
SUpdatePassiveSkill.MaxSize = 65535
SUpdatePassiveSkill.roleId = 0
SUpdatePassiveSkill.oldSkillId = 0
SUpdatePassiveSkill.newSKillId = 0
SUpdatePassiveSkill.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdatePassiveSkill
  ((SUpdatePassiveSkill.super).Ctor)(self, client)
end

SUpdatePassiveSkill.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.oldSkillId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.newSKillId) then
    return false
  end
  return true
end

SUpdatePassiveSkill.Unmarshal = function(self, buffer)
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

return SUpdatePassiveSkill

