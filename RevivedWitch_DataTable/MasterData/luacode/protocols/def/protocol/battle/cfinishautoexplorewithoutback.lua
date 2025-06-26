-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cfinishautoexplorewithoutback.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFinishAutoExploreWithoutBack = dataclass("CFinishAutoExploreWithoutBack", require("framework.net.protocol"))
CFinishAutoExploreWithoutBack.ProtocolType = 4131
CFinishAutoExploreWithoutBack.MaxSize = 65535
CFinishAutoExploreWithoutBack.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFinishAutoExploreWithoutBack
  ((CFinishAutoExploreWithoutBack.super).Ctor)(self, client)
end

CFinishAutoExploreWithoutBack.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CFinishAutoExploreWithoutBack.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CFinishAutoExploreWithoutBack

