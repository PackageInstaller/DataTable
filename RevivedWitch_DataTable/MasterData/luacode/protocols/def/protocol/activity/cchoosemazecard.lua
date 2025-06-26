-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cchoosemazecard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChooseMazeCard = dataclass("CChooseMazeCard", require("framework.net.protocol"))
CChooseMazeCard.ProtocolType = 2688
CChooseMazeCard.MaxSize = 65535
CChooseMazeCard.card = 0
CChooseMazeCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChooseMazeCard
  ((CChooseMazeCard.super).Ctor)(self, client)
end

CChooseMazeCard.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.card) then
    return false
  end
  return true
end

CChooseMazeCard.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChooseMazeCard

