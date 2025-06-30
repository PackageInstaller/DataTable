-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/importbattlebeans.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ImportBattleBeans = dataclass("ImportBattleBeans", require("framework.net.protocol"))
ImportBattleBeans.ProtocolType = 1905
ImportBattleBeans.MaxSize = 65535
ImportBattleBeans.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : ImportBattleBeans, _ENV
  ((ImportBattleBeans.super).Ctor)(self, client)
  self.dungeonType = ((require("protocols.bean.protocol.battle.dungeontype")).Create)()
end

ImportBattleBeans.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.dungeonType):Marshal(buffer) then
    return false
  end
  return true
end

ImportBattleBeans.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.dungeonType):Unmarshal(buffer) then
    return false
  end
  return ret
end

return ImportBattleBeans

