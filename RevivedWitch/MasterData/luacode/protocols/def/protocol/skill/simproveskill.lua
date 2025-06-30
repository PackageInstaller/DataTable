-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/skill/simproveskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SImproveSkill = dataclass("SImproveSkill", require("framework.net.protocol"))
SImproveSkill.ProtocolType = 2103
SImproveSkill.MaxSize = 65535
SImproveSkill.roleId = 0
SImproveSkill.unlockNode = 0
SImproveSkill.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SImproveSkill
  ((SImproveSkill.super).Ctor)(self, client)
end

SImproveSkill.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlockNode) then
    return false
  end
  return true
end

SImproveSkill.Unmarshal = function(self, buffer)
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

return SImproveSkill

