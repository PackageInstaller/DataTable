-- chunkname: @IQIGame\\Module\\MainCity\\BattleOverCommandData.lua

BattleOverCommandData = {}

function BattleOverCommandData.New()
	local o = Clone(BattleOverCommandData)

	return o
end

function BattleOverCommandData:Initialize(battleOverCommand)
	self.HolderID = battleOverCommand.HolderID
	self.FightID = battleOverCommand.FightID
	self.Attacker = battleOverCommand.Attacker
	self.Defender = battleOverCommand.Defender
	self.FightResult = battleOverCommand.FightResult
	self.Round = battleOverCommand.Round
	self.BattleType = battleOverCommand.BattleType
	self.SkipBattle = battleOverCommand.SkipBattle
	self.DmgRecords = battleOverCommand.DmgRecords
	self.HealRecords = battleOverCommand.HealRecords
	self.HurtRecords = battleOverCommand.HurtRecords
	self.UserData = battleOverCommand.UserData
	self.JsonOrder = battleOverCommand.JsonOrder
end

return BattleOverCommandData
