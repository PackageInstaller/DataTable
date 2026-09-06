-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/controller/SixartdaoguanController.lua

module("logic.extensions.sixartdaoguan.controller.SixartdaoguanController", package.seeall)

local SixartdaoguanController = class("SixartdaoguanController", BaseController)

SixartdaoguanController.ChallengeType = {
	Writing = 4,
	Shooting = 2,
	Music = 1,
	Numbers = 5,
	Defense = 3
}

function SixartdaoguanController:ctor()
	return
end

function SixartdaoguanController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.SixArtDaoguanReShuffleDropBuffRes, self._onSixArtDaoguanReShuffleDropBuffRes, self)
end

function SixartdaoguanController:onReset()
	self._battleCount = 0
end

function SixartdaoguanController:notifyFightResultRes(msg)
	SixartdaoguanModel.instance:updateFightResultRes(msg)
end

function SixartdaoguanController:sendPM_SixArtDaoguanStartFightReq(activityId, challengeId, stageId, form)
	self._battleCount = 0
	self._currFightChallengeId = challengeId

	SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanStartFightReq(activityId, challengeId, stageId, form)
end

function SixartdaoguanController:onStartFightRes()
	BattleFacade.instance:registerResultHandler(self._onBattleResult, self)
end

function SixartdaoguanController:_onBattleResult()
	local result = SixartdaoguanModel.instance:getBattleResultMsg()

	if not result then
		return false
	end

	if self._currFightChallengeId == SixartdaoguanController.ChallengeType.Music then
		UIStateManager.instance:push(ViewName.SixartdaoguanmusicendView)

		return true
	elseif self._currFightChallengeId == SixartdaoguanController.ChallengeType.Writing then
		UIStateManager.instance:push(ViewName.SixartdaoguanwriteendView)

		return true
	elseif self._currFightChallengeId == SixartdaoguanController.ChallengeType.Numbers then
		local stageCfg = SixartdaoguanConfig.instance:getStageCfg(result.activityId, result.challengeId, result.stageId)

		if not result.activeRaceIds then
			local arr1 = string.split(stageCfg.activePetValidator, "|")
			local elementList = {}

			for i, v in ipairs(arr1) do
				local arr2 = string.split(v, "$")

				elementList[arr2[2]] = 0
			end

			local fmtMo = SixartdaoguanModel.instance:getFmtMo(self._currFightChallengeId)
			local formationMo = fmtMo and fmtMo:getCurFormation()
			local hasChangeTypeRaceId = {}

			if fmtMo and formationMo then
				local changeRaceTypes = formationMo:GetChangeRaceTypes() or {}

				for i, v in pairs(changeRaceTypes) do
					local petMo = fmtMo:getPetMoById(v.petId)

					for _, raceId in ipairs(result.activeRaceIds) do
						if petMo.raceId == raceId and elementList[v.raceType] then
							hasChangeTypeRaceId[raceId] = true
							elementList[v.raceType] = elementList[v.raceType] + 1

							break
						end
					end
				end
			end

			for i, raceId in ipairs(result.activeRaceIds) do
				if not hasChangeTypeRaceId[raceId] then
					local list = PetSkinConfig.instance:getAllElementAttrs(raceId)

					for _, v in ipairs(list) do
						if elementList[v] then
							elementList[v] = elementList[v] + 1

							break
						end
					end
				end
			end

			local count = 0

			for k, v in pairs(elementList) do
				count = count + v
			end

			local isRead = count == stageCfg.activeNum

			BattleSettlementController.instance:addConditionElement(string.format("存活数满足公式：%s", stageCfg.shuParamStr), isRead)

			local params = {
				isRead = isRead
			}

			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SixArtdaoguanNumbers, params)
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

			return true
		end
	elseif self._currFightChallengeId == SixartdaoguanController.ChallengeType.Defense then
		if result.selectingDropBuff and #result.selectingDropBuff > 0 then
			UIStateManager.instance:push(ViewName.SixartbuffeventView, result.activityId)

			return true
		elseif result.canContinueFight then
			SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanContinueFightReq(result.activityId, result.challengeId)

			return true
		end
	end

	return false
end

function SixartdaoguanController:tryNextBattle()
	local result = SixartdaoguanModel.instance:getBattleResultMsg()

	if not result then
		return false
	end

	if result.canContinueFight then
		self:_reqNextBattle()

		return true
	end

	return false
end

function SixartdaoguanController:isCanNextBattle()
	return self._battleCount > 0
end

function SixartdaoguanController:_reqNextBattle()
	self._battleCount = self._battleCount + 1

	local result = SixartdaoguanModel.instance:getBattleResultMsg()

	SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanContinueFightReq(result.activityId, result.challengeId)
end

function SixartdaoguanController:_onSixArtDaoguanReShuffleDropBuffRes(activityId)
	self:_checkExistDropBuff(activityId)
end

function SixartdaoguanController:_checkExistDropBuff(activityId)
	local info = SixartdaoguanModel.instance:getInfo(activityId)

	if not info then
		return
	end

	for i, v in ipairs(info.challenges) do
		if v.challengeId == SixartdaoguanController.ChallengeType.Defense then
			if v.dropBuffInfo and v.dropBuffInfo.selectingDropBuff then
				UIStateManager.instance:push(ViewName.SixartbuffeventView, activityId, true)
			end

			break
		end
	end
end

SixartdaoguanController.instance = SixartdaoguanController.New()

return SixartdaoguanController
