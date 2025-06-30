-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/shandbooksoulnum.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SHandbookSoulNum = dataclass("SHandbookSoulNum", require("framework.net.protocol"))
SHandbookSoulNum.ProtocolType = 2261
SHandbookSoulNum.MaxSize = 65535
SHandbookSoulNum.HandBookId = 0
SHandbookSoulNum.soulNum = 0
SHandbookSoulNum.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SHandbookSoulNum
  ((SHandbookSoulNum.super).Ctor)(self, client)
end

SHandbookSoulNum.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.HandBookId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.soulNum) then
    return false
  end
  return true
end

SHandbookSoulNum.Unmarshal = function(self, buffer)
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

return SHandbookSoulNum

