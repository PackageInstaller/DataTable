-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/cchangeusername.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeUserName = dataclass("CChangeUserName", require("framework.net.protocol"))
CChangeUserName.ProtocolType = 2220
CChangeUserName.MaxSize = 65535
CChangeUserName.name = ""
CChangeUserName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeUserName
  ((CChangeUserName.super).Ctor)(self, client)
end

CChangeUserName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

CChangeUserName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserName

