-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cimprovetalent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CImproveTalent = dataclass("CImproveTalent", require("framework.net.protocol"))
CImproveTalent.ProtocolType = 4145
CImproveTalent.MaxSize = 65535
CImproveTalent.unlockNode = 0
CImproveTalent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CImproveTalent
  ((CImproveTalent.super).Ctor)(self, client)
end

CImproveTalent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlockNode) then
    return false
  end
  return true
end

CImproveTalent.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CImproveTalent

