-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/bosschallenge.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BossChallenge = dataclass("BossChallenge")
BossChallenge.rank = 0
BossChallenge.NOT_ON_LIST = -1
BossChallenge.NOT_Challenge = -2
BossChallenge.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.bossPanelData = ((require("protocols.bean.protocol.ranking.bosspaneldata")).Create)()
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
end

BossChallenge.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  if not (self.bossPanelData):Marshal(buffer) then
    return false
  end
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  return true
end

BossChallenge.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.bossPanelData):Unmarshal(buffer) then
    return false
  end
  if not (self.baseUserData):Unmarshal(buffer) then
    return false
  end
  return ret
end

return BossChallenge

