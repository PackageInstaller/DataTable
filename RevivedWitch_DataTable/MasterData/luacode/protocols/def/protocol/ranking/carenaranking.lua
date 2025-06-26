-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/carenaranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CArenaRanking = dataclass("CArenaRanking", require("framework.net.protocol"))
CArenaRanking.ProtocolType = 3507
CArenaRanking.MaxSize = 65535
CArenaRanking.index = 0
CArenaRanking.RANK_TYPE_CURRENT = 0
CArenaRanking.RANK_TYPE_TOTAL = 1
CArenaRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CArenaRanking
  ((CArenaRanking.super).Ctor)(self, client)
end

CArenaRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.index) then
    return false
  end
  return true
end

CArenaRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CArenaRanking

