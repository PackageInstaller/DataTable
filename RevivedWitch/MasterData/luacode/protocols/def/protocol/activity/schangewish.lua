-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schangewish.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeWish = dataclass("SChangeWish", require("framework.net.protocol"))
SChangeWish.ProtocolType = 2544
SChangeWish.MaxSize = 65535
SChangeWish.index = 0
SChangeWish.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeWish
  ((SChangeWish.super).Ctor)(self, client)
end

SChangeWish.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  return true
end

SChangeWish.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeWish

