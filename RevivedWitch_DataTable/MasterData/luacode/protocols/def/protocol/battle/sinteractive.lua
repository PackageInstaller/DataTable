-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sinteractive.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SInterActive = dataclass("SInterActive", require("framework.net.protocol"))
SInterActive.ProtocolType = 1969
SInterActive.MaxSize = 65535
SInterActive.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SInterActive, _ENV
  ((SInterActive.super).Ctor)(self, client)
  self.obj = ((require("protocols.bean.protocol.battle.interactiveobj")).Create)()
end

SInterActive.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.obj):Marshal(buffer) then
    return false
  end
  return true
end

SInterActive.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.obj):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SInterActive

