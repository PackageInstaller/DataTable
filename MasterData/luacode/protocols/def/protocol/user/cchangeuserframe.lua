-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/cchangeuserframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeUserFrame = dataclass("CChangeUserFrame", require("framework.net.protocol"))
CChangeUserFrame.ProtocolType = 2226
CChangeUserFrame.MaxSize = 65535
CChangeUserFrame.frameId = 0
CChangeUserFrame.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeUserFrame
  ((CChangeUserFrame.super).Ctor)(self, client)
end

CChangeUserFrame.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.frameId) then
    return false
  end
  return true
end

CChangeUserFrame.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserFrame

