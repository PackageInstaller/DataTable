-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/slookcardbaseattr.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLookCardBaseAttr = dataclass("SLookCardBaseAttr", require("framework.net.protocol"))
SLookCardBaseAttr.ProtocolType = 1526
SLookCardBaseAttr.MaxSize = 65535
SLookCardBaseAttr.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLookCardBaseAttr, _ENV
  ((SLookCardBaseAttr.super).Ctor)(self, client)
  self.role = ((require("protocols.bean.protocol.card.role")).Create)()
end

SLookCardBaseAttr.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.role):Marshal(buffer) then
    return false
  end
  return true
end

SLookCardBaseAttr.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.role):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SLookCardBaseAttr

