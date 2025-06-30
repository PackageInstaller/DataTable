-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/notify/scancelloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCancelLoading = dataclass("SCancelLoading", require("framework.net.protocol"))
SCancelLoading.ProtocolType = 1805
SCancelLoading.MaxSize = 65535
SCancelLoading.protocolType = 0
SCancelLoading.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCancelLoading
  ((SCancelLoading.super).Ctor)(self, client)
end

SCancelLoading.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.protocolType) then
    return false
  end
  return true
end

SCancelLoading.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCancelLoading

