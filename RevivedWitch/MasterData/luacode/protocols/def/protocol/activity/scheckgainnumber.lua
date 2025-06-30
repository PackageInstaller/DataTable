-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/scheckgainnumber.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCheckGainNumber = dataclass("SCheckGainNumber", require("framework.net.protocol"))
SCheckGainNumber.ProtocolType = 2607
SCheckGainNumber.MaxSize = 65535
SCheckGainNumber.number = 0
SCheckGainNumber.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCheckGainNumber
  ((SCheckGainNumber.super).Ctor)(self, client)
end

SCheckGainNumber.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.number) then
    return false
  end
  return true
end

SCheckGainNumber.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckGainNumber

