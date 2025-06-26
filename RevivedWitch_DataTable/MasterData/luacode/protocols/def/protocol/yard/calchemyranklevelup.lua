-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/calchemyranklevelup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAlchemyRankLevelUp = dataclass("CAlchemyRankLevelUp", require("framework.net.protocol"))
CAlchemyRankLevelUp.ProtocolType = 2370
CAlchemyRankLevelUp.MaxSize = 65535
CAlchemyRankLevelUp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAlchemyRankLevelUp
  ((CAlchemyRankLevelUp.super).Ctor)(self, client)
end

CAlchemyRankLevelUp.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CAlchemyRankLevelUp.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CAlchemyRankLevelUp

