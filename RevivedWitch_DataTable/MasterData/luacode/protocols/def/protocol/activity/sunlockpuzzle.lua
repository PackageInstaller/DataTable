-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sunlockpuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUnlockPuzzle = dataclass("SUnlockPuzzle", require("framework.net.protocol"))
SUnlockPuzzle.ProtocolType = 2496
SUnlockPuzzle.MaxSize = 65535
SUnlockPuzzle.activityId = 0
SUnlockPuzzle.puzzleId = 0
SUnlockPuzzle.puzzleNum = 0
SUnlockPuzzle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUnlockPuzzle
  ((SUnlockPuzzle.super).Ctor)(self, client)
end

SUnlockPuzzle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.puzzleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.puzzleNum) then
    return false
  end
  return true
end

SUnlockPuzzle.Unmarshal = function(self, buffer)
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

return SUnlockPuzzle

