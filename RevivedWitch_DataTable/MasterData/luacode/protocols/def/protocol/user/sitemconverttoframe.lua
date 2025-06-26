-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/sitemconverttoframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SItemConvertToFrame = dataclass("SItemConvertToFrame", require("framework.net.protocol"))
SItemConvertToFrame.ProtocolType = 2263
SItemConvertToFrame.MaxSize = 65535
SItemConvertToFrame.frameId = 0
SItemConvertToFrame.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SItemConvertToFrame
  ((SItemConvertToFrame.super).Ctor)(self, client)
end

SItemConvertToFrame.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.frameId) then
    return false
  end
  return true
end

SItemConvertToFrame.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SItemConvertToFrame

