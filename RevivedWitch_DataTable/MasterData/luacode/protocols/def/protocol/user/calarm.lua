-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/calarm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAlarm = dataclass("CAlarm", require("framework.net.protocol"))
CAlarm.ProtocolType = 2273
CAlarm.MaxSize = 65535
CAlarm.context = ""
CAlarm.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAlarm
  ((CAlarm.super).Ctor)(self, client)
end

CAlarm.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.context) then
    return false
  end
  return true
end

CAlarm.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAlarm

