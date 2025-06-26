-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/smove2battleisland.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SMove2BattleIsland = dataclass("SMove2BattleIsland", require("framework.net.protocol"))
SMove2BattleIsland.ProtocolType = 1996
SMove2BattleIsland.MaxSize = 65535
SMove2BattleIsland.islandID = 0
SMove2BattleIsland.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SMove2BattleIsland
  ((SMove2BattleIsland.super).Ctor)(self, client)
  self.enemy = {}
end

SMove2BattleIsland.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.islandID) then
    return false
  end
  local length = (table.slen)(self.enemy)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.enemy)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SMove2BattleIsland.Unmarshal = function(self, buffer)
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

    (self.enemy)[i] = ((require("protocols.bean.protocol.battle.islandmonsterinfo")).Create)()
    if not ((self.enemy)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SMove2BattleIsland

