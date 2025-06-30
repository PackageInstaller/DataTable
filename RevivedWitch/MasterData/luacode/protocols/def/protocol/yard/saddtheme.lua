-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/saddtheme.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddTheme = dataclass("SAddTheme", require("framework.net.protocol"))
SAddTheme.ProtocolType = 2362
SAddTheme.MaxSize = 65535
SAddTheme.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddTheme, _ENV
  ((SAddTheme.super).Ctor)(self, client)
  self.theme = ((require("protocols.bean.protocol.yard.theme")).Create)()
end

SAddTheme.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.theme):Marshal(buffer) then
    return false
  end
  return true
end

SAddTheme.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.theme):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SAddTheme

