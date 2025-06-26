-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/arenaranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ArenaRanking = dataclass("ArenaRanking")
ArenaRanking.rank = 0
ArenaRanking.pithy = 0
ArenaRanking.NOT_IN_RANK = -1
ArenaRanking.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
end

ArenaRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.pithy) then
    return false
  end
  return true
end

ArenaRanking.Unmarshal = function(self, buffer)
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

return ArenaRanking

