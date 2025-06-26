-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ctowermove.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CTowerMove = dataclass("CTowerMove", require("framework.net.protocol"))
CTowerMove.ProtocolType = 1974
CTowerMove.MaxSize = 65535
CTowerMove.nextIsland = 0
CTowerMove.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CTowerMove
  ((CTowerMove.super).Ctor)(self, client)
end

CTowerMove.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.nextIsland) then
    return false
  end
  return true
end

CTowerMove.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CTowerMove

