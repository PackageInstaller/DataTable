---@class ArenaInfo : Entity
---@field rank number @ 排名
---@field score number @ 积分
---@field battle_season_count number @ 本赛季战斗次数
---@field battle_season_win_count number @ 本赛季胜利次数
---@field power number @ 体力
---@field refresh_time number @ 下次刷新体力时间，满体力为0
---@field season number @ 赛季
---@field division number @ 段位
---@field lastAutoBattle number @ 剩余自动战斗次数
local ArenaInfo = BaseClass("ArenaInfo",Entity)
local base = Entity
local this = ArenaInfo

---@param arenaInfo protocol.ArenaInfo
function this:Awake(arenaInfo)
    base.Awake(self)
    
    self.rank = arenaInfo.rank
	self.score = arenaInfo.score
	self.battle_season_count = arenaInfo.battle_season_count
	self.battle_season_win_count = arenaInfo.battle_season_win_count
    self.power = arenaInfo.power
    self.last_power_refresh_time = arenaInfo.last_power_refresh_time
    self.season = arenaInfo.season
    self.division = arenaInfo.division

    self.history = {}
    self.lastAutoBattle = arenaInfo.last_auto_battle

    if arenaInfo.history ~= nil then
        self.history.attackTotalCount = arenaInfo.history.attack_total_count -- 进攻总次数
        self.history.attackWinCount = arenaInfo.history.attack_win_count -- 进攻胜利次数
        self.history.defenceTotalCount = arenaInfo.history.defence_total_count -- 防守总次数
        self.history.defenceWinCount = arenaInfo.history.defence_win_count -- 防守胜利次数
        self.history.highestDivison = arenaInfo.history.highest_division -- 历史最高段位
        self.history.highestDivisonSeason = arenaInfo.history.highest_division_season -- 最高段位所处赛季
    end
end

---@param arenaInfo protocol.ArenaInfo
function this:UpdateData(arenaInfo)
    self.rank = arenaInfo.rank or self.rank
	self.score = arenaInfo.score or self.score
	self.battle_season_count = arenaInfo.battle_season_count or self.battle_season_count
	self.battle_season_win_count = arenaInfo.battle_season_win_count or self.battle_season_win_count
    self.power = arenaInfo.power or self.power
    self.last_power_refresh_time = arenaInfo.last_power_refresh_time or self.last_power_refresh_time
    self.season = arenaInfo.season or self.season
    self.division = arenaInfo.division or self.division
    self.lastAutoBattle = arenaInfo.last_auto_battle or self.lastAutoBattle

    if arenaInfo.history ~= nil then
        self.history.attackTotalCount = arenaInfo.history.attack_total_count
        self.history.attackWinCount = arenaInfo.history.attack_win_count
        self.history.defenceTotalCount = arenaInfo.history.defence_total_count
        self.history.defenceWinCount = arenaInfo.history.defence_win_count

        self.history.highestDivison = arenaInfo.history.highest_division
        self.history.highestDivisonSeason = arenaInfo.history.highest_division_season
    end
end

function this.Dispose(self)
    base.Dispose(self)
end



return this