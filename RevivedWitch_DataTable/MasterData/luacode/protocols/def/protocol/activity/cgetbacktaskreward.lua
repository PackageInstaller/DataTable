-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetbacktaskreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetBackTaskReward = dataclass("CGetBackTaskReward", require("framework.net.protocol"))
CGetBackTaskReward.ProtocolType = 2558
CGetBackTaskReward.MaxSize = 65535
CGetBackTaskReward.goodId = 0
CGetBackTaskReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetBackTaskReward
  ((CGetBackTaskReward.super).Ctor)(self, client)
end

CGetBackTaskReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  return true
end

CGetBackTaskReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetBackTaskReward

