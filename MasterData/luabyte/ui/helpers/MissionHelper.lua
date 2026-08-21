local MissionHelper = {}
local bloodPaths = {
    [0] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_7",
    [1] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_6",
    [2] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_5",
    [3] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_4",
    [4] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_3",
    [5] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_2",
    [6] = "UI/SpritePics/battle/bosshp/ui_battle_boss_hp_1",
}

function MissionHelper.SetBossBloodBar(img, idx)
    local imgPath = bloodPaths[idx]
    if string.isNullOrEmpty(imgPath) then return end
    img:SetPic(imgPath)
end

-- 获取系统推荐等级
function MissionHelper.GetMissionSystemLV(mission)
    local lvSum, heroLvs = 0, mission.adLevel
    local len = heroLvs and heroLvs.Length or 0
    for i = 0, len - 1, 1 do lvSum = lvSum + heroLvs[i] end
    return (len > 0) and math.floor(lvSum / len) or 0
end

-- 获取当前我英雄的平均等级
function MissionHelper.GetMissionHeroLV()
    local lvSum, len = 0, 0
    for _, id in ipairs(TeamConfMgr:GetInstance():GetDefaultTeamHeros()) do
        local hd = IHeroDataMgr:GetMyHeroDataById(id)
        lvSum = lvSum + (hd and hd:GetLevel() or 0)
        len = len + 1
    end
    return (len > 0) and math.floor(lvSum / len) or 0
end

-- 是否是4星关卡
function MissionHelper.Is4StarMission(mission)
    local mType = mission.Chapter.type
    local EType = ChapterConst.EChapterType
    local hardType = ChapterConst.EMissionType.EMT_Hard
    return (mType == EType.ECT_Elite) or ((mType == EType.ECT_Activity) and (mission.difficulty == hardType))
end

-- 是否是9星关卡
function MissionHelper.Is9StarMission(mission)
    return mission.Chapter.type == ChapterConst.EChapterType.ECT_LimitChallge
end

-- 主线预热活动新关卡额外奖励道具(杜：暂时屏蔽)
function MissionHelper.ActivityAddMissionItem(chapterId)
    -- for _, data in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.MAIN_ACTIVITY_COPY) or {}) do
    --     if data:IsOpen() and (data:LockId() == 0) then
    --         for _, cfg in ipairs(ConfigHelper.GetCfgsByLua("activityAddMission", { activityId = data:ActivityId() }) or {}) do
    --             for _, id in ipairs(cfg.comingChapter or {}) do
    --                 if chapterId == id then return cfg.extraDropItem end
    --             end
    --         end
    --     end
    -- end
    return 0
end

function MissionHelper.MissionActivityShopCfg(chapterId)
    for _, data in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.MASKEDBALL_SHOP) or {}) do
        if data:IsOpen() and (data:LockId() == 0) then
            local activity = data:ActivityCfg()
            for i, id in ipairs(activity and activity.value or {}) do
                if (i > 1) and (id == chapterId) then return activity end
            end
        end
    end
    return nil
end

-- activityId: 活动商店activity表id
function MissionHelper.OpenMissionActivityShop(activityId)
    if activityId == 0 then return end
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId, function(data)
        if data and data:IsOpen() and (data:LockId() == 0) then
            local cfg = data:ActivityCfg()
            local parentId = cfg and cfg.value[1] or 0
            for _, v in ipairs(ConfigHelper.GetCfgsByLua("activityAddMission", { activityId = parentId }) or {}) do
                UIContextMgr:GetInstance():Show("MainPreheatSupplyUI", data, v.extraDropItem)
                return
            end
        else
            GameHelper.TipsById(1055) -- 活动未开放
        end
    end)
end

return MissionHelper
