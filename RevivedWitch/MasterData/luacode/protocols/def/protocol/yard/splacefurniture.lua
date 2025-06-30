-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/splacefurniture.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPlaceFurniture = dataclass("SPlaceFurniture", require("framework.net.protocol"))
SPlaceFurniture.ProtocolType = 2360
SPlaceFurniture.MaxSize = 65535
SPlaceFurniture.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPlaceFurniture, _ENV
  ((SPlaceFurniture.super).Ctor)(self, client)
  self.floor = ((require("protocols.bean.protocol.yard.witchfloor")).Create)()
end

SPlaceFurniture.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.floor):Marshal(buffer) then
    return false
  end
  return true
end

SPlaceFurniture.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.floor):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SPlaceFurniture

