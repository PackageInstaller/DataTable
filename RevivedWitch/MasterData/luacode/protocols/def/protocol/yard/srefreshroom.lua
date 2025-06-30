-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshroom.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshRoom = dataclass("SRefreshRoom", require("framework.net.protocol"))
SRefreshRoom.ProtocolType = 2358
SRefreshRoom.MaxSize = 65535
SRefreshRoom.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshRoom, _ENV
  ((SRefreshRoom.super).Ctor)(self, client)
  self.room = ((require("protocols.bean.protocol.yard.witchroom")).Create)()
end

SRefreshRoom.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.room):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshRoom.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.room):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshRoom

