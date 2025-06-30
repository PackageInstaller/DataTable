-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/sarenaranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SArenaRanking = dataclass("SArenaRanking", require("framework.net.protocol"))
SArenaRanking.ProtocolType = 3508
SArenaRanking.MaxSize = 655350
SArenaRanking.index = 0
SArenaRanking.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SArenaRanking, _ENV
  ((SArenaRanking.super).Ctor)(self, client)
  self.ranking = {}
  self.playerRanking = ((require("protocols.bean.protocol.ranking.arenaranking")).Create)()
end

SArenaRanking.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  local length = (table.slen)(self.ranking)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.ranking)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.playerRanking):Marshal(buffer) then
    return false
  end
  return true
end

SArenaRanking.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.ranking)[i] = ((require("protocols.bean.protocol.ranking.arenaranking")).Create)()
    if not ((self.ranking)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.playerRanking):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SArenaRanking

