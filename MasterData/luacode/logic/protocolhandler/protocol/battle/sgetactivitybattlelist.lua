local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local TypeEnum = {
  [DataCommon.Activities.StarMirage] = {
    dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.StarMirageManagerID),
    levelTable = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel"),
    localTips = DataCommon.LocalTips.StarMirageUnlock,
    bannerId = 1
  },
  [DataCommon.Activities.Anniversary] = {
    dm = NekoData.DataManager.DM_Anniversary,
    levelTable = BeanManager.GetTableByName("dungeonselect.canniversarylevel"),
    localTips = DataCommon.LocalTips.Anniversary,
    bannerId = 125
  },
  [DataCommon.Activities.StarMirageCopy] = {
    dm = NekoData.DataManager.DM_StarMirageCopy,
    levelTable = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel"),
    localTips = DataCommon.LocalTips.StarMirageCopy,
    bannerId = 157
  }
}

local function p1(protocol)
  LogInfoFormat("SGetActivityBattleList", "--- activityId = %s, time2NextPeriod = %s ---", protocol.activityId, protocol.time2NextPeriod)
  local type = TypeEnum[protocol.activityId]
  if not type then
    LogError("activityId error!")
    return
  elseif type == DataCommon.Activities.Anniversary then
    local protocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
    local activityIDForTask = protocol.ANNIVERSARY
    if protocol then
      protocol.activityID = activityIDForTask
      protocol:Send()
    end
  end
  type.dm:OnSGetActivityBattleList(protocol)
  for i, v in ipairs(protocol.battleNodes) do
    if v.status == LevelStateEnum.CLEAR then
      local record = type.levelTable:GetRecorder(v.id)
      if record.afterbattleplot == -1 then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.AFTER_BATTLE
        protocol.activity = protocol.activityId
        protocol.battleID = v.id
        protocol:Send()
      end
    end
  end
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(type.bannerId) then
    if NekoData.BehaviorManager.BM_Game:GetLocalTipsState(type.localTips) == type.localTips.Default then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(type.localTips)
    end
  else
    NekoData.BehaviorManager.BM_Game:ClearLocalTipsState(type.localTips)
  end
  if NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.AnniversaryOpenType) == DataCommon.Anniversary.Type.Hard and NekoData.BehaviorManager.BM_Anniversary:IsUnlockFunctionById(DataCommon.Anniversary.Function.Hard) ~= 1 then
    NekoData.BehaviorManager.BM_Game:SetLocalCache(DataCommon.LocalCache.AnniversaryOpenType, DataCommon.LocalCache.AnniversaryOpenType.Default)
  end
  if NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.StarMirageCopyOpenType) == DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Type.Hard and NekoData.BehaviorManager.BM_Anniversary:IsUnlockFunctionById(DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Function.Hard) ~= 1 then
    NekoData.BehaviorManager.BM_Game:SetLocalCache(DataCommon.LocalCache.StarMirageCopyOpenType, DataCommon.LocalCache.StarMirageCopyOpenType.Default)
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivity, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
