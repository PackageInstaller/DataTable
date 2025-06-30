-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/supdateactivitybattlelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local TypeEnum = {
[(DataCommon.Activities).StarMirage] = {dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.StarMirageManagerID), levelTable = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel"), localTips = (DataCommon.LocalTips).StarMirageUnlock, bannerId = 1}
, 
[(DataCommon.Activities).Anniversary] = {dm = (NekoData.DataManager).DM_Anniversary, levelTable = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel"), localTips = (DataCommon.LocalTips).Anniversary, bannerId = 125}
, 
[(DataCommon.Activities).StarMirageCopy] = {dm = (NekoData.DataManager).DM_StarMirageCopy, levelTable = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel"), localTips = (DataCommon.LocalTips).StarMirageCopy, bannerId = 157}
}
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, TypeEnum, LevelStateEnum
  LogInfoFormat("SUpdateActivityBattleList", "--- activityId = %s ---", protocol.activityId)
  local type = TypeEnum[protocol.activityId]
  if not type then
    LogError("activityId error!")
    return 
  end
  ;
  (type.dm):OnSUpdateActivityBattleList(protocol)
  for i,v in ipairs(protocol.battleNodes) do
    if v.status == LevelStateEnum.CLEAR then
      local record = (type.levelTable):GetRecorder(v.id)
      if record.afterbattleplot == -1 then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.AFTER_BATTLE
        protocol.activity = protocol.activityId
        protocol.battleID = v.id
        protocol:Send()
      end
    end
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshLevelList, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

