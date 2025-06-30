-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/common.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Common = dataclass("Common", require("framework.net.protocol"))
Common.ProtocolType = 3600
Common.MaxSize = 256
Common.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : Common, _ENV
  ((Common.super).Ctor)(self, client)
  self.b1 = ((require("protocols.bean.protocol.ranking.ranktype")).Create)()
  self.b2 = ((require("protocols.bean.protocol.ranking.rankversion")).Create)()
end

Common.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.b1):Marshal(buffer) then
    return false
  end
  if not (self.b2):Marshal(buffer) then
    return false
  end
  return true
end

Common.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.b1):Unmarshal(buffer) then
    return false
  end
  if not (self.b2):Unmarshal(buffer) then
    return false
  end
  return ret
end

return Common

