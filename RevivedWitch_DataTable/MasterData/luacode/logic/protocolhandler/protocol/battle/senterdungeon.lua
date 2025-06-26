-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/senterdungeon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("senterdungeon", "recevie")
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  ((NekoData.DataManager).DM_Dungeon):OnSEnterDungeon(protocol)
  ;
  ((NekoData.DataManager).DM_SEnterDungeon):OnSEnterDungeon(protocol)
  ;
  ((NekoData.DataManager).DM_Team):OnSEnterDungeon(protocol)
  ;
  ((NekoData.DataManager).DM_MiniMap):OnSEnterDungeon(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_EnterDungeon, DM_Dungeon, nil)
  ;
  (DialogManager.DestroySingletonDialog)("maindialog")
  LogInfoFormat("senterdungeon", "--------- id = %s -----------", protocol.id)
  GlobalGameFSM:SetNumber("sceneLoadingId", protocol.id)
  if (protocol.curBattleInfo).battleid > 0 then
    ((NekoData.DataManager).DM_SBattleStart):OnSBattleStart(protocol.curBattleInfo)
    GlobalGameFSM:SetNumber("battleId", (protocol.curBattleInfo).battleid)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

