-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/schangelineupname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeLineupName = dataclass("SChangeLineupName", require("framework.net.protocol"))
SChangeLineupName.ProtocolType = 1046
SChangeLineupName.MaxSize = 65535
SChangeLineupName.lineupId = 0
SChangeLineupName.name = ""
SChangeLineupName.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeLineupName
  ((SChangeLineupName.super).Ctor)(self, client)
end

SChangeLineupName.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.name) then
    return false
  end
  return true
end

SChangeLineupName.Unmarshal = function(self, buffer)
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

return SChangeLineupName

