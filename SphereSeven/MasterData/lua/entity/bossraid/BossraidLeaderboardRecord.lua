
---@class BossraidLeaderboardRecord : Entity
---@field record BossraidBattleRecord
local BossraidLeaderboardRecord = BaseClass("BossraidLeaderboardRecord",Entity)
local base = Entity
local this = BossraidLeaderboardRecord

---@param leader protocol.BossraidLeaderboardRecord
function this:Awake(leader)
    base.Awake(self)
    self.role_id = leader.role_id
	self.username = leader.username
	self.level = leader.level
	self.portrait = leader.portrait
	self.rank = leader.rank
    self.record = Game.Registry:NewObject("BossraidBattleRecord", leader.record)
end

---@param leader protocol.BossraidLeaderboardRecord
function this:UpdateData(leader)
    self.role_id = leader.role_id
	self.username = leader.username
	self.level = leader.level
	self.portrait = leader.portrait
	self.rank = leader.rank
    self.record = Game.Registry:NewObject("BossraidBattleRecord", leader.record)
end

function this.Dispose(self)
    base.Dispose(self)
end

return this