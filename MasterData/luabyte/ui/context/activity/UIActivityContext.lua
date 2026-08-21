-- baoruichang
-- 2023.5.15 11:06:42
local UIActivityContext = BaseClass("UIActivityContext", BaseContext)
local M = UIActivityContext
local EActivityId = EnumConst.EActivityId
local tSort = table.sort

function M:Open(activityId, closeCallBack)
    self.canRecharge = true
    self:_Show(activityId, closeCallBack)
end

-- 判断成长基金是否开放
function M:LevelFundOpen()
    local payId, awardMask, awardMaskPaid = LevelFundMgr:GetInstance():GetData()
    if not payId or payId == 0 or awardMask ~= awardMaskPaid then
        return true
    end
    if not self.growGolds then
        self.growGolds = ConfigHelper.GetCfgs("growGold")
    end
    for _, growGold in pairs(self.growGolds) do
        local id = growGold.id
        if not LevelFundMgr:GetInstance():_IsReward(id, awardMask) then
            return true
        end
        if not LevelFundMgr:GetInstance():_IsReward(id, awardMaskPaid) then
            return true
        end
    end
end

-- 判断签到活动是否开放
function M:_SignActivityIsOpen(activity)
    if activity.ifOpen ~= 1 then
        return
    end
    local activityData = ActivityDataMgr:GetInstance():GetActivityData(activity.id)
    if not activityData then
        return
    end
    if activity.openType == 4 then
        return true
    end
    if activity.openType == 2 then
        if activityData and activityData:IsOpen() then
            return true
        end
    end
end

function M:_ResourceActivityIsOpen(activity)
    if activity.ifOpen ~= 1 then
        return
    end
    if not GameHelper.CheckLockByOpenConditionIds(activity.openCondition) then
        return
    end
    if activity.openType == 2 then
        local activityData = ActivityDataMgr:GetInstance():GetActivityData(activity.id)
        if activityData and activityData:IsOpen() then
            return true
        end
    end
end

function M:GetActivityDatas()
    local activityDatas = {}
    local activitys = ConfigHelper.GetCfgs("activity")
    local index = 1
    for id, activity in pairs(activitys) do
        if activity.type == ActivityType.SIGN and self:_SignActivityIsOpen(activity) then
            local data = {}
            data.id = id
            data.name = activity.name
            data.type = activity.type
            data.order = activity.order
            data.soundId = 0
            activityDatas[index] = data
            index = index + 1
        end
        if activity.type == ActivityType.RES_ACTIVITY_COPY and self:_ResourceActivityIsOpen(activity) then
            local data = {}
            data.id = id
            data.name = activity.name
            data.type = activity.type
            data.order = activity.order
            activityDatas[index] = data
            index = index + 1
        end
    end

    -- 每日体力领取
    do
        local data = {}
        data.id = EActivityId.DayEnergy -- 每日体力领取
        data.name = 6259
        data.order = -2
        activityDatas[index] = data
        index = index + 1
    end
    -- 月签到
    local openConditionMonthSign = ConfigHelper.GetCfgPropByLua("functionOpen", 21, "openCondition")
    local isUnlockMonthSign = JumpMgr:GetInstance():CheckLockByOpenConditionIds(openConditionMonthSign)
    if isUnlockMonthSign then
        local data = {}
        data.id = EActivityId.MonthSign -- 月签到标识
        data.name = 200039
        data.order = -1
        data.soundId = 0
        activityDatas[index] = data
        index = index + 1
    end

    -- 首充
    local firstRechargeState = RechargeDataMgr:GetInstance():CheckFirstRechargeReward()
    if firstRechargeState ~= nil then
        local data = {}
        data.id = EActivityId.FirstRecharge -- 首充标识
        data.name = 5814
        data.order = 100
        data.soundId = 0
        activityDatas[index] = data
        index = index + 1
    end
    -- 成长基金
    if self:LevelFundOpen() then
        local data = {}
        data.id = EActivityId.LevelFund -- 成长基金
        data.name = 6283
        data.order = 101
        activityDatas[index] = data
        index = index + 1
    end
    tSort(activityDatas, self._Sort)
    return activityDatas
end

function M._Sort(data1, data2)
    return data1.order < data2.order
end

function M:SetCanRecharge(canRecharge)
    -- 记录活动页签能否切换能否关闭
    self.canRecharge = canRecharge
end

function M:GetCanRecharge()
    return self.canRecharge
end

return UIActivityContext
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = .O
--                        ____.`---'\____
--						  . ' \\| |.. `.
--                       . \\||| : |||.. \
--                     . _||||| -:- |||||- \
--                       | | \\\ - --. | |
--                     | \_| ''\---.'' | |
--                      \ .-\__ `-` ___.-. .
--                   ___`. .' .--.--\ `. . __
--                ."" '< `.___\_<|>_.___.' >'"".
--               | | : `- \`.;`\ _ .`;.`. - ` : | |
--                 \ \ `-. \_ __\ .__ _. .-` . .
--         ======`-.____`-.___\_____.___.-`____.-'======
--                            `=---='
--
--         .............................................
--                       一个是阆苑仙葩，
--                       一个是美玉无瑕。
--                       若说没奇缘，
--                       今生偏又遇着他；
--                       若说有奇缘，
--                       如何心事终虚化？
--                       一个枉自嗟呀，
--                       一个空劳牵挂。
--                       一个是水中月，
--                       一个是镜中花。
--                       想眼中能有多少泪珠儿，
--                       怎禁得秋流到冬尽，
--                       春流到夏！
