-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cactivitydramapassed.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CActivityDramaPassed = dataclass("CActivityDramaPassed", require("framework.net.protocol"))
CActivityDramaPassed.ProtocolType = 2445
CActivityDramaPassed.MaxSize = 65535
CActivityDramaPassed.dramaType = 0
CActivityDramaPassed.activity = 0
CActivityDramaPassed.battleID = 0
CActivityDramaPassed.BEFORE_BATTLE = 1
CActivityDramaPassed.AFTER_BATTLE = 2
CActivityDramaPassed.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CActivityDramaPassed
  ((CActivityDramaPassed.super).Ctor)(self, client)
end

CActivityDramaPassed.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dramaType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activity) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleID) then
    return false
  end
  return true
end

CActivityDramaPassed.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActivityDramaPassed

