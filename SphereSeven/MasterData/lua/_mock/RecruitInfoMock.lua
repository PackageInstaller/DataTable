local SummonInfoMock = BaseClass("SummonInfoMock", Singleton);

local mockData = {}

local function RecruitInfoReq(reqMsg)
    ---@type protocol.RecruitInfoResp
    local ret = {}
    ret.recruit = {}
    ret.recruit.log_begin_id = 0
    mockData.log_begin_id = 0

    ret.recruit.log_end_id = 0
    mockData.log_end_id = 0

    ret.recruit.recruit_pools = {}
    mockData.recruit_pools = {}
    mockData.poolMap = {}
    for key, value in pairs(Z_Recruit) do
        local pool = {}
        pool.id = value.Id
        pool.count = 0
        pool.startTime = os.time() - 999 -- value.StartTime
        pool.endTime = os.time() + 36000 -- value.EndTime
        pool.config = value
        pool.status = RecruitPoolStatus.RecruitPoolStatusUnknown
        if pool.startTime ~= nil and os.time() < pool.startTime then
            -- 未开启
            pool.startTime = RecruitPoolStatus.RecruitPoolStatusBeforeStartTime
            pool.status = RecruitPoolStatus.RecruitPoolStatusBeforeStartTime
            mockData.poolMap[pool.id] = pool
            table.insert(ret.recruit.recruit_pools, pool)
            table.insert(mockData.recruit_pools, pool)
        elseif pool.endTime ~= nil and os.time() > pool.endTime then
            -- 已关闭
            pool.status = RecruitPoolStatus.RecruitPoolStatusAfterEndTime
            mockData.poolMap[pool.id] = pool
        else
            -- 时间上 进行中
            if value.RecruitLimit ~= nil and value.RecruitLimit ~= 0 and pool.count >= value.RecruitLimit then
                -- 次数达到上限
                pool.status = RecruitPoolStatus.RecruitPoolStatusOverRecruitLimit
            else
                -- 正常
                pool.status = RecruitPoolStatus.RecruitPoolStatusOpen
            end
            mockData.poolMap[pool.id] = pool
            table.insert(ret.recruit.recruit_pools, pool)
            table.insert(mockData.recruit_pools, pool)
        end
    end

    ret.recruit.recruit_rookie_pools = {}
    mockData.recruit_rookie_pools = {}

    ret.recruit.recruit_guarantees = {}
    mockData.recruit_guarantees = {}

    return ret
end

---@param msg protocol.RecruitReq
local function RecruitReq(msg)
    local item = MockManager:GetInstance().GetMock("ItemInfo"):GetItemByUid(msg.brief_item.uid)
    if item  == nil or item.count < msg.brief_item.count then
        Logger.LogError("道具不足")
        return
    end

    local time = 0
    for _, value in pairs(Z_RecruitItem[mockData.poolMap[msg.id].config.Item]) do
        if value.ItemId == item.cid and value.Count == msg.brief_item.count then
            time = value.Time
            break
        end
    end
    ---@type protocol.RecruitResp
    local req = {}
    req.reward_details = {}
    for i = 1, time do
        local zRecruitReward = Z_RecruitReward[mockData.poolMap[msg.id].config.PoolConfig]
        local data = zRecruitReward[math.random(1, table.count(zRecruitReward))]
        local reward = {
            type = data.RewardType,
            count = data.Count,
            id = data.RewardId,
        }
        table.insert(req.reward_details, {
            rewards = {reward},
            reward_results = {reward}
        })
    end

    if mockData.poolMap[msg.id].config.CardPoolType == RecruitPoolType.RecruitPoolRookie then
        local rewards = {}
        for index, value in ipairs(req.reward_details) do
            table.insert(rewards, value.rewards[1])
        end
        local rookiePoolData = {
            id = msg.id,
            rewards = rewards
        }
        mockData.recruit_rookie_pools[msg.id] = rookiePoolData
    end
    return req
end

---@param msg protocol.RecruitRookiePoolConfirmReq
local function RecruitRookiePoolConfirmReq(msg)
    if mockData.recruit_rookie_pools[msg.id] == nil then
        return {}
    end

    ---@type protocol.RecruitRookiePoolConfirmResp
    local ret = {}
    ret.reward_details = {}
    for index, reward in ipairs(mockData.recruit_rookie_pools[msg.id].rewards) do
        table.insert(ret.reward_details, {
            rewards = {reward},
            reward_results = {reward}
        })
    end
    return ret
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.RecruitInfoReq, RecruitInfoReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.RecruitReq, RecruitReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.RecruitRookiePoolConfirmReq, RecruitRookiePoolConfirmReq)
end

local function __delete(self)
end

SummonInfoMock.__init = __init
SummonInfoMock.__delete = __delete


return SummonInfoMock