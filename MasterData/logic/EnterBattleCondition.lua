-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/EnterBattleCondition.lua

module("logic.extensions.mission.view.EnterBattleCondition", package.seeall)

local EnterBattleCondition = class("EnterBattleCondition")

function EnterBattleCondition:ctor()
	self._id = 0
	self._isPass = false
end

function EnterBattleCondition:init(id)
	self._id = id

	self:_judgeCondition()
end

function EnterBattleCondition:isCanPass()
	return self._isPass
end

function EnterBattleCondition:_judgeCondition()
	self._isPass = false

	if self._id == 1 then
		local challengeId = ChallengeModel.instance:getCurId()
		local cfg = ChallengeConfig.instance:getChallengeCfg(challengeId)

		if not cfg then
			self._isPass = true

			return
		end

		local param = cfg.extParams
		local curPhase = ChallengeModel.instance:getCurPhase()

		if not curPhase then
			self._isPass = true

			return
		end

		local isJudgeNum = false

		for i = 1, #param.phase do
			if param.phase[i] == curPhase then
				isJudgeNum = true

				break
			end
		end

		if isJudgeNum then
			local curPetNum = FormationFacade.instance:curFormationPetNum()

			self._isPass = curPetNum >= param.petNum
		else
			self._isPass = true
		end

		if not self._isPass then
			local tips = string.format("上阵精灵不足%d只,无法开启挑战", checknumber(param.petNum))

			ViewMgr.instance:open(ViewName.SceneUnlockView, tips)
		end
	end
end

return EnterBattleCondition
