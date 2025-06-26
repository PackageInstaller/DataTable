-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/activity/updateconstruction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local updateConstruction = dataclass("updateConstruction")
updateConstruction.construction = 0
updateConstruction.canlvup = 0
updateConstruction.unlockEvent = 0
updateConstruction.Ctor = function(self)
  -- function num : 0_0
end

updateConstruction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.construction) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.canlvup) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlockEvent) then
    return false
  end
  return true
end

updateConstruction.Unmarshal = function(self, buffer)
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

return updateConstruction

