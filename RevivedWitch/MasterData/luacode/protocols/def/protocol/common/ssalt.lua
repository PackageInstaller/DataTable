-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/common/ssalt.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSalt = dataclass("SSalt", require("framework.net.protocol"))
SSalt.ProtocolType = 107
SSalt.MaxSize = 256
SSalt.salt = ""
SSalt.open = 0
SSalt.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSalt
  ((SSalt.super).Ctor)(self, client)
end

SSalt.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.salt) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.open) then
    return false
  end
  return true
end

SSalt.Unmarshal = function(self, buffer)
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

return SSalt

