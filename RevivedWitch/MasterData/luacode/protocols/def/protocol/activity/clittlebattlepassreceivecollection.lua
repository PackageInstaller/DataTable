-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/clittlebattlepassreceivecollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLittleBattlePassReceiveCollection = dataclass("CLittleBattlePassReceiveCollection", require("framework.net.protocol"))
CLittleBattlePassReceiveCollection.ProtocolType = 2664
CLittleBattlePassReceiveCollection.MaxSize = 65535
CLittleBattlePassReceiveCollection.CollectionType = 0
CLittleBattlePassReceiveCollection.level = 0
CLittleBattlePassReceiveCollection.HIGH = 2
CLittleBattlePassReceiveCollection.COMMON = 1
CLittleBattlePassReceiveCollection.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLittleBattlePassReceiveCollection
  ((CLittleBattlePassReceiveCollection.super).Ctor)(self, client)
end

CLittleBattlePassReceiveCollection.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.CollectionType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  return true
end

CLittleBattlePassReceiveCollection.Unmarshal = function(self, buffer)
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

return CLittleBattlePassReceiveCollection

