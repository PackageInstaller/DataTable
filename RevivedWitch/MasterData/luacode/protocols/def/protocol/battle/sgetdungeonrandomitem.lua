-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sgetdungeonrandomitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetDungeonRandomItem = dataclass("SGetDungeonRandomItem", require("framework.net.protocol"))
SGetDungeonRandomItem.ProtocolType = 1931
SGetDungeonRandomItem.MaxSize = 65535
SGetDungeonRandomItem.sceneId = 0
SGetDungeonRandomItem.key = 0
SGetDungeonRandomItem.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetDungeonRandomItem
  ((SGetDungeonRandomItem.super).Ctor)(self, client)
end

SGetDungeonRandomItem.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sceneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  return true
end

SGetDungeonRandomItem.Unmarshal = function(self, buffer)
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

return SGetDungeonRandomItem

