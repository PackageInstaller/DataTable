-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/battleverifyinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BattleVerifyInfo = dataclass("BattleVerifyInfo")
BattleVerifyInfo.ptype = 0
BattleVerifyInfo.step = 0
BattleVerifyInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.content = ((require("protocols.bean.protocol.battle.battleverifyproparam")).Create)()
end

BattleVerifyInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.content):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.ptype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.step) then
    return false
  end
  return true
end

BattleVerifyInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.content):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return BattleVerifyInfo

