-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/skill/sunlockwitchskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUnlockWitchSkill = dataclass("SUnlockWitchSkill", require("framework.net.protocol"))
SUnlockWitchSkill.ProtocolType = 2104
SUnlockWitchSkill.MaxSize = 65535
SUnlockWitchSkill.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUnlockWitchSkill, _ENV
  ((SUnlockWitchSkill.super).Ctor)(self, client)
  self.skillItem = ((require("protocols.bean.protocol.skill.beans.skillitem")).Create)()
end

SUnlockWitchSkill.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.skillItem):Marshal(buffer) then
    return false
  end
  return true
end

SUnlockWitchSkill.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.skillItem):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUnlockWitchSkill

