-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/centernextfloor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CEnterNextFloor = dataclass("CEnterNextFloor", require("framework.net.protocol"))
CEnterNextFloor.ProtocolType = 2624
CEnterNextFloor.MaxSize = 65535
CEnterNextFloor.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CEnterNextFloor
  ((CEnterNextFloor.super).Ctor)(self, client)
end

CEnterNextFloor.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CEnterNextFloor.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CEnterNextFloor

