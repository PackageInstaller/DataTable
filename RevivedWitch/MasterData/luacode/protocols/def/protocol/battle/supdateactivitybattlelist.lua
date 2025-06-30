-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/supdateactivitybattlelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateActivityBattleList = dataclass("SUpdateActivityBattleList", require("framework.net.protocol"))
SUpdateActivityBattleList.ProtocolType = 4127
SUpdateActivityBattleList.MaxSize = 65535
SUpdateActivityBattleList.activityId = 0
SUpdateActivityBattleList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateActivityBattleList
  ((SUpdateActivityBattleList.super).Ctor)(self, client)
  self.battleNodes = {}
end

SUpdateActivityBattleList.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  local length = (table.slen)(self.battleNodes)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.battleNodes)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SUpdateActivityBattleList.Unmarshal = function(self, buffer)
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

    (self.battleNodes)[i] = ((require("protocols.bean.protocol.battle.activitybattlenode")).Create)()
    if not ((self.battleNodes)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateActivityBattleList

