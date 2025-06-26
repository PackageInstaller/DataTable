local ActivityDemonInfoMock = BaseClass("ActivityDemonInfoMock", Singleton);

---@type protocol.GameEventResp
local mockData = {}

local function convertToTimestamp(dateString)
    if dateString == nil or dateString == "" then return 0 end
    local year, month, day, hour, min, sec = dateString:match("(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)")
    local parseDate = {
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec)
    }

    if parseDate then
        return os.time(parseDate)
    else
        Logger.LogError("mock: GameEventMock 解析活动时间失败, Time:" .. dateString)
        return 0
    end
end


---@param msg protocol.GameEventReq
local function GameEventReq(msg)
    ---@type protocol.GameEventResp
    local ret = {}
    local osTime = os.time()

    mockData = {}
    mockData.events = {}
    mockData.modules = {}

    for gameEventId, gameEventData in pairs(Z_GameEvents) do
        -- mock 中 默认活动全部开启中
        ---@type protocol.GameEvent
        local gameEvent = {}
        gameEvent.event_id = gameEventId
        gameEvent.start_time = convertToTimestamp(gameEventData.StartTime)
        gameEvent.end_time = convertToTimestamp(gameEventData.EndTime)
        gameEvent.status = GameEventStatus.GameEventStatusInProgress

        for gameModelId, gameModelData in pairs(gameEventData) do
            ---@type protocol.GameEventModule
            local gameModel = {}
            gameModel.event_id = gameEventId
            gameModel.module_id = gameModelId
            gameModel.start_time = convertToTimestamp(gameModelData.StartTime)
            gameModel.end_time = convertToTimestamp(gameModelData.EndTime)
            gameModel.status = GameEventStatus.GameEventStatusInProgress
            table.insert(mockData.modules, gameModel)
        end

        table.insert(mockData.events, gameEvent)
        
    end

    ret = mockData
    return ret
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.GameEventReq, GameEventReq)
end

local function __delete(self)
end

ActivityDemonInfoMock.__init = __init
ActivityDemonInfoMock.__delete = __delete


return ActivityDemonInfoMock;