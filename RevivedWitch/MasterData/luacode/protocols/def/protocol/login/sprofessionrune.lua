-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sprofessionrune.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SProfessionRune = dataclass("SProfessionRune", require("framework.net.protocol"))
SProfessionRune.ProtocolType = 1098
SProfessionRune.MaxSize = 65535
SProfessionRune.roleId = 0
SProfessionRune.professionRune = 0
SProfessionRune.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SProfessionRune
  ((SProfessionRune.super).Ctor)(self, client)
end

SProfessionRune.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.professionRune) then
    return false
  end
  return true
end

SProfessionRune.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SProfessionRune

