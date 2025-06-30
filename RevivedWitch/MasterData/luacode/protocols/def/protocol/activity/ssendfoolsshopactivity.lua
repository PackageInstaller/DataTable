-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssendfoolsshopactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendFoolsShopActivity = dataclass("SSendFoolsShopActivity", require("framework.net.protocol"))
SSendFoolsShopActivity.ProtocolType = 2619
SSendFoolsShopActivity.MaxSize = 65535
SSendFoolsShopActivity.state = 0
SSendFoolsShopActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendFoolsShopActivity
  ((SSendFoolsShopActivity.super).Ctor)(self, client)
end

SSendFoolsShopActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  return true
end

SSendFoolsShopActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendFoolsShopActivity

