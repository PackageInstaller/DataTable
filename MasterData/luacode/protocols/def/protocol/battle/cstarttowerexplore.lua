-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cstarttowerexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStartTowerExplore = dataclass("CStartTowerExplore", require("framework.net.protocol"))
CStartTowerExplore.ProtocolType = 1981
CStartTowerExplore.MaxSize = 65535
CStartTowerExplore.tower = 0
CStartTowerExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStartTowerExplore
  ((CStartTowerExplore.super).Ctor)(self, client)
end

CStartTowerExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.tower) then
    return false
  end
  return true
end

CStartTowerExplore.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartTowerExplore

