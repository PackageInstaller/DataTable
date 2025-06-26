-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshmagictree.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshMagicTree = dataclass("SRefreshMagicTree", require("framework.net.protocol"))
SRefreshMagicTree.ProtocolType = 2311
SRefreshMagicTree.MaxSize = 65535
SRefreshMagicTree.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshMagicTree, _ENV
  ((SRefreshMagicTree.super).Ctor)(self, client)
  self.magicTree = ((require("protocols.bean.protocol.yard.magictree")).Create)()
end

SRefreshMagicTree.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.magicTree):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshMagicTree.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.magicTree):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshMagicTree

