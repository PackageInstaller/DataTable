-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenfloorbox.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenFloorBox = dataclass("COpenFloorBox", require("framework.net.protocol"))
COpenFloorBox.ProtocolType = 2632
COpenFloorBox.MaxSize = 65535
COpenFloorBox.floorId = 0
COpenFloorBox.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenFloorBox
  ((COpenFloorBox.super).Ctor)(self, client)
end

COpenFloorBox.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.floorId) then
    return false
  end
  return true
end

COpenFloorBox.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenFloorBox

