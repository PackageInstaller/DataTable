-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/susegiftkey.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUseGiftKey = dataclass("SUseGiftKey", require("framework.net.protocol"))
SUseGiftKey.ProtocolType = 1253
SUseGiftKey.MaxSize = 65535
SUseGiftKey.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUseGiftKey
  ((SUseGiftKey.super).Ctor)(self, client)
end

SUseGiftKey.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SUseGiftKey.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SUseGiftKey

