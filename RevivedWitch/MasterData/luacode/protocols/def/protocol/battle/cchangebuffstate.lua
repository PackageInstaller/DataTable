-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cchangebuffstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeBuffState = dataclass("CChangeBuffState", require("framework.net.protocol"))
CChangeBuffState.ProtocolType = 4105
CChangeBuffState.MaxSize = 65535
CChangeBuffState.id = 0
CChangeBuffState.status = 0
CChangeBuffState.GETBUFF = 1
CChangeBuffState.LOSEBUFF = 2
CChangeBuffState.PRODUCEBUFF = 3
CChangeBuffState.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeBuffState
  ((CChangeBuffState.super).Ctor)(self, client)
end

CChangeBuffState.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  return true
end

CChangeBuffState.Unmarshal = function(self, buffer)
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

return CChangeBuffState

