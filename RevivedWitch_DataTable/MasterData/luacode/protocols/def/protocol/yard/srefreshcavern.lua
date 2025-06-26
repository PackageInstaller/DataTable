-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshcavern.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshCavern = dataclass("SRefreshCavern", require("framework.net.protocol"))
SRefreshCavern.ProtocolType = 2321
SRefreshCavern.MaxSize = 65535
SRefreshCavern.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshCavern, _ENV
  ((SRefreshCavern.super).Ctor)(self, client)
  self.cavern = ((require("protocols.bean.protocol.yard.cavern")).Create)()
end

SRefreshCavern.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.cavern):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshCavern.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.cavern):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshCavern

