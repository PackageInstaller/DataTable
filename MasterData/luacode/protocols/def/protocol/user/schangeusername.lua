-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/schangeusername.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeUserName = dataclass("SChangeUserName", require("framework.net.protocol"))
SChangeUserName.ProtocolType = 2221
SChangeUserName.MaxSize = 65535
SChangeUserName.name = ""
SChangeUserName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeUserName
  ((SChangeUserName.super).Ctor)(self, client)
end

SChangeUserName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

SChangeUserName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserName

