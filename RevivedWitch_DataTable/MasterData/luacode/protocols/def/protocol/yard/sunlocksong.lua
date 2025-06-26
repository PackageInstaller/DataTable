-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/sunlocksong.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUnlockSong = dataclass("SUnlockSong", require("framework.net.protocol"))
SUnlockSong.ProtocolType = 2384
SUnlockSong.MaxSize = 65535
SUnlockSong.id = 0
SUnlockSong.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUnlockSong
  ((SUnlockSong.super).Ctor)(self, client)
end

SUnlockSong.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

SUnlockSong.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockSong

