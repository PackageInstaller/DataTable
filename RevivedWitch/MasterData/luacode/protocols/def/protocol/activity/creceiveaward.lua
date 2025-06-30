-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceiveaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveAward = dataclass("CReceiveAward", require("framework.net.protocol"))
CReceiveAward.ProtocolType = 2407
CReceiveAward.MaxSize = 65535
CReceiveAward.actId = 0
CReceiveAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveAward
  ((CReceiveAward.super).Ctor)(self, client)
end

CReceiveAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.actId) then
    return false
  end
  return true
end

CReceiveAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveAward

