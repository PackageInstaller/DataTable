-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cislandtouchaltar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CIslandTouchAltar = dataclass("CIslandTouchAltar", require("framework.net.protocol"))
CIslandTouchAltar.ProtocolType = 1997
CIslandTouchAltar.MaxSize = 65535
CIslandTouchAltar.islandID = 0
CIslandTouchAltar.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CIslandTouchAltar
  ((CIslandTouchAltar.super).Ctor)(self, client)
end

CIslandTouchAltar.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.islandID) then
    return false
  end
  return true
end

CIslandTouchAltar.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CIslandTouchAltar

