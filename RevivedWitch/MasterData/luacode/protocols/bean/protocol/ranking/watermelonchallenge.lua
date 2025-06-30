-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/watermelonchallenge.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local WatermelonChallenge = dataclass("WatermelonChallenge")
WatermelonChallenge.rank = 0
WatermelonChallenge.NOT_ON_LIST = -1
WatermelonChallenge.NOT_Challenge = -2
WatermelonChallenge.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.watermelonPanelData = ((require("protocols.bean.protocol.ranking.watermelonpaneldata")).Create)()
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
end

WatermelonChallenge.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  if not (self.watermelonPanelData):Marshal(buffer) then
    return false
  end
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  return true
end

WatermelonChallenge.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.watermelonPanelData):Unmarshal(buffer) then
    return false
  end
  if not (self.baseUserData):Unmarshal(buffer) then
    return false
  end
  return ret
end

return WatermelonChallenge

