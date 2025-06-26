-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cstartfoolsdaybattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStartFoolsDayBattle = dataclass("CStartFoolsDayBattle", require("framework.net.protocol"))
CStartFoolsDayBattle.ProtocolType = 2633
CStartFoolsDayBattle.MaxSize = 65535
CStartFoolsDayBattle.battleType = 0
CStartFoolsDayBattle.battleId = 0
CStartFoolsDayBattle.COPY_BATTLE = 1
CStartFoolsDayBattle.FLOOR = 2
CStartFoolsDayBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStartFoolsDayBattle
  ((CStartFoolsDayBattle.super).Ctor)(self, client)
end

CStartFoolsDayBattle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleId) then
    return false
  end
  return true
end

CStartFoolsDayBattle.Unmarshal = function(self, buffer)
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

return CStartFoolsDayBattle

