-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/sinitmusic.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SInitMusic = dataclass("SInitMusic", require("framework.net.protocol"))
SInitMusic.ProtocolType = 2386
SInitMusic.MaxSize = 65535
SInitMusic.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SInitMusic, _ENV
  ((SInitMusic.super).Ctor)(self, client)
  self.music = ((require("protocols.bean.protocol.yard.music")).Create)()
end

SInitMusic.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.music):Marshal(buffer) then
    return false
  end
  return true
end

SInitMusic.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.music):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SInitMusic

