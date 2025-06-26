-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetbackgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetBackGift = dataclass("CGetBackGift", require("framework.net.protocol"))
CGetBackGift.ProtocolType = 2557
CGetBackGift.MaxSize = 65535
CGetBackGift.goodId = 0
CGetBackGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetBackGift
  ((CGetBackGift.super).Ctor)(self, client)
end

CGetBackGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  return true
end

CGetBackGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetBackGift

