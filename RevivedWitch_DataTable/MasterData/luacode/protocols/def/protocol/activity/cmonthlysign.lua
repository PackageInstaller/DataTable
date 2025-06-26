-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cmonthlysign.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CMonthlySign = dataclass("CMonthlySign", require("framework.net.protocol"))
CMonthlySign.ProtocolType = 2678
CMonthlySign.MaxSize = 65535
CMonthlySign.dayId = 0
CMonthlySign.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CMonthlySign
  ((CMonthlySign.super).Ctor)(self, client)
end

CMonthlySign.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dayId) then
    return false
  end
  return true
end

CMonthlySign.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMonthlySign

