-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/carrivetraintime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CArriveTrainTime = dataclass("CArriveTrainTime", require("framework.net.protocol"))
CArriveTrainTime.ProtocolType = 2379
CArriveTrainTime.MaxSize = 65535
CArriveTrainTime.index = 0
CArriveTrainTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CArriveTrainTime
  ((CArriveTrainTime.super).Ctor)(self, client)
end

CArriveTrainTime.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  return true
end

CArriveTrainTime.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CArriveTrainTime

