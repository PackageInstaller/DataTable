-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/activity/mazeawardblock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local MazeAwardBlock = dataclass("MazeAwardBlock")
MazeAwardBlock.blockType = 0
MazeAwardBlock.status = 0
MazeAwardBlock.itemId = 0
MazeAwardBlock.itemNum = 0
MazeAwardBlock.TO_FETCH = 0
MazeAwardBlock.FETCHED = 1
MazeAwardBlock.Ctor = function(self)
  -- function num : 0_0
end

MazeAwardBlock.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.blockType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemNum) then
    return false
  end
  return true
end

MazeAwardBlock.Unmarshal = function(self, buffer)
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
  return ret
end

return MazeAwardBlock

