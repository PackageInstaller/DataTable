-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cgetactivitybattlelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetActivityBattleList = dataclass("CGetActivityBattleList", require("framework.net.protocol"))
CGetActivityBattleList.ProtocolType = 4123
CGetActivityBattleList.MaxSize = 65535
CGetActivityBattleList.activityId = 0
CGetActivityBattleList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetActivityBattleList
  ((CGetActivityBattleList.super).Ctor)(self, client)
end

CGetActivityBattleList.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  return true
end

CGetActivityBattleList.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetActivityBattleList

