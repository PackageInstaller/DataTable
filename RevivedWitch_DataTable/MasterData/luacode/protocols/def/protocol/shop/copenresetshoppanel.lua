-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/copenresetshoppanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenResetShopPanel = dataclass("COpenResetShopPanel", require("framework.net.protocol"))
COpenResetShopPanel.ProtocolType = 3624
COpenResetShopPanel.MaxSize = 65535
COpenResetShopPanel.shopType = 0
COpenResetShopPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenResetShopPanel
  ((COpenResetShopPanel.super).Ctor)(self, client)
end

COpenResetShopPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopType) then
    return false
  end
  return true
end

COpenResetShopPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenResetShopPanel

