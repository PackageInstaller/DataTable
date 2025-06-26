-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreturnagainstbossinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReturnAgainstBossInfo = dataclass("SReturnAgainstBossInfo", require("framework.net.protocol"))
SReturnAgainstBossInfo.ProtocolType = 2668
SReturnAgainstBossInfo.MaxSize = 65535
SReturnAgainstBossInfo.bossId = 0
SReturnAgainstBossInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReturnAgainstBossInfo, _ENV
  ((SReturnAgainstBossInfo.super).Ctor)(self, client)
  self.againstBossInfo = ((require("protocols.bean.protocol.activity.againstbossinfo")).Create)()
end

SReturnAgainstBossInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.againstBossInfo):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossId) then
    return false
  end
  return true
end

SReturnAgainstBossInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.againstBossInfo):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReturnAgainstBossInfo

