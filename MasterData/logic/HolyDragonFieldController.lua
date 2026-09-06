-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/controller/HolyDragonFieldController.lua

module("logic.extensions.holydragonfield.controller.HolyDragonFieldController", package.seeall)

local HolyDragonFieldController = class("HolyDragonFieldController", BaseController)

function HolyDragonFieldController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("openholydragonfieldrank", self._openHolyDragonFieldRank, self)
end

function HolyDragonFieldController:onReset()
	return
end

function HolyDragonFieldController:sendPM_HolyDragonFieldInfoReq(activityId)
	HolyDragonFieldAgent.instance:sendPM_HolyDragonFieldInfoReq(activityId)
end

function HolyDragonFieldController:handlePM_HolyDragonFieldInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HolyDragonFieldInfoRes(msg)
	self:_updateBuffRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HolyDragonField_InfoRefresh, msg.activityId)
end

function HolyDragonFieldController:sendPM_HolyDragonFieldChallengeReq(activityId, form, fieldId, stageId, selectBossSettle)
	self:_registerBattleResultHandler(activityId, fieldId, stageId, selectBossSettle)
	HolyDragonFieldAgent.instance:sendPM_HolyDragonFieldChallengeReq(activityId, form, fieldId, stageId, selectBossSettle)
end

function HolyDragonFieldController:handlePM_HolyDragonFieldChallengeRes(status, msg)
	return
end

function HolyDragonFieldController:handlePM_HolyDragonFieldNotifyChallengeRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	if msg.isWin then
		local isFirstPass = not subMo:isStagePassed(msg.fieldId, msg.stageId)

		subMo:handlePM_HolyDragonFieldNotifyChallengeRes(msg)

		if msg.isWin then
			self:_trySelectNextUnlockedStage(msg.activityId, msg.fieldId, msg.stageId, subMo)
		end

		self:_updateBuffRed(msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.HolyDragonField_ChallengeResult, msg.activityId, msg.fieldId, msg.stageId)
	end
end

function HolyDragonFieldController:sendPM_HolyDragonFieldUpgradeBuffReq(activityId, fieldId)
	HolyDragonFieldAgent.instance:sendPM_HolyDragonFieldUpgradeBuffReq(activityId, fieldId)
end

function HolyDragonFieldController:handlePM_HolyDragonFieldUpgradeBuffRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HolyDragonFieldUpgradeBuffRes(msg)
	self:_updateBuffRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HolyDragonField_BuffUpgrade, msg.activityId, msg.fieldId, msg.buffLevel)
end

function HolyDragonFieldController:sendPM_HolyDragonFieldRankViewReq(activityId, fieldId)
	HolyDragonFieldAgent.instance:sendPM_HolyDragonFieldRankViewReq(activityId, fieldId)
end

function HolyDragonFieldController:handlePM_HolyDragonFieldRankViewRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HolyDragonFieldRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyDragonField_RankRefresh, msg.activityId, msg.fieldId)
end

function HolyDragonFieldController:getNextBuffData(activityId, fieldId)
	activityId = checknumber(activityId)
	fieldId = checknumber(fieldId)

	if activityId <= 0 or fieldId <= 0 then
		return nil
	end

	local subMo = self:getSubMo(activityId)
	local level = subMo:getBuffLevel(fieldId)

	if subMo:isBuffUnlocked(fieldId) then
		if not (level + 1) then
			local nextLevel = 1

			return HolyDragonFieldConfig.instance:getBuffData(activityId, fieldId, nextLevel)
		end
	end
end

function HolyDragonFieldController:isBuffCanUpgrade(activityId, fieldId)
	activityId = checknumber(activityId)
	fieldId = checknumber(fieldId)

	if activityId <= 0 or fieldId <= 0 then
		return false
	end

	local subMo = self:getSubMo(activityId)

	if not subMo:isBuffUnlocked(fieldId) then
		return false
	end

	local nextBuffData = self:getNextBuffData(activityId, fieldId)

	return nextBuffData ~= nil and MaterialMgr.getMatEnough(nextBuffData.unlockCost) == true
end

function HolyDragonFieldController:_updateBuffRed(activityId)
	local isActivated = false

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		local fieldDatas = HolyDragonFieldConfig.instance:getFieldDatas(activityId)

		for fieldId, _ in pairs(fieldDatas or {}) do
			if self:isBuffCanUpgrade(activityId, fieldId) then
				isActivated = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_HOLY_DRAGON_FIELD_BUFF_UPDATE, isActivated)
end

function HolyDragonFieldController:_registerBattleResultHandler(activityId, fieldId, stageId, selectBossSettle)
	local stageData = HolyDragonFieldConfig.instance:getStageData(activityId, fieldId, stageId)

	if stageData == nil then
		return
	end

	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local subMo = self:getSubMo(activityId)
		local challengeMsg = subMo:getLastChallengeMsg()

		if challengeMsg == nil or challengeMsg.fieldId ~= fieldId or challengeMsg.stageId ~= stageId then
			return false
		end

		if not challengeMsg.isWin then
			return false
		end

		if HolyDragonFieldConfig.instance:isBossStage(stageData) then
			if not ViewName.HolyDragonFieldStageBossResultView then
				local resultViewName = ViewName.HolyDragonFieldStageResultView

				UIStateManager.instance:push(resultViewName, activityId, fieldId, stageId, selectBossSettle)

				return true
			end
		end
	end)
end

function HolyDragonFieldController:_trySelectNextUnlockedStage(activityId, fieldId, stageId, subMo)
	local nextStageId = self:_getNextUnlockedStageId(activityId, fieldId, stageId)

	if nextStageId > 0 then
		subMo:setSelectedStageId(fieldId, nextStageId)
	end
end

function HolyDragonFieldController:_getNextUnlockedStageId(activityId, fieldId, stageId)
	local fieldData = HolyDragonFieldConfig.instance:getFieldData(activityId, fieldId)

	if fieldData == nil or not self:_isTimeOpen(fieldData.openTime) then
		return 0
	end

	local stageList = {}
	local stageDatas = HolyDragonFieldConfig.instance:getStageDatas(activityId, fieldId)

	for cfgStageId, stageData in pairs(stageDatas or {}) do
		table.insert(stageList, {
			stageId = cfgStageId,
			stageData = stageData
		})
	end

	table.sort(stageList, function(a, b)
		return a.stageId < b.stageId
	end)

	for i, data in ipairs(stageList) do
		if data.stageId == stageId then
			local nextData = stageList[i + 1]

			if nextData == nil or not self:_isTimeOpen(nextData.stageData.openTime) then
				return 0
			end

			return nextData.stageId
		end
	end

	return 0
end

function HolyDragonFieldController:_isTimeOpen(openTime)
	return GameUtil.getTimePeriod(openTime, nil) == GameUtil.inTimePeriod
end

function HolyDragonFieldController:getSubMo(activityId)
	return HolyDragonFieldModel.instance:getSubMo(activityId)
end

function HolyDragonFieldController:showMissionView(activityId, fieldId, stageId, selectBossSettle)
	local fmtMo = HolyDragonFieldModel.instance:getFmtMo(activityId)

	fmtMo:initParams(activityId, fieldId, stageId, selectBossSettle)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function HolyDragonFieldController:_openHolyDragonFieldRank(params)
	local activityId, defaultFieldId = checknumber(params[1]), checknumber(params[2])

	self:openRankView(activityId, defaultFieldId)
end

function HolyDragonFieldController:openRankView(activityId, defaultFieldId)
	defaultFieldId = checknumber(defaultFieldId)

	local params = CommonTabRankListParams.New()
	local fieldDatas = HolyDragonFieldConfig.instance:getFieldDatas(activityId)

	for fieldId, fieldData in ipairs(fieldDatas) do
		local tabKey = string.format("HolyDragonFieldRank_%s", fieldId)

		params:addTabData(fieldId, 0, tabKey, ViewName.HolyDragonFieldChildRankView, lang(fieldData.nameLangkey), {
			activityId,
			fieldId
		})

		if fieldId == defaultFieldId then
			params:setDafaultOpenTab(tabKey)
		end
	end

	UIStateManager.instance:push(ViewName.CommonTabRankFatherListView, params)
end

function HolyDragonFieldController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function HolyDragonFieldController:getActivityType()
	return GameEnum.ActivityType.HolyDragonField
end

HolyDragonFieldController.instance = HolyDragonFieldController.New()

return HolyDragonFieldController
