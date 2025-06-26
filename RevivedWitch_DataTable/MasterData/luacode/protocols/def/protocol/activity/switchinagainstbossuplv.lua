-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/switchinagainstbossuplv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SWitchInAgainstBossUpLv = dataclass("SWitchInAgainstBossUpLv", require("framework.net.protocol"))
SWitchInAgainstBossUpLv.ProtocolType = 2670
SWitchInAgainstBossUpLv.MaxSize = 65535
SWitchInAgainstBossUpLv.witchLv = 0
SWitchInAgainstBossUpLv.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SWitchInAgainstBossUpLv
  ((SWitchInAgainstBossUpLv.super).Ctor)(self, client)
end

SWitchInAgainstBossUpLv.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.witchLv) then
    return false
  end
  return true
end

SWitchInAgainstBossUpLv.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWitchInAgainstBossUpLv

