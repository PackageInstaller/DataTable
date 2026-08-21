-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crecordguide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordGuide = dataclass("CRecordGuide", require("framework.net.protocol"))
CRecordGuide.ProtocolType = 2211
CRecordGuide.MaxSize = 65535
CRecordGuide.guide = 0
CRecordGuide.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordGuide
  ((CRecordGuide.super).Ctor)(self, client)
end

CRecordGuide.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.guide) then
    return false
  end
  return true
end

CRecordGuide.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordGuide

