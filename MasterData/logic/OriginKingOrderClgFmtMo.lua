-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/model/OriginKingOrderClgFmtMo.lua

module("logic.extensions.originkingorderclg.model.OriginKingOrderClgFmtMo", package.seeall)

local OriginKingOrderClgFmtMo = class("OriginKingOrderClgFmtMo", BaseCustomFmtMo)

function OriginKingOrderClgFmtMo:onReset()
	OriginKingOrderClgFmtMo.super.onReset(self)
end

function OriginKingOrderClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = OriginKingOrderClgConfig.instance:getStageData(self._activityId, self._stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
	self._creepsTeamData = OriginKingOrderClgConfig.instance:getCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = OriginKingOrderClgConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._creepsTeamData.name
	self.validatorDescStr = self._creepsTeamData.missionDesc
	self.ruleDescStr = self._creepsTeamData.ruleDesc

	self:setFormCondition(self._creepsTeamData.formCondition)
end

function OriginKingOrderClgFmtMo:updateData()
	OriginKingOrderClgFmtMo.super.updateData(self)
	self:updateFormationEffectBuff()
end

function OriginKingOrderClgFmtMo:getActivityId()
	return self._activityId
end

function OriginKingOrderClgFmtMo:getStageId()
	return self._stageId
end

function OriginKingOrderClgFmtMo:updateFormationEffectBuff()
	self:clearAllFixedEffects()

	local stageType = self._subMo:getStageType(self._stageId)

	if stageType == OriginKingOrderClgEnum.StageType_Water then
		local lastFormationSoul = self._subMo:getLastFormationSoul()
		local targetStageId = self._subMo:getCurPassedStageId() + 1
		local signs = self._subMo:getNextFormationSigns(lastFormationSoul, targetStageId)

		for posId = 1, 9 do
			if not signs[posId] then
				local hasSign = false

				if hasSign then
					self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_07.prefab")
				end
			end
		end
	elseif stageType == OriginKingOrderClgEnum.StageType_Kong then
		local lastFormationSoul = self._subMo:getLastFormationSoul()
		local targetStageId = self._subMo:getCurPassedStageId() + 1
		local signs = self._subMo:getNextFormationSigns(lastFormationSoul, targetStageId)
		local signsArray = {}

		for posId = 1, 9 do
			signsArray[posId] = signs[posId] or false
		end

		local radiations = self._subMo:getStormRadiations(signsArray)

		for posId = 1, 9 do
			if not radiations[posId] then
				local isStormEye = signsArray[posId]

				if isStormEye then
					self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_04.prefab")
				elseif radiations[posId] > 0 then
					self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_08.prefab")
				end
			end
		end
	end
end

function OriginKingOrderClgFmtMo:initFightHandler()
	local function handler()
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)

			local result = false
			local subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
			local fightResultMsg = subMo:getFightResultMsg()

			if fightResultMsg and fightResultMsg.win then
				UIStateManager.instance:push(ViewName.OriginKingOrderClgResultSureView, self)

				result = true
			end

			return result
		end)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginKingOrderClgController.instance:sendPM_OriginKingOrderClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginKingOrderClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginKingOrderClgFmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

function OriginKingOrderClgFmtMo:getExtendViewName()
	return ViewName.OriginKingOrderClgFmtExView
end

return OriginKingOrderClgFmtMo
