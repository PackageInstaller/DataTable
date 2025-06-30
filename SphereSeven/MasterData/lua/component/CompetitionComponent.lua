---
--争霸功能
---
---@class CompetitionComponent
---@field info ArenaInfo
---@field challengers ArenaChallenger[] @ (当前刷新出来的) 竞技场对手
---@field records ArenaRecord[] @ 历史对战记录
---@field rankList table<number, ArenaChallenger[]> @ 排行榜
---@field oldScore number @ 记录上次的分数( 每次update时 记录一下更新之前的数据 )
local CompetitionComponent = BaseClass("CompetitionComponent", Component)
local base = Component

function CompetitionComponent:Awake()
    base.Awake(self)
    self.info = nil
    self.CpPlayerInfos = nil
    self.RankingsPlayerInfos = nil
    self.ChooseId = 1
    self.CompetitionInfoUpdateTime = 0
    self.RankingsInfoUpdateTime = 0

    self.initData = false
    self.challengers = {}
    self.records = {}
    self.rankList = {}

    self.oldScore = 0
end

function CompetitionComponent:CoLoadData()
    ---@type protocol.ArenaHistoryResp
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            PROTOCOL.ArenaHistoryReq, {})
    -- 这里只有history 但是跟arenaInfo存放在一起, 所以直接在下面创建一个arenaInfo对象了.
    self:CreateOrUpdateArenaInfo(info)
    return coroutine.yieldbreak(info)
end

---@param arenaInfo protocol.ArenaInfo
function CompetitionComponent:CreateOrUpdateArenaInfo(arenaInfo)
    if self.info == nil then
        self.info = Game.Registry:NewObject("ArenaInfo", arenaInfo)
        self.oldScore = self.info.score -- 创建时直接记录一下分数
    else
        -- 因为可能会在CoLoadData中调用, 所以不能在这里直接赋值oldScore
        self.info:UpdateData(arenaInfo)
    end 
    if arenaInfo.records ~= nil then
        self:RefreshArenaRecord(arenaInfo.records)
    end
end

--获取本赛季争霸信息
function CompetitionComponent:OpenCompetitionUI()
        local callback = function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UICompetition)
        end
    
        if self.initData then
            callback()
        else
            local isOpen, errorMsg = UIPublic.CheckUIOpen(UIWindowNames.UICompetition)
            if not isOpen then
                UIUtil.ToolTipFourth(errorMsg)
                return
            end

            ---@param response protocol.ArenaInfoResp
            PublicRequest.SendRequest(
                PROTOCOL.ArenaInfoReq,
                {},
                function(response, error)
                    if error == 21001 then
                        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1355))
                        return
                    end
                    self:CreateOrUpdateArenaInfo(response.info)
                    callback()
                end,
                function(error)
                    if error == 21001 then
                        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1355))
                    end
                end
            )
        end

end

function CompetitionComponent:GetArenaInfo()
    return self.info
end

--- 获取竞技场对手
---@return ArenaChallenger[] | nil
function CompetitionComponent:GetChallenger()
    table.sort(self.challengers, function(a, b)
        return a.role.rank < b.role.rank
    end)
    return self.challengers
end

function CompetitionComponent:RefreshChallengerRequest()
PublicRequest.SendRequest(
        PROTOCOL.ArenaRefreshChallengerReq,
        {},
        function(response, error)
            if error == 0 then
                self:RefreshChallenger(response)
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_CHALLENGER_UPDATE)
            end
        end
    )
end

--- 刷新竞技场对手
---@param data protocol.ArenaRefreshChallengerResp
function CompetitionComponent:RefreshChallenger(data)
    self.challengers = {}
    for index, challenger in ipairs(data.challengers) do
        self.challengers[index] = Game.Registry:NewObject("ArenaChallenger", {
            arenaChallenger = challenger,
            index = index
        })
    end
end

--- 获取历史对战记录
---@return ArenaRecord[]
function CompetitionComponent:GetArenaRecord()
    return self.records
end

--- 刷新历史对战记录
---@param data protocol.ArenaRecord[]
function CompetitionComponent:RefreshArenaRecord(data)
    self.records = {}
    for _, record in ipairs(data) do
        table.insert(
            self.records,
            1,
            Game.Registry:NewObject("ArenaRecord", record)
        )
    end
end

