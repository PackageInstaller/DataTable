-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cfantasyconflictdefendrecord.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFantasyConflictDefendRecord = dataclass("CFantasyConflictDefendRecord", require("framework.net.protocol"))
CFantasyConflictDefendRecord.ProtocolType = 4155
CFantasyConflictDefendRecord.MaxSize = 65535
CFantasyConflictDefendRecord.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFantasyConflictDefendRecord
  ((CFantasyConflictDefendRecord.super).Ctor)(self, client)
end

CFantasyConflictDefendRecord.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CFantasyConflictDefendRecord.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CFantasyConflictDefendRecord

