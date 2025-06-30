-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crecordbuffguide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecordBuffGuide = dataclass("CRecordBuffGuide", require("framework.net.protocol"))
CRecordBuffGuide.ProtocolType = 2270
CRecordBuffGuide.MaxSize = 65535
CRecordBuffGuide.buffType = 0
CRecordBuffGuide.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecordBuffGuide
  ((CRecordBuffGuide.super).Ctor)(self, client)
end

CRecordBuffGuide.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.buffType) then
    return false
  end
  return true
end

CRecordBuffGuide.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecordBuffGuide

