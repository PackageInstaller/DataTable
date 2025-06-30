-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/slighttowerpanelredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLightTowerPanelRedpoint = dataclass("SLightTowerPanelRedpoint", require("framework.net.protocol"))
SLightTowerPanelRedpoint.ProtocolType = 2000
SLightTowerPanelRedpoint.MaxSize = 65535
SLightTowerPanelRedpoint.light = 0
SLightTowerPanelRedpoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLightTowerPanelRedpoint
  ((SLightTowerPanelRedpoint.super).Ctor)(self, client)
end

SLightTowerPanelRedpoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.light) then
    return false
  end
  return true
end

SLightTowerPanelRedpoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLightTowerPanelRedpoint

