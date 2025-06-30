-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sfantasyconflictchangeteam.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFantasyConflictChangeTeam = dataclass("SFantasyConflictChangeTeam", require("framework.net.protocol"))
SFantasyConflictChangeTeam.ProtocolType = 4158
SFantasyConflictChangeTeam.MaxSize = 65535
SFantasyConflictChangeTeam.teamType = 0
SFantasyConflictChangeTeam.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFantasyConflictChangeTeam
  ((SFantasyConflictChangeTeam.super).Ctor)(self, client)
  self.team = {}
end

SFantasyConflictChangeTeam.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.teamType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.team)) then
    return false
  end
  for key,value in pairs(self.team) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC26) then
      return false
    end
  end
  return true
end

SFantasyConflictChangeTeam.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC37: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.team)[key] = value
  end
  return ret
end

return SFantasyConflictChangeTeam

