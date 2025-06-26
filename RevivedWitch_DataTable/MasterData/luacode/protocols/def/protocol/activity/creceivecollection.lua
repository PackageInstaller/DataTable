-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivecollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveCollection = dataclass("CReceiveCollection", require("framework.net.protocol"))
CReceiveCollection.ProtocolType = 2405
CReceiveCollection.MaxSize = 65535
CReceiveCollection.CollectionType = 0
CReceiveCollection.level = 0
CReceiveCollection.HIGH = 2
CReceiveCollection.COMMON = 1
CReceiveCollection.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveCollection
  ((CReceiveCollection.super).Ctor)(self, client)
end

CReceiveCollection.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.CollectionType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  return true
end

CReceiveCollection.Unmarshal = function(self, buffer)
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

return CReceiveCollection

