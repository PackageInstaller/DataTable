-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/scommit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCommit = dataclass("SCommit", require("framework.net.protocol"))
SCommit.ProtocolType = 1954
SCommit.MaxSize = 65535
SCommit.kind = 0
SCommit.kindValue = 0
SCommit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCommit
  ((SCommit.super).Ctor)(self, client)
end

SCommit.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kindValue) then
    return false
  end
  return true
end

SCommit.Unmarshal = function(self, buffer)
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

return SCommit

