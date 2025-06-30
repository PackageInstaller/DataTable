-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/schangeservantskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeServantSkill = dataclass("SChangeServantSkill", require("framework.net.protocol"))
SChangeServantSkill.ProtocolType = 1048
SChangeServantSkill.MaxSize = 65535
SChangeServantSkill.lineupId = 0
SChangeServantSkill.result = 0
SChangeServantSkill.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeServantSkill
  ((SChangeServantSkill.super).Ctor)(self, client)
end

SChangeServantSkill.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.result) then
    return false
  end
  return true
end

SChangeServantSkill.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeServantSkill

