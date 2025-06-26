-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/skill/cimproveskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CImproveSkill = dataclass("CImproveSkill", require("framework.net.protocol"))
CImproveSkill.ProtocolType = 2101
CImproveSkill.MaxSize = 65535
CImproveSkill.roleId = 0
CImproveSkill.unlockNode = 0
CImproveSkill.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CImproveSkill
  ((CImproveSkill.super).Ctor)(self, client)
end

CImproveSkill.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlockNode) then
    return false
  end
  return true
end

CImproveSkill.Unmarshal = function(self, buffer)
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

return CImproveSkill

