-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cunlockbppuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlockBpPuzzle = dataclass("CUnlockBpPuzzle", require("framework.net.protocol"))
CUnlockBpPuzzle.ProtocolType = 2673
CUnlockBpPuzzle.MaxSize = 65535
CUnlockBpPuzzle.puzzleId = 0
CUnlockBpPuzzle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlockBpPuzzle
  ((CUnlockBpPuzzle.super).Ctor)(self, client)
end

CUnlockBpPuzzle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.puzzleId) then
    return false
  end
  return true
end

CUnlockBpPuzzle.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockBpPuzzle

