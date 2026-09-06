-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/model/ShowDownFormationCustomFmtMo.lua

module("logic.extensions.showdown.model.ShowDownFormationCustomFmtMo", package.seeall)

local ShowDownFormationCustomFmtMo = class("ShowDownFormationCustomFmtMo", ICustomFmtMo)

function ShowDownFormationCustomFmtMo:onReset()
	ShowDownFormationCustomFmtMo.super.onReset(self)
end

function ShowDownFormationCustomFmtMo:updateCfg(activityId, roundId, stepId)
	self._activityId = activityId
	self._roundId = roundId
	self._stepId = stepId
	self._formIndex = ShowDownController.instance:getFormIndexInStep(activityId, self._roundId, self._stepId)

	local showDownFormMo = ShowDownController.instance:getShowDownFormMoInPetShop(self._activityId, self._roundId, self._formIndex)

	self._curBuffId = showDownFormMo and showDownFormMo:getBuffId() or 0
	self.isShowBtnFormationUse = false
	self.isShowBtnSave = true
	self.isShowBtnCutePet = false
end

function ShowDownFormationCustomFmtMo:getActivityId()
	return self._activityId
end

function ShowDownFormationCustomFmtMo:getRoundId()
	return self._roundId
end

function ShowDownFormationCustomFmtMo:getCurBuffId()
	return self._curBuffId
end

function ShowDownFormationCustomFmtMo:setCurBuffId(value)
	self._curBuffId = checknumber(value)
end

function ShowDownFormationCustomFmtMo:updateData()
	self.isShowBtnFormation = false
	self.isShowBtnBuffForm = true

	self:initPetList()
	self:refreshMyFmts()
end

function ShowDownFormationCustomFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()
	local creepsIdList = ShowDownController.instance:getBagPetListInPetShop(self._activityId, self._roundId)

	for _, creepsId in ipairs(creepsIdList) do
		local data = ShowDownConfig.instance:getSystemPetData(creepsId)

		if data then
			fMo:fromChallengeCreepCo(data)

			local petMo = fMo:toBaseBagPetMo()

			self:addPetToList(petMo)
		else
			printError(string.format("缺失精灵( l擂台赛.xlsx | export_系统精灵 | creepsId = %s )", creepsId))
		end
	end
end

function ShowDownFormationCustomFmtMo:refreshMyFmts()
	local showDownFormMo = ShowDownController.instance:getShowDownFormMoInPetShop(self._activityId, self._roundId, self._formIndex)
	local data = showDownFormMo and showDownFormMo:getSimpleForm()

	if data then
		self:getCurFormation():SetData(data)
	else
		self:getCurFormation():ResetPosition()
	end
end

function ShowDownFormationCustomFmtMo:_updateFmt()
	self:initPetList()
	self:refreshMyFmts()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

function ShowDownFormationCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function ShowDownFormationCustomFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		FloatWordMgr.instance:show("空阵不能保存作为守阵，请返回布阵")

		return
	end

	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._roundId)

	if not isHasConfirm then
		FloatWordMgr.instance:show("未确认精灵，请确认后再保存")

		return
	end

	if self._roundId ~= ShowDownEnum.Round_Func then
		local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
		local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

		if curRoundId ~= self._roundId then
			FloatWordMgr.instance:show("比赛阶段已发生变化，请退出布阵")

			return
		end
	end

	local simpleForm = self:getCurSimpleForm()
	local buffId = self:getCurBuffId()

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_ShowDown_SetFormRes, self._handlePM_ShowDown_SetFormRes, self)

	if buffId > 0 then
		ShowDownController.instance:sendPM_ShowDown_SetFormReq(self._activityId, self._roundId, self._formIndex, simpleForm, buffId)
	else
		ShowDownController.instance:sendPM_ShowDown_SetFormReq(self._activityId, self._roundId, self._formIndex, simpleForm)
	end
end

function ShowDownFormationCustomFmtMo:_handlePM_ShowDown_SetFormRes(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_ShowDown_SetFormRes, self._handlePM_ShowDown_SetFormRes, self)

	if status ~= 0 then
		FloatWordMgr.instance:show("阵容保存失败")
	else
		FloatWordMgr.instance:show("阵容保存成功")
	end
end

function ShowDownFormationCustomFmtMo:sendSaveMsg(fromBtnSave)
	if not fromBtnSave then
		return
	end

	ShowDownFormationCustomFmtMo.super.sendSaveMsg(self, fromBtnSave)
end

function ShowDownFormationCustomFmtMo:getFormationExtendViewName()
	return ViewName.ShowDownFormationExView
end

function ShowDownFormationCustomFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

return ShowDownFormationCustomFmtMo
