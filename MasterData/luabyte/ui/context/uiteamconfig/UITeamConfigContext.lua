-- baoruichang
-- 2022/3/8 15:06:30
local M = BaseClass("UITeamConfigContext", BaseContext)
local tInsert = table.insert
local MessageId = Proto.MessageId
local EBattleStyle = EnumConst.EBattleStyle
local EChapterType = ChapterConst.EChapterType
local TeamConfigStyle = EnumConst.TeamConfigStyle
local HOURS5 = 18000

function M:Init()
    self._heroId = 0
    self._TempNotifyHelpTimesChange = NetPack:RegistResponse(MessageId.NotifyHelpTimesChange,
        Bind(self, self._NotifyHelpTimesChange))
end

function M:Open(isTeach, battleMissionId, teamConfigStyle, heroId, battleStyle)
    self._heroId = heroId
    self._isTeach = isTeach
    self._battleStyle = battleStyle
    self._teamConfigStyle = teamConfigStyle
    self._mission = ConfigHelper.GetCfgByLua("mission", battleMissionId)
    -- if self._mission then
    -- local missionType = self._mission.Chapter.type
    GlobalTeamConfMgr:GetInstance():SetBattleType(battleStyle)
    -- else
    --     GlobalTeamConfMgr:GetInstance():SetMissionType(ChapterConst.EChapterType.ECT_Main)
    -- end

    CS.GameX.GameGlobal.battleMissionId = battleMissionId or 0
    GlobalTeamConfMgr:GetInstance().Mgr:LoadData(Bind(self, self.OnDataLoaded))
end

function M:OnDataLoaded(teamDatas)
    local missionId = self._teamConfigStyle == TeamConfigStyle.Battle and self._mission.id or nil
    self:_Show(self._isTeach, missionId, self._teamConfigStyle)
end

function M:GetBattleStyle()
    return self._battleStyle
end

-- 请求C#进入战斗
function M:EnterBattle(heroDatas)
    local missionId = self._mission.id
    if self._battleStyle == EBattleStyle.Reward then
        local context = UIContextMgr:GetInstance():GetContext("MissionOfferRewards")
        local allKeyWords, useItems = self:_GetHeroKeywords(heroDatas), {}
        if context:IsUseItem() then                -- 使用激素道具
            local items = context:CurItemSpecial() -- GameHelper.GetParamters(280)
            local entrys = GameHelper.GetParamters(281)
            if items then useItems = items end
            -- for i = 0, items.Length - 1, 1 do tInsert(useItems, items[i]) end
            for i = 0, entrys.Length - 1, 1 do tInsert(allKeyWords, entrys[i]) end
        end

        -- 选中词条
        for _, id in ipairs(context:SelectKeyWords()) do tInsert(allKeyWords, id) end

        local wordMask = context:CurWordMask()
        local wantedId = context:CurWantedId()
        local activityId = context:CurActivityId()
        IPlayerData.cur_chapterId = self._mission.chapterID
        IBattle:EnterRewardBattle(wantedId, activityId, missionId, wordMask, useItems, allKeyWords)
    elseif self._mission.ChapterType == EChapterType.ECT_Personal then
        IBattle:EnterPersonalBattle(self._heroId, self._mission.ChapterId, missionId, self:_GetHeroKeywords(heroDatas))
    elseif self._battleStyle == EBattleStyle.Boss then
        local selectWords = {}
        local data = BossWarTeamMgr:GetInstance():GetBossData()
        for id, _ in pairs(data:GetWordDic()) do tInsert(selectWords, id) end
        IBattle:EnterBossBattle(data:BossWarId(), selectWords, data:BossType())
    elseif self._battleStyle == EBattleStyle.LimitChallge then
        IPlayerData.cur_chapterId = self._mission.chapterID
        IBattle:EnterResourceBattle(missionId, GameHelper.GetChallengeTarget(missionId))
    else
        local md = MissionDataMgr:GetInstance():GetMissionDataById(missionId)
        if md then
            if md:IsMain() then
                IBattle:EnterBattle(missionId) -- , self:_GetHeroKeywords(heroDatas)
            elseif md:IsHard() then
                IBattle:EnterEliteBattleBattle(missionId, GameHelper.GetChallengeTarget(missionId))
            elseif md:IsResource() then
                IBattle:EnterResourceBattle(missionId, GameHelper.GetChallengeTarget(missionId))
            elseif md:IsActivity() then
                local actId = ActivityCopyDataMgr:GetInstance():GetActivity()
                IBattle:EnterActiveBattle(missionId, actId, GameHelper.GetChallengeTarget(missionId))
            else                               --为了给工具用 其他模式的战斗都按常规战斗进入
                IBattle:EnterBattle(missionId) -- , self:_GetHeroKeywords(heroDatas)
            end
        else
            Logger.LogError("mission is nil, id = " .. missionId)
        end
    end
end

-- 获得带入战场的词条 ,目前分为突破和核心两大块的词条
function M:_GetHeroKeywords(heroIds)
    local heroKeywords = {}
    for _, id in ipairs(heroIds) do
        local heroData = IHeroDataMgr:GetMyHeroDataById(id)
        if heroData then
            for _, v in pairs(self:_GetHeroCore(heroData)) do tInsert(heroKeywords, v) end
            for _, v in pairs(self:_GetBreak(heroData)) do tInsert(heroKeywords, v) end
        end
    end

    self._heroBreaks = nil
    self._heroCores = nil
    return heroKeywords
end

function M:_GetHeroCore(heroData)
    if not self._heroCores then self._heroCores = ConfigHelper.GetCfgs("heroCore") end

    local heroCore
    for i = 0, self._heroCores.Length - 1 do
        if self._heroCores[i].heroId == heroData:GetHeroId() and self._heroCores[i].coreLevel == heroData:GetCoreLevel() then
            heroCore = self._heroCores[i]
            break
        end
    end

    if heroCore and heroCore.mapCondition then
        local data = {}
        for i = 0, heroCore.mapCondition.Length - 1 do
            tInsert(data, heroCore.mapCondition[i])
        end
        return data
    end
    return {}
end

function M:_GetBreak(heroData)
    if not self._heroBreaks then self._heroBreaks = ConfigHelper.GetCfgs("heroBreak") end

    local heroBreak
    for i = 0, self._heroBreaks.Length - 1 do
        if self._heroBreaks[i].heroId == heroData:GetHeroId() and self._heroBreaks[i].breakLevel == heroData:GetBreakLevel() then
            heroBreak = self._heroBreaks[i]
            break
        end
    end

    if heroBreak and heroBreak.mapCondition then
        local data = {}
        for i = 0, heroBreak.mapCondition.Length - 1 do
            tInsert(data, heroBreak.mapCondition[i])
        end
        return data
    end
    return {}
end

-- 请求助战次数
function M:GetHelperNum(helpType, callback)
    self.helpType = helpType
    self.callback = callback
    if self.HelpTimesData then
        local nowTimer = TimeUtil.GetNowTimeStamp()
        local isOneDay = TimeUtil.IsOneDay(self.HelpTimesData.LastResetTime - HOURS5, nowTimer - HOURS5)
        if isOneDay then
            self:ReturnHelpNum()
        else
            self:RequestHelpTimesInfo()
        end
    else
        self:RequestHelpTimesInfo()
    end
end

function M:ReturnHelpNum()
    local num = 0
    -- 常规
    if self.helpType == EChapterType.ECT_Main then
        num = self.HelpTimesData.NormalHelpTimes
    elseif self.helpType == EChapterType.ECT_Elite then     -- 精英
        num = self.HelpTimesData.NormalHelpTimes
    elseif self.helpType == EChapterType.ECT_Resource then  -- 资源
        num = self.HelpTimesData.ResourceHelpTimes
    elseif self.helpType == EChapterType.ECT_Encounter then -- 遭遇战
        num = self.HelpTimesData.EncounterHelpTimes
    elseif self.helpType == EChapterType.ECT_Activity then  -- 活动副本
        num = self.HelpTimesData.ActivityCopyHelpTimes
    elseif self.helpType == -1 then                         -- 悬赏
        num = self.HelpTimesData.WantedHelpTimes
    end

    if self.callback then
        self.callback(num)
        self.callback = nil
    end
end

