-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/simplerank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SimpleRank = dataclass("SimpleRank")
SimpleRank.rank = 0
SimpleRank.score = 0
SimpleRank.NOT_IN_RANK = -1
SimpleRank.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
end

SimpleRank.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.score) then
    return false
  end
  return true
end

SimpleRank.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.baseUserData):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SimpleRank