function CompetitionComponent:RequestLeaderboard(leaderboardPage, callback)
    ---@param response protocol.ArenaGetLeaderboardResp
    PublicRequest.SendRequest(
        PROTOCOL.ArenaGetLeaderboardReq,
        {page = leaderboardPage},
        function(response, error)
            if error == ErrorCode.ErrorCodeArenaLeaderboaredLimit then
                if callback ~= nil then
                    callback()
                end
            else
                self:RefreshLeaderboard(leaderboardPage, response.challengers)
                if callback ~= nil then
                    callback()
                end
            end
        end
    )
end

---@param challengers protocol.ArenaChallenger[]
function CompetitionComponent:RefreshLeaderboard(leaderboardPage, challengers)
    if self.rankList[leaderboardPage] == nil then
        self.rankList[leaderboardPage] = {}
    end
    for _, challenger in pairs(challengers) do
        if self.rankList[leaderboardPage][challenger.role.role_id] == nil then
            self.rankList[leaderboardPage][challenger.role.role_id] = Game.Registry:NewObject("ArenaChallenger", {
                arenaChallenger = challenger,
                index = challenger.role.rank
            })
        else
            self.rankList[leaderboardPage][challenger.role.role_id]:UpdateData(challenger)
        end
    end
end

---@return ArenaChallenger[]
function CompetitionComponent:GetLeaderboard(leaderboardPage)
    local ret = {}
    for i = 0, leaderboardPage do
        if self.rankList[i] ~= nil then
            for _, value in pairs(self.rankList[i]) do
                table.insert(ret, value)
            end
        end
    end

     table.sort(ret, function(a, b)
        return a.role.rank < b.role.rank
    end)
    return ret
end


-------------------------------------------------------------------------------------------------------------------

--匹配对手
function CompetitionComponent.MatchingPlayers(self, IsExpendPoint, callback)

    local reqData = {}
    reqData.ActorId = 2
    reqData.IsExpendPoint = 0 --是否花费次数刷新匹配对手  0不刷新 1刷新
    if IsExpendPoint then
        reqData.IsExpendPoint = 1
    end
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2PM_MatchingPlayers, reqData) -- , { loadMsg = LangUtil.GetSysLang(3066), loadMode = LoadMode.Cat }
    if info.Error == ErrorCode.ERR_Success then
        self.CpPlayerInfos = info.CpPlayerInfos
        --local data =  info.CpPlayerInfos[1]
        --data.PlayerId id
        --data.Lv     等级
        --data.Name;  名字
        --data.Avatar;  头像
        --data.BattleNum;本季战斗次数
        --data.WinNum;  本季胜利次数
        --data.CompetitionNum;  每天可以战斗的次数
        --data.Ranking   排名 为0的话就是榜外
        --data.Captain   本季段位
        --data.HistoryCaptain   历史最高段位
        --data.RewardList 本季已领取段位奖励
        --data.HistoryRewardList 历史已领取段位领取
        --data.MatchingNum 手动刷新对手的次数  0点更新为0
        --data.TeamInfo     参战队信息 如果没有直接胜利
        --data.CardList   所用到的卡
        --data.EquipList
        --data.FightSoulList
        --data.MainCardTId 助手类型ID
        --data.MainSkinTId 助手皮肤类型ID
        if callback ~= nil then
            callback()
        end
    else
        print(info.message)
    end

end

local function RequestRankingsInfo(self, start, num, callback)

    --Logger.LogError("获取排行榜")
    local reqData = {}
    reqData.Start = start
    reqData.Num = num
    reqData.ActorId = 2
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2PM_RankingsPlayers, reqData) -- , { loadMsg = LangUtil.GetSysLang(3066), loadMode = LoadMode.Cat }
    if info.Error == ErrorCode.ERR_Success then
        self.RankingsPlayerInfos = info.CpPlayerInfos
        --data.PlayerId id
        --data.Lv     等级
        --data.Name;  名字
        --data.Avatar;  头像
        --data.BattleNum;本季战斗次数
        --data.WinNum;  本季胜利次数
        --data.CompetitionNum;  每天可以战斗的次数
        --data.Ranking   排名 为0的话就是榜外
        --data.Captain   本季段位
        --data.HistoryCaptain   历史最高段位
        --data.RewardList 本季已领取段位奖励
        --data.HistoryRewardList 历史已领取段位领取
        --data.MatchingNum 手动刷新对手的次数  0点更新为0
        --data.TeamInfo     参战队信息
        --data.CardList    所用到的卡
        --data.EquipList
        --data.FightSoulList
        --data.MainCardTId 助手类型ID
        --data.MainSkinTId 助手皮肤类型ID
        if callback ~= nil then
            callback()
        end
    else
        print(info.message)
    end

end

--获取排行榜
function CompetitionComponent.RankingsPlayers(self, start, num, callback)
    if self.RankingsInfoUpdateTime ~= 0 and (Time.time - self.RankingsInfoUpdateTime > 10) then
        self.RankingsInfoUpdateTime = Time.time
        RequestRankingsInfo(self, start, num, callback)
    elseif self.RankingsInfoUpdateTime == 0 then
        self.RankingsInfoUpdateTime = Time.time
        RequestRankingsInfo(self, start, num, callback)
    else
        if callback ~= nil then
            callback()
        end
    end
end
-- 购买重置争霸每日可战斗次数  是否使用物品
function CompetitionComponent.BugNum(self, isItem, expendStarStone, callback)
    local player = Game.Scene.Player
    local reqData = {}
    reqData.ActorId = 2
    reqData.ExpendPaidStarStone = 0
    reqData.ExpendFreeStarStone = 0
    reqData.ExpendMaterialList = {}
    local item = table.first(player:GetComponent("ItemComponent").Items, function(v)
        return v.TemplateId == 3014
    end)
    local func = function()
        local Material = {}
        Material.MaterialId = item.Id
        Material.Amount = 1
        Material.MaterialType = 0
        table.insert(reqData.ExpendMaterialList, Material)
        coroutine.start(function()
            local response = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                    OuterOpcode.Name2Code.ETModel_C2PM_CompetitionAddNum, reqData)
            if response.Error == ErrorCode.ERR_Success then
                player.FreeStarStone = player.FreeStarStone - reqData.ExpendFreeStarStone
                player.PaidStarStone = player.PaidStarStone - reqData.ExpendPaidStarStone
                self.info.cplayer.CompetitionNum = 0
                self.info.cplayer.BuyCount = self.info.cplayer.BuyCount + 1
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
                for k, v in pairs(reqData.ExpendMaterialList) do
                    UIUtil.RemoveItem(v.MaterialId, v.Amount)
                end
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(863));
                if callback ~= nil then
                    callback()
                end
            end
        end)
    end
    if isItem then
        --使用物品

        if item ~= nil and item.Amount>0 then
            local tipData = {}
            tipData.title = LangUtil.GetSysLang(9)
            tipData.type = 5
            tipData.startType = 1
            tipData.message = LangUtil.GetSysLang(1097)
            tipData.Amount = item.Amount
            tipData.TemplateId = 3014
            --tipData.ExpenseNum = 1 --需要消耗一张
            --tipData.Amount = item.Amount
            tipData.But2 = function()
                func()
            end
            UIUtil.ToolTipFirstPlus(tipData)
        else
            local tipData = {}
            tipData.title = LangUtil.GetSysLang(9)
            tipData.type = 5
            tipData.startType = 2
            tipData.message = LangUtil.GetSysLang(1095)
            tipData.Amount = 0
            tipData.TemplateId = 3014
            --tipData.ExpenseNum = 1 --需要消耗一张
            --tipData.Amount = item.Amount
            tipData.But2 = function()
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIGeneralShop)
            end

            UIUtil.ToolTipFirstPlus(tipData)
        end

    else
        --使用星石
        local surplusStarStone = player.FreeStarStone - expendStarStone
        if surplusStarStone < 0 then
            reqData.ExpendPaidStarStone = -surplusStarStone
            reqData.ExpendFreeStarStone = player.FreeStarStone
        else
            reqData.ExpendPaidStarStone = 0
            reqData.ExpendFreeStarStone = expendStarStone
        end

        --if player.PaidStarStone < reqData.ExpendPaidStarStone then
        --    local tipData = {}
        --    tipData.title = LangUtil.GetSysLang(9)--"提示"
        --    tipData.message = LangUtil.GetSysLang(546)--"星石不足,是否前往充值"
        --    tipData.callBack = function()
        --        UIUtil.ToolTipFourth(LangUtil.GetSysLang(541))
        --    end
        --    UIUtil.ToolTipFirst(tipData)
        --    return
        --end
    end
    
end
-- 领取段位奖励
function CompetitionComponent.GetReward(self, isHistory, Captain, callback)
    local history = 0
    if isHistory then
        history = 1
    end
    local reqData = {}
    reqData.IsHistory = history
    reqData.Captain = Captain
    reqData.ActorId = 2
    local response = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2PM_CompetitionOver, reqData)
    if response.Error == ErrorCode.ERR_Success then
        --RewardInfoList  当段位升级时返回奖励物品信息
        --Captain   当前段位
        if callback ~= nil then
            callback(response.RewardInfoList)
        end
        --UIUtil.UpdateRewardInfoList(response.RewardInfoList,true)
    end

end

--获取对战玩家的数据
function CompetitionComponent.GetChoosePlayerInfo(self)
    return self.CpPlayerInfos[self.ChooseId]
end
--计算战斗力公式
function CompetitionComponent.GetCombat(self, playerInfo)
    local c = 0
    if playerInfo.TeamInfo == nil then -- 没有队伍
        return c
    end
    --计算队伍里每个单位
    local teamDetailList = playerInfo.TeamInfo.TeamDetailInfoList
    table.walk(teamDetailList, function(_, teamDetail)
        local cardInfo
        if playerInfo.PlayerId == Game.Scene.Player.Id then
            --自己的组件里找
            local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
            cardInfo = cardComponent:Get(teamDetail.CardId)
        else
            --其他的在信息里找

            cardInfo = table.first(playerInfo.CardList, function(v)
                return v.CardId == teamDetail.CardId
            end)
        end
        if cardInfo == nil then
            Logger.LogError("--争霸数据异常，角色集合里面不包含队伍角色ID")
            return
        end
        local zcard = Z_Card[cardInfo.TemplateId]

        local rr = { 100, 100, 200, 300, 400 }
        local uc = rr[zcard.Rare] -- 稀有度 
        local sc = uc
        sc = sc + uc * 0.01 * cardInfo.Level -- 卡片等级 * 0.01
        sc = sc + uc * 0.02 * cardInfo.JadePearlLevel -- 玉珠等级 * 0.02
        local cd = cardInfo.CloseDegree
        if cd > 100 then
            cd = 100
        end
        sc = sc + uc * 0.0001 * cd -- 亲密度 * 0.0001
        ----------------------------------------------------------------------------------------------------
        local elist = { "Hand1Equip", "Hand2Equip", "BodyEquip", "HeadEquip", "FootEquip", "AdornEquip" }
        table.walk(elist, function(_, v)
            local eqId = cardInfo[v]
            if eqId ~= 0 then
                local eqInfo
                if table.count(playerInfo.EquipList) == 0 then
                    --自己的装备在组件里找
                    local equipComponent = Game.Scene.Player:GetComponent("EquipComponent")
                    eqInfo = equipComponent:Get(eqId)
                else
                    --其他的在信息里找
                    eqInfo = table.first(playerInfo.EquipList, function(v)
                        return v.EquipId == eqId
                    end)
                end
                if eqInfo ~= nil then
                    --计算装备战力
                    local zeq = Z_Equip[eqInfo.TemplateId]
                    local eqc = 0
                    if zeq.Exclusive == 0 then
                        local eqrr = { 10, 20, 40, 60, 80 }
                        eqc = eqrr[eqInfo.Star]
                        eqc = eqc + eqc * 0.01 * eqInfo.Level -- 装备战斗力 * 0.01
                    else
                        eqc = 100
                        eqc = eqc + eqc * 0.01 * eqInfo.Star -- 装备星级 * 0.01
                    end
                    sc = sc + eqc
                end
            end
        end)
        --------------------------------------------------------------------------------------------------------
        local flist = { "FightSoul1", "FightSoul2", "FightSoul3" }
        table.walk(flist, function(_, v)
            local fId = cardInfo[v]
            if fId ~= 0 then
                local fInfo
                if table.count(playerInfo.FightSoulList) == 0 then
                    --自己的装备在组件里找
                    local fightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")
                    fInfo = fightSoulComponent:Get(fId)
                else
                    --其他的在信息里找
                    fInfo = table.first(playerInfo.FightSoulList, function(v)
                        return v.FightSoulId == fId
                    end)
                end
                if fInfo ~= nil then
                    --计算战魂战力
                    local zf = Z_FightSoul[fInfo.TemplateId]
                    local fcf = { 0, 20, 40, 60, 80 }
                    local fc = fcf[zf.Rare]
                    fc = fc + fc * 0.01 * (fInfo.Star - 1) -- 战魂类型 * 0.1
                    sc = sc + fc
                end
            end
        end)
        --------------------------------------------------------------------------------------------------------
        c = c + sc
    end)
    --------------------------------------------------------------------------
    return math.modf(c)
end

function CompetitionComponent.BattleStart(self, id)
    local against_component = Game.Scene:GetComponent("AgainstComponent")
    against_component.LevelType = LevelType.LevelTypeArena
    self.ChooseId = id
    Game.Scene.SceneComponent:SwitchScene(SceneConfig.BattleScene)
end

function CompetitionComponent.Dispose(self)
    base.Dispose(self)
end

return CompetitionComponent