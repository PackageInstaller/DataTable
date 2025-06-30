-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/saddemoji.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddEmoji = dataclass("SAddEmoji", require("framework.net.protocol"))
SAddEmoji.ProtocolType = 1167
SAddEmoji.MaxSize = 65535
SAddEmoji.eomjiId = 0
SAddEmoji.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddEmoji
  ((SAddEmoji.super).Ctor)(self, client)
end

SAddEmoji.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eomjiId) then
    return false
  end
  return true
end

SAddEmoji.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddEmoji

