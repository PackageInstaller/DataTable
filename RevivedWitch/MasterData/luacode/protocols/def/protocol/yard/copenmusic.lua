-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/copenmusic.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenMusic = dataclass("COpenMusic", require("framework.net.protocol"))
COpenMusic.ProtocolType = 2385
COpenMusic.MaxSize = 65535
COpenMusic.albumId = 0
COpenMusic.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenMusic
  ((COpenMusic.super).Ctor)(self, client)
end

COpenMusic.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.albumId) then
    return false
  end
  return true
end

COpenMusic.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenMusic

