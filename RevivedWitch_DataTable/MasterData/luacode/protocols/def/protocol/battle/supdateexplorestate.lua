-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/supdateexplorestate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateExploreState = dataclass("SUpdateExploreState", require("framework.net.protocol"))
SUpdateExploreState.ProtocolType = 1929
SUpdateExploreState.MaxSize = 65535
SUpdateExploreState.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateExploreState
  ((SUpdateExploreState.super).Ctor)(self, client)
  self.traps = {}
  self.switches = {}
end

SUpdateExploreState.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.traps)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.traps)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.switches)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.switches)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SUpdateExploreState.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.traps)[i] = ((require("protocols.bean.protocol.battle.exploreinstance")).Create)()
    if not ((self.traps)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (self.switches)[i] = ((require("protocols.bean.protocol.battle.switchesinstance")).Create)()
    if not ((self.switches)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SUpdateExploreState

