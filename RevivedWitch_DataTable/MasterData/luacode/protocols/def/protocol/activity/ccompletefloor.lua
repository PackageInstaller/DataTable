-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ccompletefloor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCompleteFloor = dataclass("CCompleteFloor", require("framework.net.protocol"))
CCompleteFloor.ProtocolType = 2626
CCompleteFloor.MaxSize = 65535
CCompleteFloor.floorId = 0
CCompleteFloor.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCompleteFloor
  ((CCompleteFloor.super).Ctor)(self, client)
end

CCompleteFloor.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.floorId) then
    return false
  end
  return true
end

CCompleteFloor.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteFloor

