-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sgetdungeonrandomitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local item = (RandomItemManager.GetRandomItem)(protocol.key)
  if item and item:GetType() == (RandomItemManager.Type).RecoverShrine then
    local randomKey = ((NekoData.BehaviorManager).BM_Team):GetRandomRoleKeyInCurrentTeam()
    local roleID = randomKey
    ;
    ((NekoData.BehaviorManager).BM_Voice):Play(roleID, (((NekoData.BehaviorManager).BM_Voice).VoiceType).LifeHealing, nil)
  end
  do
    ;
    ((NekoData.BehaviorManager).BM_Dungeon):OnSGetDungeonRandomItem(protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

