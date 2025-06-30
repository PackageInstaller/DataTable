-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/crequestpartybossrank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRequestPartyBossRank = dataclass("CRequestPartyBossRank", require("framework.net.protocol"))
CRequestPartyBossRank.ProtocolType = 5043
CRequestPartyBossRank.MaxSize = 65535
CRequestPartyBossRank.bossid = 0
CRequestPartyBossRank.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRequestPartyBossRank
  ((CRequestPartyBossRank.super).Ctor)(self, client)
end

CRequestPartyBossRank.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossid) then
    return false
  end
  return true
end

CRequestPartyBossRank.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRequestPartyBossRank

