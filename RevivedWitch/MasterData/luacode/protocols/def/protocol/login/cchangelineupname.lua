-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cchangelineupname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeLineupName = dataclass("CChangeLineupName", require("framework.net.protocol"))
CChangeLineupName.ProtocolType = 1045
CChangeLineupName.MaxSize = 65535
CChangeLineupName.lineupId = 0
CChangeLineupName.name = ""
CChangeLineupName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeLineupName
  ((CChangeLineupName.super).Ctor)(self, client)
end

CChangeLineupName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

CChangeLineupName.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeLineupName

