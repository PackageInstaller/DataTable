-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/rune/sruneinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRuneInfo = dataclass("SRuneInfo", require("framework.net.protocol"))
SRuneInfo.ProtocolType = 3701
SRuneInfo.MaxSize = 65535
SRuneInfo.state = 0
SRuneInfo.dialogId = 0
SRuneInfo.RUNE = 1
SRuneInfo.NO_RUNE = 0
SRuneInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRuneInfo
  ((SRuneInfo.super).Ctor)(self, client)
end

SRuneInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dialogId) then
    return false
  end
  return true
end

SRuneInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRuneInfo

