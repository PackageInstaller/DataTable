-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/sresponsepartybossrank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SResponsePartyBossRank = dataclass("SResponsePartyBossRank", require("framework.net.protocol"))
SResponsePartyBossRank.ProtocolType = 5044
SResponsePartyBossRank.MaxSize = 65535
SResponsePartyBossRank.bossid = 0
SResponsePartyBossRank.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SResponsePartyBossRank, _ENV
  ((SResponsePartyBossRank.super).Ctor)(self, client)
  self.ranking = {}
  self.myrank = ((require("protocols.bean.protocol.party.boss.partybosschallenge")).Create)()
end

SResponsePartyBossRank.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossid) then
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
  if not (self.myrank):Marshal(buffer) then
    return false
  end
  return true
end

SResponsePartyBossRank.Unmarshal = function(self, buffer)
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

    (self.ranking)[i] = ((require("protocols.bean.protocol.party.boss.partybosschallenge")).Create)()
    if not ((self.ranking)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.myrank):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SResponsePartyBossRank

