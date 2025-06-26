-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/npc/cvisitnpc.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CVisitNpc = dataclass("CVisitNpc", require("framework.net.protocol"))
CVisitNpc.ProtocolType = 2001
CVisitNpc.MaxSize = 65535
CVisitNpc.npcId = 0
CVisitNpc.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CVisitNpc
  ((CVisitNpc.super).Ctor)(self, client)
end

CVisitNpc.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.npcId) then
    return false
  end
  return true
end

CVisitNpc.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CVisitNpc

