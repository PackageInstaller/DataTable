-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sconfirmentries.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SConfirmEntries = dataclass("SConfirmEntries", require("framework.net.protocol"))
SConfirmEntries.ProtocolType = 2486
SConfirmEntries.MaxSize = 65535
SConfirmEntries.score = 0
SConfirmEntries.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SConfirmEntries
  ((SConfirmEntries.super).Ctor)(self, client)
end

SConfirmEntries.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.score) then
    return false
  end
  return true
end

SConfirmEntries.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SConfirmEntries

