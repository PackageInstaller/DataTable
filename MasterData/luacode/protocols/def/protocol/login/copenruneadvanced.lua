-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/copenruneadvanced.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenRuneAdvanced = dataclass("COpenRuneAdvanced", require("framework.net.protocol"))
COpenRuneAdvanced.ProtocolType = 1095
COpenRuneAdvanced.MaxSize = 65535
COpenRuneAdvanced.roleId = 0
COpenRuneAdvanced.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenRuneAdvanced
  ((COpenRuneAdvanced.super).Ctor)(self, client)
end

COpenRuneAdvanced.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

COpenRuneAdvanced.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenRuneAdvanced

