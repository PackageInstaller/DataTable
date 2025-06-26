-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/srecordexploreaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRecordExploreAward = dataclass("SRecordExploreAward", require("framework.net.protocol"))
SRecordExploreAward.ProtocolType = 1967
SRecordExploreAward.MaxSize = 65535
SRecordExploreAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRecordExploreAward
  ((SRecordExploreAward.super).Ctor)(self, client)
  self.records = {}
end

SRecordExploreAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.records)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.records)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SRecordExploreAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.records)[i] = ((require("protocols.bean.protocol.battle.exploreawardrecord")).Create)()
    if not ((self.records)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRecordExploreAward

