-- chunkname: @modules/logic/autochess/main/flow/AutoChessSideWork.lua

module("modules.logic.autochess.main.flow.AutoChessSideWork", package.seeall)

local AutoChessSideWork = class("AutoChessSideWork", BaseWork)

function AutoChessSideWork:ctor(effectList)
	self.flowCnt = 1
	self.seqFlow = FlowSequence.New()

	self.seqFlow:registerDoneListener(self.onDone, self)

	self.effectList = effectList

	self:initSideWork()
end

function AutoChessSideWork:onStart(context)
	self.seqFlow:start(context)
end

function AutoChessSideWork:onStop()
	self.seqFlow:stop()
end

function AutoChessSideWork:onResume()
	self.seqFlow:resume()
end

function AutoChessSideWork:onReset()
	self.seqFlow:reset()
end

function AutoChessSideWork:onDestroy()
	self.seqFlow:unregisterDoneListener(self.onDone, self)

	self.seqFlow = nil
	self.effectList = nil
end

function AutoChessSideWork:initSideWork()
	for _, effect in ipairs(self.effectList) do
		if effect.effectType == AutoChessEnum.EffectType.NextFightStep then
			self:recursion(effect.nextFightStep)
		else
			local effectWork = AutoChessEffectWork.New(effect)

			self.seqFlow:addWork(effectWork)
		end
	end
end

function AutoChessSideWork:recursion(fightStep)
	if fightStep.actionType == AutoChessEnum.ActionType.ChessMove then
		local parFlow = FlowParallel.New()

		for _, effect in ipairs(fightStep.effect) do
			if effect.effectType == AutoChessEnum.EffectType.ChessMove then
				local effectWork = AutoChessEffectWork.New(effect)

				parFlow:addWork(effectWork)
			else
				logError("异常:棋子移动Action下面不该有其他类型Effect")
			end
		end

		self.seqFlow:addWork(parFlow)
	else
		local skillEffectParams

		if fightStep.actionType == AutoChessEnum.ActionType.ChessSkill then
			local skillWork = AutoChessSkillWork.New(fightStep)

			self.seqFlow:addWork(skillWork)

			local skillCo = lua_auto_chess_skill.configDict[tonumber(fightStep.reasonId)]

			if skillCo then
				local skillEffectStr = skillCo.skilleffID

				if not string.nilorempty(skillEffectStr) then
					skillEffectParams = string.splitToNumber(skillEffectStr, "#")
				end
			end
		end

		for _, effect in ipairs(fightStep.effect) do
			if effect.effectType == AutoChessEnum.EffectType.NextFightStep then
				self:recursion(effect.nextFightStep)
			else
				local effectWork = AutoChessEffectWork.New(effect)

				self.seqFlow:addWork(effectWork)

				if skillEffectParams and effect.effectType == skillEffectParams[2] then
					effectWork:markSkillEffect(fightStep.fromId, skillEffectParams[1])
				end
			end
		end
	end
end

return AutoChessSideWork
