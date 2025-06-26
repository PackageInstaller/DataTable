-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sdestroypoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDestroyPoint = dataclass("SDestroyPoint", require("framework.net.protocol"))
SDestroyPoint.ProtocolType = 1937
SDestroyPoint.MaxSize = 65535
SDestroyPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDestroyPoint, _ENV
  ((SDestroyPoint.super).Ctor)(self, client)
  self.specialPoint = ((require("protocols.bean.protocol.battle.point")).Create)()
end

SDestroyPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.specialPoint):Marshal(buffer) then
    return false
  end
  return true
end

SDestroyPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.specialPoint):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SDestroyPoint

