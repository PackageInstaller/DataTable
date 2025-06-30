local DailyRewardMock = BaseClass("DailyRewardMock", Singleton);

local mockData = {
    count = 0,
    is_received = false,
    commonCheckIns = {}
}

local function DailyRewardReq(reqMsg)
    ---@type protocol.DailyRewardResp
    local rspMsg = {}
    local time = os.date("*t", os.time())
    rspMsg.count = math.random(0, time.day)
    if rspMsg.count == time.day then
        rspMsg.is_received = true
    else
        rspMsg.is_received = true
    end
    mockData.count = rspMsg.count
    mockData.is_received = rspMsg.is_received

    return rspMsg
end

---@param msg protocol.DailyRewardReceiveReq
local function DailyRewardReceiveReq(msg)
    ---@type protocol.DailyRewardReceiveResp
    local ret = {}
    ret.daily_reward_results = {}
    -- type, id, count []
    local time = os.date("*t", os.time())
    local rewardId = Z_DailyCheckIn[time.month][time.day].Reward
    for key, value in pairs(Z_Reward[rewardId]) do
        table.insert(
            ret.daily_reward_results,
            {
                type = value.Type,
                id = value.ObjId,
                count = value.Count
            }
        )
    end

    mockData.count = mockData.count + 1
    mockData.is_received = true
    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.DailyRewardUpdatePush, {
        count = mockData.count,
        is_received = mockData.is_received,
    })
    return ret
end

local function updateCheckInData(groupId)
    ---@type protocol.CommonCheckInUpdatePush
    local ret = {}
    ret.group_id = groupId
    ret.common_check_in = mockData.commonCheckIns[groupId]

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.FightSoulUpdatePush, ret)
end

---@param msg protocol.CommonCheckInReq
local function CommonCheckInReq(msg)
    ---@type protocol.CommonCheckInResp
    local ret = {}
    
    if mockData.commonCheckIns[msg.group_id] == nil then
        ---@type protocol.CommonCheckIn[]
        local commonCheckIns = {}

        local commonCheckInData = Z_CommonCheckIn[msg.group_id]
        local commonCheckInGroupData = Z_CommonCheckInGroup[commonCheckInData.Group]
        local count = math.random(1, table.count(commonCheckInGroupData))
        for index, value in ipairs(commonCheckInGroupData) do
            ---@type protocol.CommonCheckIn
            local commonCheckIn = {}
            commonCheckIn.id = index
            commonCheckIn.progress = count
            commonCheckIn.config = value
            commonCheckIn.status = CommonCheckInStatus.CommonCheckInOnGoing
            if index < count then
                commonCheckIn.receive_status = CheckInReceiveStatus.CheckInReceiveReceived
            elseif index == count then
                commonCheckIn.receive_status = CheckInReceiveStatus.CheckInReceiveNotReceived
            else
                commonCheckIn.receive_status = CheckInReceiveStatus.CheckInReceiveUnavailable
            end

            table.insert(commonCheckIns, commonCheckIn)
        end

        mockData.commonCheckIns[msg.group_id] = commonCheckIns
    end

    ret.group_id = msg.group_id
    ret.common_check_in = mockData.commonCheckIns[msg.group_id]
    return ret
end

---@param msg protocol.CommonCheckInReceiveReq
local function CommonCheckInReceiveReq(msg)
    ---@type protocol.CommonCheckInReceiveResp
    local ret = {}
    ret.group_id = msg.group_id
    ret.id = msg.id
    ret.reward_result = {}
    for index, value in ipairs(Z_Reward[mockData.commonCheckIns[msg.group_id][msg.id].config.Reward]) do
        table.insert(
            ret.reward_result,
            {
                type = value.Type,
                id = value.ObjId,
                count = value.Count
            }
        )
    end
    mockData.commonCheckIns[msg.group_id][msg.id].receive_status = CheckInReceiveStatus.CheckInReceiveReceived

    return ret
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.DailyRewardReq, DailyRewardReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.DailyRewardReceiveReq, DailyRewardReceiveReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CommonCheckInReq, CommonCheckInReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CommonCheckInReceiveReq, CommonCheckInReceiveReq)

end

local function __delete(self)
end

DailyRewardMock.__init = __init
DailyRewardMock.__delete = __delete


return DailyRewardMock;