-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/sarrivetraintime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SArriveTrainTime = dataclass("SArriveTrainTime", require("framework.net.protocol"))
SArriveTrainTime.ProtocolType = 2380
SArriveTrainTime.MaxSize = 65535
SArriveTrainTime.index = 0
SArriveTrainTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SArriveTrainTime, _ENV
  ((SArriveTrainTime.super).Ctor)(self, client)
  self.train = ((require("protocols.bean.protocol.yard.train")).Create)()
end

SArriveTrainTime.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  if not (self.train):Marshal(buffer) then
    return false
  end
  return true
end

SArriveTrainTime.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.train):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SArriveTrainTime

