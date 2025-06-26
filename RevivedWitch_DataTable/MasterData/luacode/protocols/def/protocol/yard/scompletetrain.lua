-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/scompletetrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCompleteTrain = dataclass("SCompleteTrain", require("framework.net.protocol"))
SCompleteTrain.ProtocolType = 2375
SCompleteTrain.MaxSize = 65535
SCompleteTrain.index = 0
SCompleteTrain.resultType = 0
SCompleteTrain.result = ""
SCompleteTrain.ADD_EXP = 1
SCompleteTrain.ADD_LEVEL = 2
SCompleteTrain.ADD_MONEY = 3
SCompleteTrain.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCompleteTrain, _ENV
  ((SCompleteTrain.super).Ctor)(self, client)
  self.train = ((require("protocols.bean.protocol.yard.train")).Create)()
end

SCompleteTrain.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.train):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.resultType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.result) then
    return false
  end
  return true
end

SCompleteTrain.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.train):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCompleteTrain

