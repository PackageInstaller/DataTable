-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshtrainroom.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshTrainRoom = dataclass("SRefreshTrainRoom", require("framework.net.protocol"))
SRefreshTrainRoom.ProtocolType = 2378
SRefreshTrainRoom.MaxSize = 65535
SRefreshTrainRoom.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshTrainRoom, _ENV
  ((SRefreshTrainRoom.super).Ctor)(self, client)
  self.room = ((require("protocols.bean.protocol.yard.trainroom")).Create)()
end

SRefreshTrainRoom.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.room):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshTrainRoom.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.room):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshTrainRoom

