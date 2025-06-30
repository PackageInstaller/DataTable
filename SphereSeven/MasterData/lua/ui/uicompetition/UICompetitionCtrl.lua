
--
-- <代码文件解释说明>
--
local ARENA_LEADERBOARD = tonumber(Z_Misc["ARENA_LEADERBOARD"].Value[1]) -- 竞技场可显示排行榜的大小
local ARENA_LEADERBOARD_PAGE = tonumber(Z_Misc["ARENA_LEADERBOARD_PAGE"].Value[1]) -- 排行榜分页大小

---@class UICompetitionCtrl
---@field model UICompetitionModel
local UICompetitionCtrl = BaseClass("UICompetitionCtrl",UIBaseCtrl)
local this = UICompetitionCtrl

function this:RefreshArenaChallenger()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    competitionComponent:RefreshChallengerRequest()
end

--- 获取对手
---@return ArenaChallenger[]
function this:GetArenaChallenger(isRefresh)
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")

    if isRefresh and table.count(competitionComponent:GetChallenger()) == 0 then
        -- self:RefreshArenaChallenger()
        return {}
    else
        return competitionComponent:GetChallenger()
    end
end

--- 获取历史记录
---@return ArenaRecord[]
function this:GetArenaRecord()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    return competitionComponent:GetArenaRecord()
end

--- 请求排行榜数据
function this:RequestLeaderboard(leaderboardPage)
    if leaderboardPage > ARENA_LEADERBOARD / ARENA_LEADERBOARD_PAGE then
        return
    end

    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    competitionComponent:RequestLeaderboard(leaderboardPage, function()
        self.model:RefreshLeaderboard(leaderboardPage)
    end)
end

--- 获取排行榜数据
---@return ArenaChallenger[]
function this:GetLeaderboard(leaderboardPage)
    if leaderboardPage > ARENA_LEADERBOARD / ARENA_LEADERBOARD_PAGE then
        leaderboardPage = ARENA_LEADERBOARD / ARENA_LEADERBOARD_PAGE
    end

    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    return competitionComponent:GetLeaderboard(leaderboardPage)
end

--- 获取奖励列表
function this:GetDivisionReward()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    local season = competitionComponent.info.season
    local zSeason = Z_ArenaSeasonConfig[season]
    local zDivisions = Z_ArenaSeasonReward[zSeason.Reward]
    return zDivisions
end

function this:ChallengeReq(pos)
    PublicRequest.SendRequest(
        PROTOCOL.ArenaChallengeReq,
        {
            pos = pos
        },
        nil
    )
end

return this
