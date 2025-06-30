-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/srefreshhandbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshHandbook = dataclass("SRefreshHandbook", require("framework.net.protocol"))
SRefreshHandbook.ProtocolType = 2260
SRefreshHandbook.MaxSize = 65535
SRefreshHandbook.id = 0
SRefreshHandbook.bookType = 0
SRefreshHandbook.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshHandbook
  ((SRefreshHandbook.super).Ctor)(self, client)
end

SRefreshHandbook.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bookType) then
    return false
  end
  return true
end

SRefreshHandbook.Unmarshal = function(self, buffer)
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

return SRefreshHandbook

