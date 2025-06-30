-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ccomplementsigned.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CComplementSigned = dataclass("CComplementSigned", require("framework.net.protocol"))
CComplementSigned.ProtocolType = 2679
CComplementSigned.MaxSize = 65535
CComplementSigned.dayId = 0
CComplementSigned.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CComplementSigned
  ((CComplementSigned.super).Ctor)(self, client)
end

CComplementSigned.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dayId) then
    return false
  end
  return true
end

CComplementSigned.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CComplementSigned

