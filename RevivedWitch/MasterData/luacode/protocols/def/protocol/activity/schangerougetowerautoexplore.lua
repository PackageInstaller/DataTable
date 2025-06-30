-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schangerougetowerautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeRougeTowerAutoExplore = dataclass("SChangeRougeTowerAutoExplore", require("framework.net.protocol"))
SChangeRougeTowerAutoExplore.ProtocolType = 2453
SChangeRougeTowerAutoExplore.MaxSize = 65535
SChangeRougeTowerAutoExplore.result = 0
SChangeRougeTowerAutoExplore.switchState = 0
SChangeRougeTowerAutoExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeRougeTowerAutoExplore
  ((SChangeRougeTowerAutoExplore.super).Ctor)(self, client)
end

SChangeRougeTowerAutoExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.switchState) then
    return false
  end
  return true
end

SChangeRougeTowerAutoExplore.Unmarshal = function(self, buffer)
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

return SChangeRougeTowerAutoExplore

