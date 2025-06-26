-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sconfirmsummerentries.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SConfirmSummerEntries = dataclass("SConfirmSummerEntries", require("framework.net.protocol"))
SConfirmSummerEntries.ProtocolType = 2718
SConfirmSummerEntries.MaxSize = 65535
SConfirmSummerEntries.result = 0
SConfirmSummerEntries.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SConfirmSummerEntries
  ((SConfirmSummerEntries.super).Ctor)(self, client)
end

SConfirmSummerEntries.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SConfirmSummerEntries.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SConfirmSummerEntries

