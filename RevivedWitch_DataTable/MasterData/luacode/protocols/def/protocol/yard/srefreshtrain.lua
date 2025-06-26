-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshtrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshTrain = dataclass("SRefreshTrain", require("framework.net.protocol"))
SRefreshTrain.ProtocolType = 2381
SRefreshTrain.MaxSize = 65535
SRefreshTrain.index = 0
SRefreshTrain.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshTrain, _ENV
  ((SRefreshTrain.super).Ctor)(self, client)
  self.train = ((require("protocols.bean.protocol.yard.train")).Create)()
end

SRefreshTrain.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  if not (self.train):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshTrain.Unmarshal = function(self, buffer)
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

return SRefreshTrain

