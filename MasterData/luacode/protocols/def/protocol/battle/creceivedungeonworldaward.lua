-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/creceivedungeonworldaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveDungeonWorldAward = dataclass("CReceiveDungeonWorldAward", require("framework.net.protocol"))
CReceiveDungeonWorldAward.ProtocolType = 1959
CReceiveDungeonWorldAward.MaxSize = 65535
CReceiveDungeonWorldAward.id = 0
CReceiveDungeonWorldAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveDungeonWorldAward
  ((CReceiveDungeonWorldAward.super).Ctor)(self, client)
end

CReceiveDungeonWorldAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveDungeonWorldAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveDungeonWorldAward

