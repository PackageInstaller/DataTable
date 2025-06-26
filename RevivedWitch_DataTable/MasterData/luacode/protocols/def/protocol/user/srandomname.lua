-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/srandomname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRandomName = dataclass("SRandomName", require("framework.net.protocol"))
SRandomName.ProtocolType = 2204
SRandomName.MaxSize = 65535
SRandomName.name = ""
SRandomName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRandomName
  ((SRandomName.super).Ctor)(self, client)
end

SRandomName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

SRandomName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRandomName

