-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cchangeservantskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeServantSkill = dataclass("CChangeServantSkill", require("framework.net.protocol"))
CChangeServantSkill.ProtocolType = 1047
CChangeServantSkill.MaxSize = 65535
CChangeServantSkill.lineupId = 0
CChangeServantSkill.skillId = 0
CChangeServantSkill.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeServantSkill
  ((CChangeServantSkill.super).Ctor)(self, client)
end

CChangeServantSkill.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skillId) then
    return false
  end
  return true
end

CChangeServantSkill.Unmarshal = function(self, buffer)
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

return CChangeServantSkill

