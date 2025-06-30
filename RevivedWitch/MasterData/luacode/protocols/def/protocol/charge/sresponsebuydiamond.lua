-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/charge/sresponsebuydiamond.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SResponseBuyDiamond = dataclass("SResponseBuyDiamond", require("framework.net.protocol"))
SResponseBuyDiamond.ProtocolType = 3902
SResponseBuyDiamond.MaxSize = 65535
SResponseBuyDiamond.gameorderid = ""
SResponseBuyDiamond.goodid = ""
SResponseBuyDiamond.goodname = ""
SResponseBuyDiamond.platType = 0
SResponseBuyDiamond.gearid = 0
SResponseBuyDiamond.extraparam = ""
SResponseBuyDiamond.price = 0
SResponseBuyDiamond.url = ""
SResponseBuyDiamond.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SResponseBuyDiamond
  ((SResponseBuyDiamond.super).Ctor)(self, client)
end

SResponseBuyDiamond.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.gameorderid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.goodid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.goodname) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.platType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.gearid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.extraparam) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.price) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.url) then
    return false
  end
  return true
end

SResponseBuyDiamond.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SResponseBuyDiamond

