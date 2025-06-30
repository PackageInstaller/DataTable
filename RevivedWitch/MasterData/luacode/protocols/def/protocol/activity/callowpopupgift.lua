-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/callowpopupgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAllowPopUpGift = dataclass("CAllowPopUpGift", require("framework.net.protocol"))
CAllowPopUpGift.ProtocolType = 2690
CAllowPopUpGift.MaxSize = 65535
CAllowPopUpGift.activityID = 0
CAllowPopUpGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAllowPopUpGift
  ((CAllowPopUpGift.super).Ctor)(self, client)
end

CAllowPopUpGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  return true
end

CAllowPopUpGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAllowPopUpGift

