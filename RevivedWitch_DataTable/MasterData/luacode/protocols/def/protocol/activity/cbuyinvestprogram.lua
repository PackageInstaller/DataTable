-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cbuyinvestprogram.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyInvestProgram = dataclass("CBuyInvestProgram", require("framework.net.protocol"))
CBuyInvestProgram.ProtocolType = 2660
CBuyInvestProgram.MaxSize = 65535
CBuyInvestProgram.channelId = 0
CBuyInvestProgram.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyInvestProgram
  ((CBuyInvestProgram.super).Ctor)(self, client)
end

CBuyInvestProgram.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.channelId) then
    return false
  end
  return true
end

CBuyInvestProgram.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyInvestProgram

