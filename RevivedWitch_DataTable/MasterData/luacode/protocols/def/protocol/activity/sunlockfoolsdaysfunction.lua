-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sunlockfoolsdaysfunction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUnlockFoolsDaysFunction = dataclass("SUnlockFoolsDaysFunction", require("framework.net.protocol"))
SUnlockFoolsDaysFunction.ProtocolType = 2639
SUnlockFoolsDaysFunction.MaxSize = 65535
SUnlockFoolsDaysFunction.functionId = 0
SUnlockFoolsDaysFunction.COPY_BATTLE = 1
SUnlockFoolsDaysFunction.RED_CLOWN = 2
SUnlockFoolsDaysFunction.BLUE_CLOWN = 3
SUnlockFoolsDaysFunction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUnlockFoolsDaysFunction
  ((SUnlockFoolsDaysFunction.super).Ctor)(self, client)
end

SUnlockFoolsDaysFunction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.functionId) then
    return false
  end
  return true
end

SUnlockFoolsDaysFunction.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockFoolsDaysFunction

