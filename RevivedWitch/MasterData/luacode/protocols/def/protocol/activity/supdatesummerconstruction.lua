-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/supdatesummerconstruction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateSummerConstruction = dataclass("SUpdateSummerConstruction", require("framework.net.protocol"))
SUpdateSummerConstruction.ProtocolType = 2472
SUpdateSummerConstruction.MaxSize = 65535
SUpdateSummerConstruction.result = 0
SUpdateSummerConstruction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateSummerConstruction, _ENV
  ((SUpdateSummerConstruction.super).Ctor)(self, client)
  self.construction = ((require("protocols.bean.protocol.activity.summerconstruction")).Create)()
end

SUpdateSummerConstruction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (self.construction):Marshal(buffer) then
    return false
  end
  return true
end

SUpdateSummerConstruction.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.construction):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUpdateSummerConstruction

