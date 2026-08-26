-- chunkname: @modules/logic/autochess/main/flow/AutoChessEffectWork.lua

module("modules.logic.autochess.main.flow.AutoChessEffectWork", package.seeall)

local AutoChessEffectWork = class("AutoChessEffectWork", BaseWork)

function AutoChessEffectWork:ctor(effect)
	self.effect = effect
	self.mgr = AutoChessEntityMgr.instance
	self.chessMo = AutoChessModel.instance:getChessMo()

	if self.effect.effectType == AutoChessEnum.EffectType.NextFightStep then
		logError("异常:NextFightStep类型的数据不该出现在这里")
	end
end

function AutoChessEffectWork:markSkillEffect(fromUid, effectId)
	self.skillFromUid = fromUid
	self.skillEffectId = effectId
end

function AutoChessEffectWork:onStart(context)
	local handleFunc = AutoChessEffectHandleFunc.instance:getHandleFunc(self.effect.effectType)

	if handleFunc then
		handleFunc(self)
	else
		logError(string.format("警告:跳过EffectType : %s", self.effect.effectType))
		self:finishWork()
	end
end

function AutoChessEffectWork:onStop()
	if self.damageWork then
		self.damageWork:onStopInternal()
	elseif self.combineWork then
		self.combineWork:onStopInternal()
	elseif self.effect and self.effect.effectType == AutoChessEnum.EffectType.LeaderHpFloat then
		TaskDispatcher.cancelTask(self.delayAttack, self)
		TaskDispatcher.cancelTask(self.delayFloatLeader, self)
	end

	TaskDispatcher.cancelTask(self.finishWork, self)
end

function AutoChessEffectWork:onResume()
	if self.damageWork then
		self.damageWork:onResumeInternal()
	elseif self.combineWork then
		self.combineWork:onResumeInternal()
	else
		self:finishWork()
	end
end

function AutoChessEffectWork:clearWork()
	if self.damageWork then
		self.damageWork:unregisterDoneListener(self.finishWork, self)

		self.damageWork = nil
	elseif self.combineWork then
		self.combineWork:unregisterDoneListener(self.finishWork, self)

		self.combineWork = nil
	end

	self.effect = nil
	self.mgr = nil
	self.chessMo = nil
	self.skillEffectId = nil
end

function AutoChessEffectWork:finishWork()
	if self.effect.effectType == AutoChessEnum.EffectType.ChessDie then
		AutoChessEntityMgr.instance:removeEntity(self.effect.targetId)
	end

	self:onDone(true)
end

function AutoChessEffectWork:delayAttack()
	local attackLeader = self.mgr:getLeaderEntity(self.effect.fromId)
	local hurtLeader = self.mgr:getLeaderEntity(self.effect.targetId)

	TaskDispatcher.runDelay(self.delayFloatLeader, self, (attackLeader and hurtLeader or nil) and attackLeader:ranged(hurtLeader.transform.position, 20002))
end

function AutoChessEffectWork:delayFloatLeader()
	local hurtLeader = self.mgr:getLeaderEntity(self.effect.targetId)

	if hurtLeader then
		hurtLeader:floatHp(self.effect.effectNum)
		TaskDispatcher.runDelay(self.finishWork, self, 1)
	else
		self:finishWork()
	end
end

return AutoChessEffectWork
