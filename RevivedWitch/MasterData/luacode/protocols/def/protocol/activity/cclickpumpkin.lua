-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cclickpumpkin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CClickPumpkin = dataclass("CClickPumpkin", require("framework.net.protocol"))
CClickPumpkin.ProtocolType = 2517
CClickPumpkin.MaxSize = 65535
CClickPumpkin.pumpkinId = 0
CClickPumpkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CClickPumpkin
  ((CClickPumpkin.super).Ctor)(self, client)
end

CClickPumpkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pumpkinId) then
    return false
  end
  return true
end

CClickPumpkin.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CClickPumpkin