------------------------------------Start-------------------------------------------
-- 编队处于激活Req
function M:RequestActiveTeam(TeamId, needActive)
    if not needActive then
        self:_ResponseActiveTeamCallback(0, 0, { TeamId = TeamId })
    else
        self._TempResponseActiveTeamCallback = NetPack:RegistResponse(MessageId.ResponseActiveTeam,
            Bind(self, self._ResponseActiveTeamCallback))
        local request = {}
        request.TeamId = TeamId
        NetPack:SendMessage(MessageId.RequestActiveTeam, request)
    end
end

-- 请求推荐好友信息 Req
function M:RequestRecommendFriendInfo(FriendId, isFriends)
    self.isFriends = isFriends
    self._TempResponseRecommendFriendInfoCallback = NetPack:RegistResponse(MessageId.ResponseRecommendFriendInfo,
        Bind(self, self._ResponseRecommendFriendInfoCallback))
    local request = {}
    request.FriendId = FriendId
    NetPack:SendMessage(MessageId.RequestRecommendFriendInfo, request)
end

-- 助战次数信息 Req
function M:RequestHelpTimesInfo()
    -- Logger.LogError("请求助战次数Req")
    self._TempResponseHelpTimesInfoCallback = NetPack:RegistResponse(MessageId.ResponseHelpTimesInfo,
        Bind(self, self._ResponseHelpTimesInfoCallback))
    local request = {}
    NetPack:SendMessage(MessageId.RequestHelpTimesInfo, request)
end

-- 编队处于激活Ack
function M:_ResponseActiveTeamCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseActiveTeam, self._TempResponseActiveTeamCallback)
    self._TempResponseActiveTeamCallback = nil

    if result ~= 0 then
        return
    end

    local teamData = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamById(msg.TeamId)
    local heroDatas = {}

    if teamData and teamData.Heroes then
        for i = 1, #teamData.Heroes do
            tInsert(heroDatas, teamData.Heroes[i])
        end
    end

    self:EnterBattle(heroDatas)
end

-- 请求推荐好友信息Ack
function M:_ResponseRecommendFriendInfoCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseRecommendFriendInfo, self._TempResponseRecommendFriendInfoCallback)
    self._TempResponseRecommendFriendInfoCallback = nil

    if result ~= 0 then
        Logger.LogError("错误：" .. tostring(result))
        return
    end

    self.playerData = self.playerData or {}
    local data = nil

    if self.playerData[msg.FriendId] then
        data = self.playerData[msg.FriendId]
    else
        data = {}
        self.playerData[msg.FriendId] = data
    end

    data.FriendId = msg.FriendId
    data.isFriends = self.isFriends
    local BaseData = {}
    data.BaseData = BaseData
    BaseData.FriendId = msg.FriendId         -- 好友ID
    BaseData.Nickname = msg.Nickname         -- 昵称
    BaseData.Avatar = msg.Avatar             -- 看板娘（立绘）
    BaseData.PlayerIconId = msg.PlayerIconId -- 头像
    BaseData.Level = msg.Level               -- 等级
    BaseData.Online = msg.Online             -- 在线状态
    BaseData.LogoutTime = msg.LogoutTime     -- 离线时间
    local DetailData = {}
    data.DetailData = DetailData
    DetailData.MissionId = msg.MissionId
    DetailData.EliteId = msg.DetailData
    DetailData.HeroList = msg.HeroList
    DetailData.Achievements = msg.Achievements
    DetailData.AchievementsFinishedCount = msg.AchievementsFinishedCount
    UIContextMgr:GetInstance():Show("FriendInfo", data, -1)
end

-- 助战次数信息 Ack
function M:_ResponseHelpTimesInfoCallback(messagId, result, msg)
    -- Logger.LogError("请求助战次数Ack")
    NetPack:UnRegistResponse(MessageId.ResponseHelpTimesInfo, self._TempResponseHelpTimesInfoCallback)
    self._TempResponseHelpTimesInfoCallback = nil
    if result ~= 0 then
        Logger.LogError("错误：" .. tostring(result))
        return
    end
    self.HelpTimesData = msg.Data
    self:ReturnHelpNum()
end

function M:_NotifyHelpTimesChange(messagId, result, msg)
    self.HelpTimesData = msg.Data
end

-- function M:OnDispose()
--     NetPack:UnRegistResponse(MessageId.NotifyHelpTimesChange, self._TempNotifyHelpTimesChange)
--     M.super.OnDispose(self)
-- end
------------------------------------End-------------------------------------------
return M
