-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/centerjumppoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CEnterJumpPoint = dataclass("CEnterJumpPoint", require("framework.net.protocol"))
CEnterJumpPoint.ProtocolType = 1914
CEnterJumpPoint.MaxSize = 65535
CEnterJumpPoint.id = 0
CEnterJumpPoint.outpoint = 0
CEnterJumpPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CEnterJumpPoint
  ((CEnterJumpPoint.super).Ctor)(self, client)
end

CEnterJumpPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.outpoint) then
    return false
  end
  return true
end

CEnterJumpPoint.Unmarshal = function(self, buffer)
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

return CEnterJumpPoint

