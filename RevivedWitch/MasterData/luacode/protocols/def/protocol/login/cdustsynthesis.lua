-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cdustsynthesis.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDustSynthesis = dataclass("CDustSynthesis", require("framework.net.protocol"))
CDustSynthesis.ProtocolType = 1099
CDustSynthesis.MaxSize = 65535
CDustSynthesis.dustId = 0
CDustSynthesis.num = 0
CDustSynthesis.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDustSynthesis
  ((CDustSynthesis.super).Ctor)(self, client)
end

CDustSynthesis.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dustId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  return true
end

CDustSynthesis.Unmarshal = function(self, buffer)
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

return CDustSynthesis

