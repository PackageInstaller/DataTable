-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cchangerougetowerautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeRougeTowerAutoExplore = dataclass("CChangeRougeTowerAutoExplore", require("framework.net.protocol"))
CChangeRougeTowerAutoExplore.ProtocolType = 2452
CChangeRougeTowerAutoExplore.MaxSize = 65535
CChangeRougeTowerAutoExplore.switchState = 0
CChangeRougeTowerAutoExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeRougeTowerAutoExplore
  ((CChangeRougeTowerAutoExplore.super).Ctor)(self, client)
end

CChangeRougeTowerAutoExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.switchState) then
    return false
  end
  return true
end

CChangeRougeTowerAutoExplore.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeRougeTowerAutoExplore

