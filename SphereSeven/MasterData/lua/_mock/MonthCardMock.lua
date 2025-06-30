local MonthCardMock = BaseClass("MonthCardMock", Singleton)

local mockData = {}

local function updateData(ids)
    ---@type protocol.MonthlyCardUpdatePush
    local ret = {}
    ret.monthly_cards = {}

    for _, id in pairs(ids) do
        table.insert(ret.monthly_cards, mockData[id])
    end

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.MonthlyCardUpdatePush, ret)
end

local function MonthCard(reqMsg)
    ---@type protocol.MonthlyCardResp
    local rspMsg = {}
    rspMsg.monthly_cards = {}
    for _, value in pairs(Z_MonthlyCard) do
        ---@type protocol.MonthlyCard
        local card = {}
        card.id = value.Id
        card.expire_time = os.time() + 3600 * 24 * 30
        card.is_received = true

        mockData[card.id] = card
        table.insert(rspMsg.monthly_cards, card)
    end

    return rspMsg
end

---@param msg protocol.MonthlyCardReceiveReq
local function MonthlyCardReceiveReq(msg)
    local updateIds = {}

    ---@type protocol.MonthlyCardReceiveResp
    local ret = {}
    ret.monthly_card_reward_results = {}
    for key, id in pairs(msg.ids) do
        ---@type protocol.MonthlyCardRewardResults
        local MonthlyCardRewardResults = {}
        MonthlyCardRewardResults.id = id
        MonthlyCardRewardResults.reward_results = {}
        local rewardId = Z_MonthlyCard[id].Reward
        for key, value in pairs(Z_Reward[rewardId]) do
            table.insert(
                MonthlyCardRewardResults.reward_results,
                {
                    type = value.Type,
                    id = value.ObjId,
                    count = value.Count
                }
            )
        end
        table.insert(ret.monthly_card_reward_results, MonthlyCardRewardResults)
        mockData[id].is_received = true
        table.insert(updateIds, id)
    end

    updateData(updateIds)

    return ret
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.MonthlyCardReq, MonthCard)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.MonthlyCardReceiveReq, MonthlyCardReceiveReq)
end

local function __delete(self)
end

MonthCardMock.__init = __init
MonthCardMock.__delete = __delete


return MonthCardMock