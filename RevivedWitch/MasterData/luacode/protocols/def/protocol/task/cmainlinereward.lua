-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/cmainlinereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CMainLineReward = dataclass("CMainLineReward", require("framework.net.protocol"))
CMainLineReward.ProtocolType = 1638
CMainLineReward.MaxSize = 65535
CMainLineReward.mainLineId = 0
CMainLineReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CMainLineReward
  ((CMainLineReward.super).Ctor)(self, client)
end

CMainLineReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.mainLineId) then
    return false
  end
  return true
end

CMainLineReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMainLineReward

