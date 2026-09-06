local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetShopHomepage = dataclass("SGetShopHomepage", require("framework.net.protocol"))
SGetShopHomepage.ProtocolType = 3619
SGetShopHomepage.MaxSize = 65535

function SGetShopHomepage:Ctor(client)
  SGetShopHomepage.super.Ctor(self, client)
  self.dailyGitfInfo = {}
  self.monthCardInfo = {}
end

function SGetShopHomepage:Marshal(buffer)
  local length = table.slen(self.dailyGitfInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.dailyGitfInfo[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.monthCardInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.monthCardInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetShopHomepage:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.dailyGitfInfo[i] = require("protocols.bean.protocol.shop.mixgoodinfo").Create()
    if not self.dailyGitfInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.monthCardInfo[i] = require("protocols.bean.protocol.shop.mixgoodinfo").Create()
    if not self.monthCardInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetShopHomepage
