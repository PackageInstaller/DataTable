-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cdeletetheme.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDeleteTheme = dataclass("CDeleteTheme", require("framework.net.protocol"))
CDeleteTheme.ProtocolType = 2365
CDeleteTheme.MaxSize = 65535
CDeleteTheme.key = 0
CDeleteTheme.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDeleteTheme
  ((CDeleteTheme.super).Ctor)(self, client)
end

CDeleteTheme.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  return true
end

CDeleteTheme.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteTheme

