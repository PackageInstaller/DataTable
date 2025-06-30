-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cstarttrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStartTrain = dataclass("CStartTrain", require("framework.net.protocol"))
CStartTrain.ProtocolType = 2372
CStartTrain.MaxSize = 65535
CStartTrain.index = 0
CStartTrain.roleId = 0
CStartTrain.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStartTrain
  ((CStartTrain.super).Ctor)(self, client)
end

CStartTrain.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.index) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CStartTrain.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartTrain

