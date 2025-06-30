-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cwarp2newpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CWarp2NewPoint = dataclass("CWarp2NewPoint", require("framework.net.protocol"))
CWarp2NewPoint.ProtocolType = 2417
CWarp2NewPoint.MaxSize = 65535
CWarp2NewPoint.toNextFloor = 0
CWarp2NewPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CWarp2NewPoint
  ((CWarp2NewPoint.super).Ctor)(self, client)
end

CWarp2NewPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.toNextFloor) then
    return false
  end
  return true
end

CWarp2NewPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CWarp2NewPoint

