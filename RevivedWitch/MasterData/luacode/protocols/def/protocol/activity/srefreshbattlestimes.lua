-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshbattlestimes.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshBattlesTimes = dataclass("SRefreshBattlesTimes", require("framework.net.protocol"))
SRefreshBattlesTimes.ProtocolType = 2638
SRefreshBattlesTimes.MaxSize = 65535
SRefreshBattlesTimes.bossId = 0
SRefreshBattlesTimes.resetConfigId = 0
SRefreshBattlesTimes.leftTimes = 0
SRefreshBattlesTimes.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshBattlesTimes
  ((SRefreshBattlesTimes.super).Ctor)(self, client)
end

SRefreshBattlesTimes.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.resetConfigId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftTimes) then
    return false
  end
  return true
end

SRefreshBattlesTimes.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
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

return SRefreshBattlesTimes

