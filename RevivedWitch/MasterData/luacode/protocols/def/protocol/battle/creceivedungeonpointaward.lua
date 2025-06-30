-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/creceivedungeonpointaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveDungeonPointAward = dataclass("CReceiveDungeonPointAward", require("framework.net.protocol"))
CReceiveDungeonPointAward.ProtocolType = 1961
CReceiveDungeonPointAward.MaxSize = 65535
CReceiveDungeonPointAward.id = 0
CReceiveDungeonPointAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveDungeonPointAward
  ((CReceiveDungeonPointAward.super).Ctor)(self, client)
end

CReceiveDungeonPointAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveDungeonPointAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveDungeonPointAward

