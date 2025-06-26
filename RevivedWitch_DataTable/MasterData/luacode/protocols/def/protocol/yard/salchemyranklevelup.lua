-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/salchemyranklevelup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAlchemyRankLevelUp = dataclass("SAlchemyRankLevelUp", require("framework.net.protocol"))
SAlchemyRankLevelUp.ProtocolType = 2371
SAlchemyRankLevelUp.MaxSize = 65535
SAlchemyRankLevelUp.level = 0
SAlchemyRankLevelUp.stage = 0
SAlchemyRankLevelUp.exp = 0
SAlchemyRankLevelUp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAlchemyRankLevelUp
  ((SAlchemyRankLevelUp.super).Ctor)(self, client)
end

SAlchemyRankLevelUp.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.exp) then
    return false
  end
  return true
end

SAlchemyRankLevelUp.Unmarshal = function(self, buffer)
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

return SAlchemyRankLevelUp

