local ChapterConst = {}


-- 章节类型
local EChapterType = {
    ECT_None = 0,      -- 0 默认，调试关卡，未定型
    ECT_Main = 1,      -- 1 主线关卡（存进度）
    ECT_Elite = 2,     -- 2 精英关卡
    ECT_Resource = 3,  -- 3 资源关卡
    ECT_Activity = 4,  -- 4 活动副本
    ECT_Encounter = 5, -- 5 遭遇战
    ECT_Personal = 6,  -- 6 个人副本
    ECT_Boss = 7,       -- 7 Boss副本
    ECT_LimitChallge = 8    -- 8 极限挑战
}

local EMissionType = {
    EMT_None = 0,
    EMT_Main = 1,
    EMT_Hard = 2,
}

ChapterConst.EChapterType = EChapterType
ChapterConst.EMissionType = EMissionType

return ChapterConst
