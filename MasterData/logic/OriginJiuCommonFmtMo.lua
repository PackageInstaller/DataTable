-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/model/OriginJiuCommonFmtMo.lua

module("logic.extensions.originjiu.model.OriginJiuCommonFmtMo", package.seeall)

local OriginJiuCommonFmtMo = class("OriginJiuCommonFmtMo", BaseCustomFmtMo)

function OriginJiuCommonFmtMo:initParams(activityId, modelId, phaseId, stageId, stageRoad)
	self._activityId = activityId
	self._modelId = modelId
	self._phaseId = phaseId
	self._stageId = stageId
	self._stageRoad = stageRoad or OriginJiuModel.StageRoad_A
	self._isTeamFirst = stageId == 1

	local phaseData = OriginJiuConfig.instance:getPhaseData(activityId, modelId, phaseId)

	self._clgType = phaseData.type
	self._openPetHp = OriginJiuModel.instance:isOpenPetHp(activityId, modelId)

	if self._clgType == OriginJiuModel.ClgType_Wheel then
		self._openPetHp = true
	end

	local stageData = OriginJiuConfig.instance:getStageData(activityId, modelId, phaseId, stageId)

	if stageData == nil then
		printError(string.format("错误StageData -> activityId: %s, modelId: %s, phaseId: %s, stageId: %s, stageRoad: %s", activityId, modelId, phaseId, stageId, stageRoad))

		return
	end

	local creepsMasterId = 0

	if self._stageRoad == OriginJiuModel.StageRoad_A then
		creepsMasterId = stageData.creepsMasterIdA
	elseif self._stageRoad == OriginJiuModel.StageRoad_B then
		creepsMasterId = stageData.creepsMasterIdB
	else
		printError(string.format("错误StageRoad -> activityId: %s, modelId: %s, phaseId: %s, stageId: %s, stageRoad: %s", activityId, modelId, phaseId, stageId, stageRoad))
	end

	if creepsMasterId == 0 then
		printError(string.format("错误creepsMasterId,可能是分支选错引起 -> activityId: %s, modelId: %s, phaseId: %s, stageId: %s, stageRoad: %s", activityId, modelId, phaseId, stageId, stageRoad))

		return
	end

	self._masterData = OriginJiuConfig.instance:getTeamData(creepsMasterId)
	self._creepsCfg = OriginJiuConfig.instance:getCreepsDatas(creepsMasterId)

	OriginJiuModel.instance:resetAllPetLockState(activityId, modelId)

	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginJiuCommonFmtMo:initFightHandler()
	local function handler()
		local function okFunc()
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

			local req = OriginJiuClgExtension_pb.OriginJiuClgSetFormation()

			req.teamId = 1

			CustomFmtController.instance:createFormPb(self:getCurFormation(), req.simpleForm)
			OriginJiuController.instance:sendPM_OriginJiuClgChallengeReq(self._activityId, self._modelId, self._phaseId, self._stageId, self._stageRoad, {
				req
			})
		end

		if self._isTeamFirst then
			local tipsContent = "是否确认挑战该关卡？挑战后其他关卡将在本层通关后才可进行挑战？"

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		else
			okFunc()
		end
	end

	self:setFightHandler(handler, nil)
end

function OriginJiuCommonFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginJiuCommonFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginJiuCommonFmtMo:updateCellTop(cell, petMo)
	if not self._openPetHp then
		return
	end

	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local hpInfo = OriginJiuModel.instance:getPetHpInfo(petMo.petId)

		if hpInfo then
			if not hpInfo.hpRate then
				local percent = 1

				proxy.binder:onUpdateHp(percent)
			end
		end
	end
end

function OriginJiuCommonFmtMo:checkPetIsForbit(petMo, baseCheck)
	return OriginJiuModel.instance:checkLockPet(petMo)
end

function OriginJiuCommonFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵不能上阵")
end

return OriginJiuCommonFmtMo
