-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cusegiftkey.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUseGiftKey = dataclass("CUseGiftKey", require("framework.net.protocol"))
CUseGiftKey.ProtocolType = 1246
CUseGiftKey.MaxSize = 65535
CUseGiftKey.giftkey = ""
CUseGiftKey.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUseGiftKey
  ((CUseGiftKey.super).Ctor)(self, client)
end

CUseGiftKey.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.giftkey) then
    return false
  end
  return true
end

CUseGiftKey.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseGiftKey

