-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessLeaderHpFloatWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessLeaderHpFloatWork", package.seeall)

local AutoChessLeaderHpFloatWork = class("AutoChessLeaderHpFloatWork", AutoChessBaseWork)

function AutoChessLeaderHpFloatWork:onStart()
	if self.effect.fromId == self.effect.targetId then
		self:floatHp()
	else
		local attackLeader = self.entityMgr:getLeaderEntity(self.effect.fromId)

		if attackLeader then
			self.entityMgr:flyStarByTeam(attackLeader.mo.teamType)
			self:delayCall(self.attack, 1.1)
		else
			self:attack()
		end
	end
end

function AutoChessLeaderHpFloatWork:attack()
	self:delDelayFunc(self.attack)

	local attackLeader = self.entityMgr:getLeaderEntity(self.effect.fromId)
	local hurtLeader = self.entityMgr:getLeaderEntity(self.effect.targetId)

	self:delayCall(self.floatHp, (attackLeader and hurtLeader or nil) and attackLeader:ranged(hurtLeader.transform.position, AutoChessEnum.Tag2EffectId.Ranged))
end

function AutoChessLeaderHpFloatWork:floatHp()
	self:delDelayFunc(self.floatHp)

	local hurtLeader = self.entityMgr:getLeaderEntity(self.effect.targetId)

	if hurtLeader then
		hurtLeader:floatHp(self.effect.effectNum)
		self:delayCall(self.finishWork, 1)
	else
		self:finishWork()
	end
end

return AutoChessLeaderHpFloatWork
