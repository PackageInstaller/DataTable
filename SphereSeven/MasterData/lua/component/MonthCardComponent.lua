
---@class MonthCardComponent
---@field monthCards MonthCard[]
---@field monthCardList MonthCard[]
local MonthCardComponent = BaseClass("MonthCardComponent", Component)
local base = Component
local this = MonthCardComponent

function this:Awake()
    base.Awake(self)
    self.monthCardMap = {}
    self.monthCardList = {}

    for _, value in pairs(Z_MonthlyCard) do
        local monthcard = Game.Registry:NewObject("MonthCard", {
            id = value.Id,
            expire_time = 0,
            is_received = false,
            total_day = 0,
        })
        self.monthCardMap[value.Id] = monthcard
        table.insert(self.monthCardList, monthcard)
    end

    table.sort(self.monthCardList, function(a, b)
        return a.id < b.id
    end)
end

function this:CoLoadData()
    ---@type protocol.MonthlyCardResp
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            PROTOCOL.MonthlyCardReq, {})

    self:RefreshMonthCards(info.monthly_cards)
    return coroutine.yieldbreak(info)
end

---@param monthCards protocol.MonthlyCard[]
function this:RefreshMonthCards(monthCards)
    for _, card in pairs(monthCards) do
        local monthCard = self.monthCardMap[card.id]
        if monthCard == nil then
            monthCard = Game.Registry:NewObject("MonthCard", card)
            self.monthCardMap[card.id] = monthCard
            table.insert(self.monthCardList, monthCard)
        else
            monthCard:UpdateData(card)
        end
    end

    table.sort(self.monthCardList, function(a, b)
        return a.id < b.id
    end)
end

function this:OpenMonthlyCardUI(id)
    Logger.LogError("MonthCardComponent OpenMonthlyCardUI has been deprecated.")
    return
    -- if id == nil then
    --     for index, monthCard in ipairs(self.monthCardList) do
    --         if monthCard.expireTime > TimeUtil.GetServerTime() and not monthCard.isReceived then
    --             UIManager:GetInstance():OpenWindow(UIWindowNames.UIMonthCardShop,{id = monthCard.id})
    --             return
    --         end
    --     end
    -- else
    --     UIManager:GetInstance():OpenWindow(UIWindowNames.UIMonthCardShop,{id = id})
    -- end
end

function this:ReceiveAllMonthCard()
    local ids = {}
    for index, value in ipairs(self.monthCardList) do
        if value:GetLastTime() > 0 and not value.isReceived then
            table.insert(ids, value.id)
        end
    end

    if table.count(ids) > 0 then
        ---@param response protocol.MonthlyCardReceiveResp
        PublicRequest.SendRequest(
            PROTOCOL.MonthlyCardReceiveReq,
            {
                ids = ids
            },
            function(response)
                local rewardResults = {}
                local rewardIds = {}
                for index, value in ipairs(response.monthly_card_reward_results) do
                    for i, v in ipairs(value.reward_results) do
                        if rewardIds[v.type] == nil then
                            rewardIds[v.type] = {}
                        end
                        if rewardIds[v.type][v.id] == nil then
                            rewardIds[v.type][v.id] = v.count
                        else
                            rewardIds[v.type][v.id] = rewardIds[v.type][v.id] + v.count
                        end
                    end
                end
                for type, value in pairs(rewardIds) do
                    for id, count in pairs(value) do
                        table.insert(rewardResults, {type = type, id = id, count = count})
                    end
                end
                UIPublic.OpenRewardUI(rewardResults, nil, 553)
            end
        )
    end
end

function this:DailyRefresh()
    for index, monthCard in ipairs(self.monthCardList) do
        if monthCard.expireTime > TimeUtil.GetServerTime() then
            monthCard.isReceived = false
        end
    end
end

function this:hasMonthlyCardCanReceive()
    return true
end

function this:hasMonthlyCardCanBuy()
    return true
end

function this:GetMonthCards()
    return self.monthCardList
end

---@return MonthCard
function this:GetMonthCard(id)
    return self.monthCardMap[id]
end

function this:Dispose()
    base.Dispose(self)
end


return this