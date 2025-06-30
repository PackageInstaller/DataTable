-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cchangethemename.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeThemeName = dataclass("CChangeThemeName", require("framework.net.protocol"))
CChangeThemeName.ProtocolType = 2363
CChangeThemeName.MaxSize = 65535
CChangeThemeName.name = ""
CChangeThemeName.key = 0
CChangeThemeName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeThemeName
  ((CChangeThemeName.super).Ctor)(self, client)
end

CChangeThemeName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  return true
end

CChangeThemeName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeThemeName

