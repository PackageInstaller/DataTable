-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copencompletelineup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenCompleteLineup = dataclass("COpenCompleteLineup", require("framework.net.protocol"))
COpenCompleteLineup.ProtocolType = 4126
COpenCompleteLineup.MaxSize = 65535
COpenCompleteLineup.zoneId = 0
COpenCompleteLineup.playType = 0
COpenCompleteLineup.RESOURCE_LINEUP = 1
COpenCompleteLineup.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenCompleteLineup
  ((COpenCompleteLineup.super).Ctor)(self, client)
end

COpenCompleteLineup.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.zoneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.playType) then
    return false
  end
  return true
end

COpenCompleteLineup.Unmarshal = function(self, buffer)
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

return COpenCompleteLineup

