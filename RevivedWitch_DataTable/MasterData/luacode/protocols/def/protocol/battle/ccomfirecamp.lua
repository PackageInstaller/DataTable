-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ccomfirecamp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CComfireCamp = dataclass("CComfireCamp", require("framework.net.protocol"))
CComfireCamp.ProtocolType = 4110
CComfireCamp.MaxSize = 65535
CComfireCamp.camp = 0
CComfireCamp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CComfireCamp
  ((CComfireCamp.super).Ctor)(self, client)
end

CComfireCamp.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.camp) then
    return false
  end
  return true
end

CComfireCamp.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CComfireCamp

