-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/saddoverviewskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddOverviewSkin = dataclass("SAddOverviewSkin", require("framework.net.protocol"))
SAddOverviewSkin.ProtocolType = 1272
SAddOverviewSkin.MaxSize = 65535
SAddOverviewSkin.skinId = 0
SAddOverviewSkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddOverviewSkin
  ((SAddOverviewSkin.super).Ctor)(self, client)
end

SAddOverviewSkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skinId) then
    return false
  end
  return true
end

SAddOverviewSkin.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddOverviewSkin

