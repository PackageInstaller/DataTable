-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copenreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenReward = dataclass("COpenReward", require("framework.net.protocol"))
COpenReward.ProtocolType = 4115
COpenReward.MaxSize = 65535
COpenReward.process = 0
COpenReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenReward
  ((COpenReward.super).Ctor)(self, client)
end

COpenReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.process) then
    return false
  end
  return true
end

COpenReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenReward

