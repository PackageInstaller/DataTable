-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/yard/alchemy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Alchemy = dataclass("Alchemy")
Alchemy.id = 0
Alchemy.buildLevel = 0
Alchemy.alchemyLevel = 0
Alchemy.alchemyStage = 0
Alchemy.alchemyExperience = 0
Alchemy.roleId = 0
Alchemy.Ctor = function(self)
  -- function num : 0_0
end

Alchemy.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.buildLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.alchemyLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.alchemyStage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.alchemyExperience) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

Alchemy.Unmarshal = function(self, buffer)
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

return Alchemy

