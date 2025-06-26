-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/childrenday/cfetchscoreaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchScoreAward = dataclass("CFetchScoreAward", require("framework.net.protocol"))
CFetchScoreAward.ProtocolType = 2651
CFetchScoreAward.MaxSize = 65535
CFetchScoreAward.node = 0
CFetchScoreAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchScoreAward
  ((CFetchScoreAward.super).Ctor)(self, client)
end

CFetchScoreAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.node) then
    return false
  end
  return true
end

CFetchScoreAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchScoreAward

