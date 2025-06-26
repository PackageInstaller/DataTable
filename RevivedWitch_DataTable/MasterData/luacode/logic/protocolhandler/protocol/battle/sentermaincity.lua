-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sentermaincity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_OnSEnterMainCity, nil, protocol)
  local doNext = function()
    -- function num : 0_0_0 , upvalues : _ENV, protocol
    ((EffectFactory.CreateThawEffect)()):Run()
    ;
    (DialogManager.DestroySingletonDialog)("login.eventreconnectdialog")
    ;
    ((NekoData.DataManager).DM_Game):OnSEnterMainCity(protocol)
    ;
    ((NekoData.DataManager).DM_SEnterDungeon):OnSEnterMainCity()
    ;
    ((NekoData.DataManager).DM_SEnterMainCity):OnSEnterMainCity(protocol)
    ;
    ((NekoData.DataManager).DM_Dungeon):OnSEnterMainCity()
    ;
    ((NekoData.DataManager).DM_Friends):OnSRefreshSupportRoleList({
rolesFromFriends = {}
, 
rolesFromStrangers = {}
})
    ;
    ((NekoData.BehaviorManager).BM_Dungeon):ClearDungeonConquestList()
    GlobalGameFSM:SetNumber("sceneLoadingId", 30001)
    if (protocol.curBattleInfo).battleid > 0 then
      ((NekoData.DataManager).DM_SBattleStart):OnSBattleStart(protocol.curBattleInfo)
      GlobalGameFSM:SetNumber("battleId", (protocol.curBattleInfo).battleid)
    end
  end

  local dungeonhudDialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "Dungeon" and dungeonhudDialog and dungeonhudDialog:GetLeaveToShowFinishDialog() then
    dungeonhudDialog:ShowFinishExploreDialog({money = protocol.money, doNext = doNext})
  else
    doNext()
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

