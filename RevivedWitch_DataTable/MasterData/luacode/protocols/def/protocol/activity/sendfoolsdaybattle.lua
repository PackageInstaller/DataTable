-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sendfoolsdaybattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEndFoolsDayBattle = dataclass("SEndFoolsDayBattle", require("framework.net.protocol"))
SEndFoolsDayBattle.ProtocolType = 2634
SEndFoolsDayBattle.MaxSize = 65535
SEndFoolsDayBattle.battleType = 0
SEndFoolsDayBattle.result = 0
SEndFoolsDayBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEndFoolsDayBattle
  ((SEndFoolsDayBattle.super).Ctor)(self, client)
end

SEndFoolsDayBattle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SEndFoolsDayBattle.Unmarshal = function(self, buffer)
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
  return ret
end

return SEndFoolsDayBattle

