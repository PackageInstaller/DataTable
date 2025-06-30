-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sgetshophomepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetShopHomepage = dataclass("SGetShopHomepage", require("framework.net.protocol"))
SGetShopHomepage.ProtocolType = 3619
SGetShopHomepage.MaxSize = 65535
SGetShopHomepage.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetShopHomepage
  ((SGetShopHomepage.super).Ctor)(self, client)
  self.dailyGitfInfo = {}
  self.monthCardInfo = {}
end

SGetShopHomepage.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.dailyGitfInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.dailyGitfInfo)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.monthCardInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.monthCardInfo)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SGetShopHomepage.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.dailyGitfInfo)[i] = ((require("protocols.bean.protocol.shop.mixgoodinfo")).Create)()
    if not ((self.dailyGitfInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (self.monthCardInfo)[i] = ((require("protocols.bean.protocol.shop.mixgoodinfo")).Create)()
    if not ((self.monthCardInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetShopHomepage

