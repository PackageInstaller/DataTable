local GamesDataMgr = BaseClass("GamesDataMgr", Singleton)
local M = GamesDataMgr
local MessageId = Proto.MessageId

function M:__init()
    self._responseMiniGamesRecord = NetPack:RegistResponse(MessageId.ResponseMiniGameRecord, Bind(self, self._OnResponseMiniGamesRecord))
    self._responseMiniGameResult = NetPack:RegistResponse(MessageId.ResponseMiniGameResult, Bind(self, self._OnResponseMiniGameResult))
    
    self._games = {1}
    self._distroyData = {}
end


function M:Games()
    return self._games
end


function M:GameDistroy(id)
    return self._distroyData[id]
end


function M:HeroGamesData()
    local request = {}
    NetPack:SendMessage(MessageId.RequestMiniGameRecord, request)
end


function M:HeroGamesEndData(id, hero, time, score)
    local request = {}
    request.Id = id
    request.Hero = hero
    request.SpanTime = time
    request.Score = score
    NetPack:SendMessage(MessageId.RequestMiniGameResult, request)
end


function M:_OnResponseMiniGamesRecord(messageId, result, msg)
    if result ~= 0 then 
        return 
    end

    for i,v in ipairs(msg.Records) do
        self:_SaveData(v)
    end

    EventMgr:Broadcast(UIMessageNames.GAME_GAMEEFRESH)
end


function M:_OnResponseMiniGameResult(messageId, result, msg)
    if result ~= 0 then 
        print('提交错误 错误码：' .. result)
        return 
    end

    self:_SaveData(msg.Record)
    EventMgr:Broadcast(UIMessageNames.GAME_DATAREFRESH)
end


function M:_SaveData(data)
    if self._distroyData[data.Id] == nil then
        self._distroyData[data.Id] = {}
    end

    self._distroyData[data.Id] = data
end



return GamesDataMgr
