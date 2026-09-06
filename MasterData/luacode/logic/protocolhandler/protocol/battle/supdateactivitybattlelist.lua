local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
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
  LogInfoFormat("SUpdateActivityBattleList", "--- activityId = %s ---", protocol.activityId)
  local type = TypeEnum[protocol.activityId]
  if not type then
    LogError("activityId error!")
    return
  end
  type.dm:OnSUpdateActivityBattleList(protocol)
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
  LuaNotificationCenter.PostNotification(Common.n_RefreshLevelList, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
