-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/supdatesidequestdungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateSideQuestDungeon = dataclass("SUpdateSideQuestDungeon", require("framework.net.protocol"))
SUpdateSideQuestDungeon.ProtocolType = 2427
SUpdateSideQuestDungeon.MaxSize = 65536
SUpdateSideQuestDungeon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateSideQuestDungeon, _ENV
  ((SUpdateSideQuestDungeon.super).Ctor)(self, client)
  self.dungeons = ((require("protocols.bean.protocol.activity.sidequestdungeoninfo")).Create)()
end

SUpdateSideQuestDungeon.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.dungeons):Marshal(buffer) then
    return false
  end
  return true
end

SUpdateSideQuestDungeon.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.dungeons):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUpdateSideQuestDungeon

