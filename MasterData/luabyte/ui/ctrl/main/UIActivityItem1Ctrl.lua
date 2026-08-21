local UIActivityItem1Ctrl = BaseClass("UIActivityItem1Ctrl")
local M = UIActivityItem1Ctrl
local tInsert = table.insert
local tSort = table.sort

function M:__init(view)
    self._view = view
    self.tabItem = {}
    self._view.BannerImage:SetActive(false)
    tInsert(self.tabItem, self._view.BannerImage)
end

function M:UpdateData()
    -- 假面舞会简单数据
    self.simpleDatas = ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.MASKEDBALL_MAIN)
    tSort(self.simpleDatas, self._SortFunc)
    for i, simpleData in ipairs(self.simpleDatas) do
        -- if simpleData:ActivityId() == 3001 then
        local BannerImage = self.tabItem[i]
        if not BannerImage then
            BannerImage = self._view.BannerImage:Instantiate()
            tInsert(self.tabItem, BannerImage)
        end
        local data = {}
        data.activityId = simpleData:ActivityId()
        data.callBack = Bind(self, self._onClick)
        BannerImage:UpdateData(data)
        if self:IsShow(simpleData) or simpleData:IsClosing() then
            BannerImage:SetActive(true)
        else
            BannerImage:SetActive(false)
        end
        -- end
    end
end

function M:IsShow(simpleData)
    local cfg = simpleData:ActivityCfg()
    if not cfg or (cfg.ifOpen ~= 1) then return false end
    --if not GameHelper.CheckLockByOpenConditionIds(cfg.openCondition) then return false end

    if cfg.openType == 1 then     -- 1.开服时间（开服第N天的凌晨0点开启若第一天则几点开服几点开活动，以凌晨0点结算天数）
        -- body
    elseif cfg.openType == 2 then -- 2.固定时间（时间戳）
        return GameUtil.CheckInTime(simpleData:StartTime(), simpleData:EndTime())
    elseif cfg.openType == 3 then -- 3.功能达到开放条件后开始计时
        -- body
    elseif cfg.openType == 4 then -- 4.创角后开启
        -- body
    end
    return GameUtil.CheckInTime(simpleData:StartTime(), simpleData:EndTime())
end

function M._SortFunc(data1, data2)
    return data1:ActivityId() < data2:ActivityId()
end

function M:_onClick(activityId)
    local openConditions = ConfigHelper.GetCfgPropByLua("activity", activityId, "openCondition")
    for _, openCondition in pairs(openConditions) do
        local isUnlock = JumpMgr:GetInstance():CheckLockByOpenConditionId(openCondition)
        if not isUnlock then
            local lockTips = ConfigHelper.GetCfgPropByLua("openCondition", openCondition, "tips")
            GameHelper.TipsById(lockTips)
            return
        end
    end

    JumpMgr:GetInstance():Execute(304, activityId)
end

function M:OnDispose()
    for _, value in ipairs(self.tabItem) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    self.tabItem = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UIActivityItem1Ctrl
