-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cfetchtaskfinishaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchTaskFinishAward = dataclass("CFetchTaskFinishAward", require("framework.net.protocol"))
CFetchTaskFinishAward.ProtocolType = 2683
CFetchTaskFinishAward.MaxSize = 65535
CFetchTaskFinishAward.id = 0
CFetchTaskFinishAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchTaskFinishAward
  ((CFetchTaskFinishAward.super).Ctor)(self, client)
end

CFetchTaskFinishAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CFetchTaskFinishAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchTaskFinishAward

