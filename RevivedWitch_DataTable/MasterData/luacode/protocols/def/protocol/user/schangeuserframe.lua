-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/schangeuserframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeUserFrame = dataclass("SChangeUserFrame", require("framework.net.protocol"))
SChangeUserFrame.ProtocolType = 2227
SChangeUserFrame.MaxSize = 65535
SChangeUserFrame.frameId = 0
SChangeUserFrame.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeUserFrame
  ((SChangeUserFrame.super).Ctor)(self, client)
end

SChangeUserFrame.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.frameId) then
    return false
  end
  return true
end

SChangeUserFrame.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserFrame

