-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/schangeroomname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeRoomName = dataclass("SChangeRoomName", require("framework.net.protocol"))
SChangeRoomName.ProtocolType = 2357
SChangeRoomName.MaxSize = 65535
SChangeRoomName.name = ""
SChangeRoomName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeRoomName
  ((SChangeRoomName.super).Ctor)(self, client)
end

SChangeRoomName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

SChangeRoomName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeRoomName

