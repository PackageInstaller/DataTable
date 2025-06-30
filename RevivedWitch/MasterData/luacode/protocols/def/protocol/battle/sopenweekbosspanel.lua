-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sopenweekbosspanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenWeekBossPanel = dataclass("SOpenWeekBossPanel", require("framework.net.protocol"))
SOpenWeekBossPanel.ProtocolType = 4141
SOpenWeekBossPanel.MaxSize = 65535
SOpenWeekBossPanel.rankId = 0
SOpenWeekBossPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenWeekBossPanel, _ENV
  ((SOpenWeekBossPanel.super).Ctor)(self, client)
  self.bosses = ((require("protocols.bean.protocol.battle.bossbean")).Create)()
end

SOpenWeekBossPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rankId) then
    return false
  end
  if not (self.bosses):Marshal(buffer) then
    return false
  end
  return true
end

SOpenWeekBossPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.bosses):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SOpenWeekBossPanel

