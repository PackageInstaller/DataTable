-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cchangroomname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangRoomName = dataclass("CChangRoomName", require("framework.net.protocol"))
CChangRoomName.ProtocolType = 2356
CChangRoomName.MaxSize = 65535
CChangRoomName.name = ""
CChangRoomName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangRoomName
  ((CChangRoomName.super).Ctor)(self, client)
end

CChangRoomName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

CChangRoomName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangRoomName

