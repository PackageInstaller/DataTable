local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendFoolsShopActivity = dataclass("SSendFoolsShopActivity", require("framework.net.protocol"))
SSendFoolsShopActivity.ProtocolType = 2619
SSendFoolsShopActivity.MaxSize = 65535
SSendFoolsShopActivity.state = 0

function SSendFoolsShopActivity:Ctor(client)
  SSendFoolsShopActivity.super.Ctor(self, client)
end

function SSendFoolsShopActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SSendFoolsShopActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendFoolsShopActivity
