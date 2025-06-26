-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetloverreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetLoverReward = dataclass("CGetLoverReward", require("framework.net.protocol"))
CGetLoverReward.ProtocolType = 2596
CGetLoverReward.MaxSize = 65535
CGetLoverReward.boxId = 0
CGetLoverReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetLoverReward
  ((CGetLoverReward.super).Ctor)(self, client)
end

CGetLoverReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.boxId) then
    return false
  end
  return true
end

CGetLoverReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetLoverReward

