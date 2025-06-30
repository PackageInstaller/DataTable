
---@class Bossraid : Entity
---@field record BossraidBattleRecord
---@field leaderboard BossraidLeaderboardRecord[]
---@field totalScore number
local Bossraid = BaseClass("Bossraid",Entity)
local base = Entity
local this = Bossraid

---@param bossraidInfo protocol.BossraidInfo
function this:Awake(bossraidInfo)
    base.Awake(self)
    local bossraid = bossraidInfo
    self.leaderboard = {}
    self.minLeaderRank = 0
    self.maxLeaderRank = 0

    self.bossraidId = bossraid.bossraid_id
	self.receivedReward = bossraid.received_reward
    self.record = Game.Registry:NewObject("BossraidBattleRecord", bossraid.record)
    self.levelStatus = {}
    if bossraid.level_status ~= nil then
        for _, value in ipairs(bossraid.level_status) do
            self.levelStatus[value.level_id] = {
                levelId = value.level_id,
                passed = value.passed,
                highestScore = value.highest_score,
            }
        end
    end
    self.rank = bossraid.rank
    self.config = Z_Bossraid[self.bossraidId]
    self.totalScore = bossraid.total_score
    self.oldScore = self.totalScore
    self.remainBattle = {}
    if bossraid.remain_battle ~= nil then
        self.remainBattle.levelId = bossraid.remain_battle.level_id
        self.remainBattle.usedRoles = bossraid.remain_battle.used_role
        self.remainBattle.isUsedSupport = bossraid.remain_battle.used_support
        self.remainBattle.isSimulate = bossraid.remain_battle.is_simulate
        self.remainBattle.battleStartTime = bossraid.remain_battle.battle_start_time
        self.remainBattle.mosters = {}
        if bossraid.remain_battle.monsters ~= nil then
            for index, monster in ipairs(bossraid.remain_battle.monsters) do
                table.insert(self.remainBattle.mosters, {
                    monsterId = monster.id,
                    batch = monster.batch, -- 批次
                    position = monster.position, -- 位置
                    remainHp = monster.remain_hp, -- 剩余血量
                })
            end
        end
    end
end

---@param bossraidInfo protocol.BossraidInfo
function this:UpdateData(bossraidInfo)
    local bossraid = bossraidInfo
    self.bossraidId = bossraid.bossraid_id
	self.receivedReward = bossraid.received_reward
    self.record = Game.Registry:NewObject("BossraidBattleRecord", bossraid.record)
    self.levelStatus = {}
    if bossraid.level_status ~= nil then
        for _, value in ipairs(bossraid.level_status) do
            self.levelStatus[value.level_id] = {
                levelId = value.level_id,
                passed = value.passed,
                highestScore = value.highest_score,
            }
        end
    end
    self.rank = bossraid.rank
    if self.oldScore == self.totalScore then
        self.oldScore = self.totalScore
    end
    self.totalScore = bossraid.total_score
    self.config = Z_Bossraid[self.bossraidId]
    self.remainBattle = {}
    if bossraid.remain_battle ~= nil then
        self.remainBattle.levelId = bossraid.remain_battle.level_id
        self.remainBattle.usedRoles = bossraid.remain_battle.used_role
        self.remainBattle.isUsedSupport = bossraid.remain_battle.used_support
        self.remainBattle.isSimulate = bossraid.remain_battle.is_simulate
        self.remainBattle.battleStartTime = bossraid.remain_battle.battle_start_time
        self.remainBattle.mosters = {}
        if bossraid.remain_battle.monsters ~= nil then
            for index, monster in ipairs(bossraid.remain_battle.monsters) do
                table.insert(self.remainBattle.mosters, {
                    monsterId = monster.id,
                    batch = monster.batch, -- 批次
                    position = monster.position, -- 位置
                    remainHp = monster.remain_hp, -- 剩余血量
                })
            end
        end
    end
end

---@param leader protocol.BossraidLeaderboardRecord
function this:SetLeader(leader)
    if self.leaderboard[leader.rank] == nil then
        self.leaderboard[leader.rank] = Game.Registry:NewObject("BossraidLeaderboardRecord", leader)
        if self.minLeaderRank == 0 or self.minLeaderRank > leader.rank then
            self.minLeaderRank = leader.rank
        end
        if self.maxLeaderRank == 0 or self.maxLeaderRank < leader.rank then
            self.maxLeaderRank = leader.rank
        end
    else
        self.leaderboard[leader.rank]:UpdateData(leader)
    end
end

function this:ClearLeader()
    self.leaderboard = {}
    self.minLeaderRank = 0
    self.maxLeaderRank = 0
end

function this.Dispose(self)
    base.Dispose(self)
end



return this