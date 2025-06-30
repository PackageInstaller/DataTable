-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/srecordguide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRecordGuide = dataclass("SRecordGuide", require("framework.net.protocol"))
SRecordGuide.ProtocolType = 2215
SRecordGuide.MaxSize = 65535
SRecordGuide.guide = 0
SRecordGuide.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRecordGuide
  ((SRecordGuide.super).Ctor)(self, client)
end

SRecordGuide.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.guide) then
    return false
  end
  return true
end

SRecordGuide.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRecordGuide

