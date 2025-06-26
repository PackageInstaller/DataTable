local ItemInfoMock = BaseClass("ItemInfoMock", Singleton)
-- Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.ItemUpdatePush, updateMsg)

---@param reqMsg protocol.ArenaHistoryReq
local function ArenaHistoryReq(reqMsg)
    ---@type protocol.ArenaHistoryResp
    local rspMsg = {}
    rspMsg.history = {}

    return rspMsg
end

---@param reqMsg protocol.ArenaInfoReq
local function ArenaInfoReq(reqMsg)
    ---@type protocol.ArenaInfoResp
    local rspMsg = {}
    rspMsg.info = {}
    rspMsg.info.rank = 1
    rspMsg.info.score = 1
    rspMsg.info.history = {
        battle_total_count = 1,
        battle_win_count = 1,
        highest_division = 1,
        highest_division_season = 1,
    }
    rspMsg.info.records = {}
    rspMsg.info.battle_season_count = 1
    rspMsg.info.battle_season_win_count = 1
    rspMsg.info.power = 10
    rspMsg.info.last_power_refresh_time = os.clock()
    rspMsg.info.season = 1
    rspMsg.info.division = 1

    return rspMsg
end

---@param reqMsg protocol.ArenaRefreshChallengerReq
local function ArenaRefreshChallengerReq(reqMsg)
    ---@type protocol.ArenaRefreshChallengerResp
    local rspMsg = {}
    rspMsg.challengers = {}

    return rspMsg
end

---@param reqMsg protocol.ArenaGetLeaderboardReq
local function ArenaGetLeaderboardReq(reqMsg)
    ---@type protocol.ArenaGetLeaderboardResp
    local rspMsg = {}
    rspMsg.challengers = {}

    return rspMsg
end

---@param reqMsg protocol.ArenaAddChallengeTimesReq
local function ArenaAddChallengeTimesReq(reqMsg)
    ---@type protocol.ArenaAddRefreshTimesResp
    local rspMsg = {}

    return rspMsg
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ArenaHistoryReq, ArenaHistoryReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ArenaInfoReq, ArenaInfoReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ArenaRefreshChallengerReq, ArenaRefreshChallengerReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ArenaGetLeaderboardReq, ArenaGetLeaderboardReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.ArenaAddChallengeTimesReq, ArenaAddChallengeTimesReq)
end

local function __delete(self)
end

ItemInfoMock.__init = __init
ItemInfoMock.__delete = __delete


return ItemInfoMock;