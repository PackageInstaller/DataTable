-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshlampstand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshLampStand = dataclass("SRefreshLampStand", require("framework.net.protocol"))
SRefreshLampStand.ProtocolType = 2336
SRefreshLampStand.MaxSize = 65535
SRefreshLampStand.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshLampStand, _ENV
  ((SRefreshLampStand.super).Ctor)(self, client)
  self.lampStand = ((require("protocols.bean.protocol.yard.lampstand")).Create)()
end

SRefreshLampStand.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.lampStand):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshLampStand.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.lampStand):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshLampStand

