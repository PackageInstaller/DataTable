-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cunlockpuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlockPuzzle = dataclass("CUnlockPuzzle", require("framework.net.protocol"))
CUnlockPuzzle.ProtocolType = 2495
CUnlockPuzzle.MaxSize = 65535
CUnlockPuzzle.activityId = 0
CUnlockPuzzle.puzzleId = 0
CUnlockPuzzle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlockPuzzle
  ((CUnlockPuzzle.super).Ctor)(self, client)
end

CUnlockPuzzle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.puzzleId) then
    return false
  end
  return true
end

CUnlockPuzzle.Unmarshal = function(self, buffer)
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

return CUnlockPuzzle

