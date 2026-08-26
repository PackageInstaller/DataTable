-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessStepMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessStepMO", package.seeall)

local WarChessStepMO = class("WarChessStepMO")

function WarChessStepMO:init(info)
	self.actionType = info.actionType
	self.reasonId = info.reasonId
	self.fromId = info.fromId
	self.toId = info.toId

	if info.effect then
		self.effect = GameUtil.rpcInfosToList(info.effect, WarChessEffectMO)
	end
end

local effectData = {}

function WarChessStepMO:buildSteps()
	local steps = {}
	local parallelStepFlow = FlowParallel.New()
	local growUpParallelStepFlow = FlowParallel.New()

	if self.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
		local skillConfig = EliminateConfig.instance:getSoliderSkillConfig(self.reasonId)

		if not string.nilorempty(skillConfig.type) then
			tabletool.clear(effectData)

			effectData.uid = self.fromId
			effectData.effectType = EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect

			if skillConfig.type == EliminateTeamChessEnum.SoliderSkillType.Die then
				effectData.vxEffectType = EliminateTeamChessEnum.VxEffectType.WangYu
				effectData.time = EliminateTeamChessEnum.VxEffectTypePlayTime[effectData.vxEffectType]
			end

			if skillConfig.type == EliminateTeamChessEnum.SoliderSkillType.Raw or skillConfig.type == EliminateTeamChessEnum.SoliderSkillType.GrowUp then
				effectData.vxEffectType = EliminateTeamChessEnum.VxEffectType.ZhanHou
				effectData.time = EliminateTeamChessEnum.VxEffectTypePlayTime[effectData.vxEffectType]
			end

			local reasonId = self.reasonId

			if reasonId ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(reasonId)) then
				effectData.time = EliminateTeamChessEnum.teamChessGrowUpZhanHouStepTime
			end

			steps[#steps + 1] = EliminateTeamChessStepUtil.createStep(effectData)
		end
	end

	local needAddUpdateForecast = true

	for i = 1, #self.effect do
		local effect = self.effect[i]

		if effect.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
			effect.needShowDamage = self.actionType == EliminateTeamChessEnum.StepActionType.chessSkill or self.actionType == EliminateTeamChessEnum.StepActionType.strongHoldSkill
		end

		if effect.effectType == EliminateTeamChessEnum.StepWorkType.placeChess then
			local chessPiece = effect.chessPiece

			if tonumber(chessPiece.uid) < 0 and needAddUpdateForecast then
				steps[#steps + 1] = EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessUpdateForecast)
				needAddUpdateForecast = false
			end
		end

		local effectSteps, nextSteps = effect:buildStep(self)

		if effect.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
			for _, _step in ipairs(effectSteps) do
				parallelStepFlow:addWork(_step)
			end

			if #effectSteps == #parallelStepFlow:getWorkList() then
				steps[#steps + 1] = parallelStepFlow
			end
		elseif effect.effectType == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
			for _, _step in ipairs(effectSteps) do
				growUpParallelStepFlow:addWork(_step)
			end

			if #effectSteps == #growUpParallelStepFlow:getWorkList() then
				steps[#steps + 1] = growUpParallelStepFlow
			end
		else
			for _, _step in ipairs(effectSteps) do
				steps[#steps + 1] = _step
			end
		end

		if nextSteps then
			for _, _step in ipairs(nextSteps) do
				steps[#steps + 1] = _step
			end
		end
	end

	return steps
end

return WarChessStepMO
