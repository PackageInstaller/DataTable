-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/controller/ElementSparkController.lua

module("logic.extensions.elementspark.controller.ElementSparkController", package.seeall)

local ElementSparkController = class("ElementSparkController", BaseController)

function ElementSparkController:ctor()
	return
end

function ElementSparkController:onInit()
	self:onReset()
end

function ElementSparkController:onReset()
	self._activityId = 0
	self._mapPlanId = 0

	removetimer(self._refreshMap, self)
	removetimer(self._delayRefreshMap, self)
end

function ElementSparkController:sendPM_EleSparkGetRegisterInfoReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGetRegisterInfoReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetRegisterInfoRes(status, msg)
	ElementSparkModel.instance:setRegisterInfo(checkbool(msg.register))
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetRegisterInfoRes, msg)
end

function ElementSparkController:sendPM_EleSparkRegisterReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkRegisterReq(activityId)
end

function ElementSparkController:handlePM_EleSparkRegisterRes(status, msg)
	ElementSparkModel.instance:setRegisterInfo(true)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkRegisterRes)
end

function ElementSparkController:sendPM_EleSparkGetInfoReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGetInfoReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetInfoRes(status, msg)
	ElementSparkModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetInfoRes, msg)
end

function ElementSparkController:sendPM_EleSparkGetMyFormsReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGetMyFormsReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetMyFormsRes(status, msg)
	ElementSparkModel.instance:setMyFormsInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetMyFormsRes, msg)
end

function ElementSparkController:sendPM_EleSparkSetMyFormsReq(activityId, forms)
	self._saveFormsIdx = {}

	for i, v in ipairs(forms) do
		if v.teamId > 100 then
			table.insert(self._saveFormsIdx, v.teamId - 100 + 2)
		else
			table.insert(self._saveFormsIdx, v.teamId)
		end
	end

	ElementSparkAgent.instance:sendPM_EleSparkSetMyFormsReq(activityId, forms)
end

function ElementSparkController:handlePM_EleSparkSetMyFormsRes(status, msg)
	local preStr = ""

	if self._saveFormsIdx then
		preStr = string.format("队伍%s", table.concat(self._saveFormsIdx, ","))
	end

	if status == 0 then
		FloatWordMgr.instance:show(preStr .. "保存成功")
	else
		FloatWordMgr.instance:show(preStr .. "保存失败")
	end
end

function ElementSparkController:sendPM_EleSparkGetOtherGuardInfoReq(activityId, chunkId)
	ElementSparkAgent.instance:sendPM_EleSparkGetOtherGuardInfoReq(activityId, chunkId)
end

function ElementSparkController:handlePM_EleSparkGetOtherGuardInfoRes(status, msg)
	ElementSparkModel.instance:setOtherGuardInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetOtherGuardInfoRes, msg)
end

function ElementSparkController:sendPM_EleSparkGetMyGuardInfoReq(activityId, chunkId)
	ElementSparkAgent.instance:sendPM_EleSparkGetMyGuardInfoReq(activityId, chunkId)
end

function ElementSparkController:handlePM_EleSparkGetMyGuardInfoRes(status, msg)
	ElementSparkModel.instance:setGuardInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetMyGuardInfoRes, msg)
end

function ElementSparkController:sendPM_EleSparkUpgradeGuardReq(activityId, chunkId, targetLv)
	ElementSparkAgent.instance:sendPM_EleSparkUpgradeGuardReq(activityId, chunkId, targetLv)
end

function ElementSparkController:handlePM_EleSparkUpgradeGuardRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkUpgradeGuardRes, msg.lv)
	ElementSparkModel.instance:setCampScore(msg.campScore)
end

function ElementSparkController:sendPM_EleSparkSendGuardDefenseFormReq(activityId, chunkId, teamId)
	ElementSparkAgent.instance:sendPM_EleSparkSendGuardDefenseFormReq(activityId, chunkId, teamId)
end

function ElementSparkController:handlePM_EleSparkSendGuardDefenseFormRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkSendGuardDefenseFormReq, msg)
end

function ElementSparkController:sendPM_EleSparkGetGuardRecordReq(activityId, chunkId)
	ElementSparkAgent.instance:sendPM_EleSparkGetGuardRecordReq(activityId, chunkId)
end

function ElementSparkController:handlePM_EleSparkGetGuardRecordRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkGetGuardRecordInfo, msg.guardRecords)
end

function ElementSparkController:sendPM_EleSparkChallengeDefenseFormReq(activityId, chunkId, teamId)
	self._challengeDefenseChunkId = chunkId

	ElementSparkAgent.instance:sendPM_EleSparkChallengeDefenseFormReq(activityId, chunkId, teamId)
end

function ElementSparkController:handlePM_EleSparkChallengeDefenseFormRes(status, msg)
	if msg:HasField("teamStrength") then
		ElementSparkModel.instance:changeTeamStrength(msg.teamStrength)
	end

	if status == 0 then
		ElementSparkModel.instance:addPersonScore(msg.addPersonScore)
		BattleFacade.instance:startElementSpark(self._challengeDefenseChunkId)
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult)
	end
end

function ElementSparkController:sendPM_EleSparkChallengeBossReq(activityId, chunkId, teamId)
	self._challengeBossChunkId = chunkId

	ElementSparkAgent.instance:sendPM_EleSparkChallengeBossReq(activityId, chunkId, teamId)
end

function ElementSparkController:handlePM_EleSparkChallengeBossRes(status, msg)
	if msg:HasField("teamStrength") then
		ElementSparkModel.instance:changeTeamStrength(msg.teamStrength)
	end

	if status == 0 then
		ElementSparkModel.instance:addPersonScore(msg.addPersonScore)
		BattleFacade.instance:startElementSpark(self._challengeBossChunkId)
		BattleController.instance:viewUserFightMonsterBtlResult(msg.battleResult)

		if msg.change2CampId > 0 then
			ElementSparkModel.instance:setChunkBelong(self._challengeBossChunkId, msg.change2CampId)
		end
	end
end

function ElementSparkController:sendPM_EleSparkRevokeDefenseFormReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkRevokeDefenseFormReq(activityId)
end

function ElementSparkController:handlePM_EleSparkRevokeDefenseFormRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.EleSparkRevokeDefenseFormRes, msg)
	else
		FloatWordMgr.instance:show("撤军失败")
	end
end

function ElementSparkController:sendPM_EleSparkGetSparkInfoReq()
	local activityId = self:getActivityId()

	ElementSparkAgent.instance:sendPM_EleSparkGetSparkInfoReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetSparkInfoRes(status, msg)
	ElementSparkModel.instance:setSparkInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkGetSparkInfo)
end

function ElementSparkController:sendPM_EleSparkBuyPetReq(itemId)
	local activityId = self:getActivityId()

	ElementSparkAgent.instance:sendPM_EleSparkBuyPetReq(activityId, itemId)
end

function ElementSparkController:handlePM_EleSparkBuyPetRes(status, msg)
	ElementSparkModel.instance:addPetShopItem(msg.itemId)
	ElementSparkModel.instance:setPetShopScore(msg.petShopScore)
	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkBuyPetRes)
end

function ElementSparkController:sendPM_EleSparkRefreshMapInfoReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkRefreshMapInfoReq(activityId)
end

function ElementSparkController:handlePM_EleSparkRefreshMapInfoRes(status, msg)
	ElementSparkModel.instance:setMapInfo(msg.mapInfo)
	ElementSparkSceneController.instance:updateChunks()
	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkMapChange)
end

function ElementSparkController:sendPM_EleSparkAddTagReq(activityId, chunkId, signId)
	ElementSparkAgent.instance:sendPM_EleSparkAddTagReq(activityId, chunkId, signId)
end

function ElementSparkController:handlePM_EleSparkAddTagRes(status, msg)
	local tab = {
		tagId = msg.tagId,
		signId = msg.signId,
		chunkId = msg.chunkId,
		tagTimeMillis = ServerTime.nowMs()
	}

	ElementSparkModel.instance:addTag(tab)

	local units = SceneMgr.instance:getCurScene().unitFactory:getUnits(UnitTag.TilingSceneElem)

	for id, unit in pairs(units or {}) do
		if unit.chunkId == msg.chunkId and unit:isVisible() then
			unit:updateHud()
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkTagChange, msg.chunkId)
end

function ElementSparkController:sendPM_EleSparkModifyTagReq(activityId, tagId, signId, chunkId)
	self._modifyTagInfo = {
		tagId = tagId,
		chunkId = chunkId,
		signId = signId
	}

	ElementSparkAgent.instance:sendPM_EleSparkModifyTagReq(activityId, tagId, signId, chunkId)
end

function ElementSparkController:handlePM_EleSparkModifyTagRes(status, msg)
	if not self._modifyTagInfo then
		return
	end

	local chunkId = self._modifyTagInfo.chunkId
	local tab = {
		tagId = self._modifyTagInfo.tagId,
		signId = self._modifyTagInfo.signId,
		chunkId = self._modifyTagInfo.chunkId,
		tagTimeMillis = ServerTime.nowMs()
	}

	ElementSparkModel.instance:addTag(tab)

	local units = SceneMgr.instance:getCurScene().unitFactory:getUnits(UnitTag.TilingSceneElem)

	for id, unit in pairs(units or {}) do
		if unit.chunkId == tab.chunkId and unit:isVisible() then
			unit:updateHud()
		end
	end

	self._modifyTagInfo = nil

	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkTagChange, chunkId)
end

function ElementSparkController:sendPM_EleSparkModifyBoardReq(activityId, content)
	self._content = content

	ElementSparkAgent.instance:sendPM_EleSparkModifyBoardReq(activityId, content)
end

function ElementSparkController:handlePM_EleSparkModifyBoardRes(status, msg)
	if checknumber(msg.modifyBoardCdEndMillis) > ServerTime.nowMs() then
		ElementSparkModel.instance:setBoardInfo(self._content)
		GlobalDispatcher:dispatch(GlobalNotify.EleSparkModifyBoardRes, msg.modifyBoardCdEndMillis)
	end
end

function ElementSparkController:sendPM_EleSparkGetCampInfoReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGetCampInfoReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetCampInfoRes(status, msg)
	ElementSparkModel.instance:setCampInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetCampInfoRes, msg)
end

function ElementSparkController:sendPM_EleSparkModifyMinDefenseFormZdlReq(activityId, minZdl)
	self._minZdl = minZdl

	ElementSparkAgent.instance:sendPM_EleSparkModifyMinDefenseFormZdlReq(activityId, minZdl)
end

function ElementSparkController:handlePM_EleSparkModifyMinDefenseFormZdlRes(status, msg)
	if checknumber(msg.modifyMinZdlCdEndMillis) > ServerTime.nowMs() then
		ElementSparkModel.instance:setPowerValue(self._minZdl)
		GlobalDispatcher:dispatch(GlobalNotify.EleSparkModifyMinDefenseFormZdlRes, msg.modifyMinZdlCdEndMillis)
	end
end

function ElementSparkController:sendPM_EleSparkPublishCommandReq(activityId, command)
	ElementSparkAgent.instance:sendPM_EleSparkPublishCommandReq(activityId, command)
end

function ElementSparkController:handlePM_EleSparkPublishCommandRes(status, msg)
	local commandData = {}

	commandData.areaId = RoleModel.instance:getAreaId()
	commandData.commanderName = RoleModel.instance:getUserName()
	commandData.command = msg.command
	commandData.commandTimeMillis = msg.commandTimeMillis

	ElementSparkModel.instance:addCommands(commandData)
	ElementSparkModel.instance:setLastestCommand(commandData.command)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkPublishCommandRes)
end

function ElementSparkController:sendPM_EleSparkGetResourceInfoReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGetResourceInfoReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetResourceInfoRes(status, msg)
	ElementSparkModel.instance:setResourceInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetResourceInfoRes)
end

function ElementSparkController:sendPM_EleSparkGainResourceReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGainResourceReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGainResourceRes(status, msg)
	local oldPetShopScore = ElementSparkModel.instance:getPetShopScore()
	local newPetShopScore = oldPetShopScore + msg.petShopScore

	ElementSparkModel.instance:setPetShopScore(newPetShopScore)
	ElementSparkModel.instance:addPersonScore(msg.personScore)
	ElementSparkModel.instance:addCampScore(msg.campScore)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGainResourceRes, msg)
end

function ElementSparkController:sendPM_EleSparkGetCampRankReq(activityId)
	ElementSparkAgent.instance:sendPM_EleSparkGetCampRankReq(activityId)
end

function ElementSparkController:handlePM_EleSparkGetCampRankRes(status, msg)
	ElementSparkModel.instance:setCampRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetCampRankRes)
end

function ElementSparkController:sendPM_EleSparkGetPersonRankReq(activityId, campId)
	self._rankCampId = campId

	ElementSparkAgent.instance:sendPM_EleSparkGetPersonRankReq(activityId, self._rankCampId)
end

function ElementSparkController:handlePM_EleSparkGetPersonRankRes(status, msg)
	ElementSparkModel.instance:setPersonRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EleSparkGetPersonRankRes, self._rankCampId)
end

function ElementSparkController:handlePM_EleSparkNotifyGuardInfoChangeRes(status, msg)
	if not ElementSparkSceneController.instance:isInScene() then
		return
	end

	ElementSparkModel.instance:defenseGuardChange(msg)
	ElementSparkSceneController.instance:updateChunks()
end

function ElementSparkController:handlePM_EleSparkNotifyMapInfoChangeRes(status, msg)
	if not ElementSparkSceneController.instance:isInScene() then
		return
	end

	local time = math.random(1, 3)

	settimer(time, self._refreshMap, self, false)
end

function ElementSparkController:delayRefreshMap(refreshMsTime)
	local time = refreshMsTime / 1000

	time = time - ServerTime.now() + 2

	settimer(time, self._delayRefreshMap, self)
end

function ElementSparkController:_delayRefreshMap()
	self:_refreshMap()
end

function ElementSparkController:_refreshMap()
	local activityId = self:getActivityId()

	self:sendPM_EleSparkRefreshMapInfoReq(activityId)
end

function ElementSparkController:sendPM_EleSparkExitReq()
	ElementSparkAgent.instance:sendPM_EleSparkExitReq()
end

function ElementSparkController:handlePM_EleSparkExitRes(status, msg)
	return
end

function ElementSparkController:getActivityId()
	return self._activityId
end

function ElementSparkController:setActivityId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElementSpark)

	self:setSparkChunkId()
end

function ElementSparkController:getMapPlanId()
	if self._mapPlanId <= 0 then
		local activityId = self:getActivityId()
		local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)

		self._mapPlanId = actCfg.mapPlanId
	end

	return self._mapPlanId
end

function ElementSparkController:getActivityStage()
	local activityId = self:getActivityId()
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInActivityTime then
		ElementSparkModel.instance:setStageType(GameEnum.ElementSparkStageType.Notopen)

		return GameEnum.ElementSparkStageType.Notopen
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.ElementSpark, activityId)
	local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)
	local registerEndTime = GameUtil.string2time(actCfg.registerEndTime)
	local warStartTime, warEndTime = GameUtil.string2time(actCfg.warStartTime), GameUtil.string2time(actCfg.warEndTime)
	local nowTime = ServerTime.now()

	if nowTime < warStartTime then
		if registerEndTime < nowTime then
			ElementSparkModel.instance:setStageType(GameEnum.ElementSparkStageType.RandomAssigned)

			return GameEnum.ElementSparkStageType.RandomAssigned
		else
			ElementSparkModel.instance:setStageType(GameEnum.ElementSparkStageType.Signup)

			return GameEnum.ElementSparkStageType.Signup
		end
	elseif nowTime < warEndTime then
		ElementSparkModel.instance:setStageType(GameEnum.ElementSparkStageType.Battle)

		return GameEnum.ElementSparkStageType.Battle
	else
		ElementSparkModel.instance:setStageType(GameEnum.ElementSparkStageType.Result)

		return GameEnum.ElementSparkStageType.Result
	end
end

function ElementSparkController:isResultTime()
	return ElementSparkModel.instance:getStageType() == GameEnum.ElementSparkStageType.Result
end

function ElementSparkController:checkResultTime()
	local isResultTime = self:isResultTime()

	if isResultTime then
		FloatWordMgr.instance:show("公示阶段,无法操作")

		return true
	end

	return false
end

function ElementSparkController:getStageDescTxt(stage)
	local activityId = self:getActivityId()
	local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)

	if stage == 2 then
		local warStartTime, warEndTime = GameUtil.string2date(actCfg.warStartTime), GameUtil.string2date(actCfg.warEndTime)

		return GameUtil.getFormatTimeByDate(warStartTime, warEndTime)
	end

	local timeCfg = ActivityDefineConfig.instance:getCfgByActivitYId(activityId)
	local startDate, endDate = GameUtil.string2date(timeCfg.startTime), GameUtil.string2date(timeCfg.endTime)

	if stage == 1 then
		local registerEndTime = GameUtil.string2date(actCfg.registerEndTime)

		return GameUtil.getFormatTimeByDate(startDate, registerEndTime)
	end

	if stage == 3 then
		local warEndTime = GameUtil.string2date(actCfg.warEndTime)

		return GameUtil.getFormatTimeByDate(warEndTime, endDate)
	end

	return ""
end

function ElementSparkController:isRestTime()
	local activityId = self:getActivityId()
	local endTime
	local nowTime = ServerTime.now()
	local nowTimeDate = ServerTime.nowDate()
	local restTimeRange = string.split(ElementSparkConfig.instance:getActivityCfgById(activityId).restTimeRange, "-")
	local isInTime = GameUtil.checkIsInTimePeriod(restTimeRange[1], restTimeRange[2], true)
	local restTimeStart = GameUtil.string2time("0-0-0 " .. restTimeRange[1])
	local oneDayStamp = 86400

	return isInTime, isInTime and GameUtil.string2time("0-0-0 " .. restTimeRange[2]) or restTimeStart - 1 + oneDayStamp
end

function ElementSparkController:restTimeDesc()
	local activityId = self:getActivityId()
	local restTimeRange = string.split(ElementSparkConfig.instance:getActivityCfgById(activityId).restTimeRange, "-")
	local startTimeArr = string.split(restTimeRange[1], ":")
	local endTimeArr = string.split(restTimeRange[2], ":")
	local timeDesc = ""

	timeDesc = string.format("%d点", checknumber(startTimeArr[1]))

	if checknumber(startTimeArr[2]) > 0 then
		timeDesc = timeDesc .. string.format("%d分", checknumber(startTimeArr[2]))
	end

	timeDesc = timeDesc .. string.format("-%d点", checknumber(endTimeArr[1]))

	if checknumber(endTimeArr[2]) > 0 then
		timeDesc = timeDesc .. string.format("%d分", checknumber(endTimeArr[2]))
	end

	return timeDesc
end

function ElementSparkController:isFristInBattle()
	return checkbool(ElementSparkModel.instance:getFristOpenInfo())
end

function ElementSparkController:getDistributeDesc()
	local activityId = self:getActivityId()
	local campId = ElementSparkModel.instance:getMyCampId()
	local campCfg = ElementSparkConfig.instance:getCampCfgById(activityId, campId)

	if not campCfg then
		return "暂无描述"
	end

	local campName = campCfg.name
	local supportName = campCfg.supportName
	local commanderNames = self:getCommandName()
	local isCommander = self:isCommander()
	local userId = RoleModel.instance:getUserId()

	if isCommander then
		return langPara("elementspark_1", campName), langPara("elementspark_3", supportName, commanderNames)
	else
		return langPara("elementspark_2", campName), langPara("elementspark_4", supportName, commanderNames)
	end
end

function ElementSparkController:getMyCampName()
	local activityId = self:getActivityId()
	local campId = ElementSparkModel.instance:getMyCampId()

	return self:getCampNameById(campId)
end

function ElementSparkController:getCampNameById(campId)
	local activityId = self:getActivityId()
	local campCfg = ElementSparkConfig.instance:getCampCfgById(activityId, campId)

	return (campCfg or nil) and (campCfg.name or "无")
end

function ElementSparkController:isCommander()
	return ElementSparkModel.instance:isCommander()
end

function ElementSparkController:isWinnerCamp()
	local myCampId = ElementSparkModel.instance:getMyCampId()
	local winnerCampId = ElementSparkModel.instance:getWinnerCampId()

	if myCampId <= 0 or winnerCampId <= 0 then
		return false
	end

	return myCampId == winnerCampId
end

function ElementSparkController:getCommandName()
	local commanderInfo = ElementSparkModel.instance:getFristOpenInfo()
	local userName = RoleModel.instance:getUserName()
	local userId = checknumber(RoleModel.instance:getUserId())
	local names = ""

	for i, v in ipairs(commanderInfo.commanderIds) do
		if checknumber(v) ~= userId then
			local commanderName = commanderInfo.commanderNames[i]

			if commanderName then
				names = string.nilorempty(names) and commanderName or names .. "," .. commanderName
			end
		end
	end

	if string.nilorempty(names) then
		return "无"
	end

	return names
end

function ElementSparkController:setSparkChunkId()
	local activityId = self:getActivityId()

	if activityId <= 0 then
		return
	end

	local planId = self:getMapPlanId()
	local mapChunkCfg = ElementSparkConfig.instance:getMapChunkCfgs(planId)

	for _, v in pairs(mapChunkCfg) do
		if v.chunkType == "spark" then
			ElementSparkModel.instance:setSparkChunkId(v.chunkId)

			return
		end
	end
end

function ElementSparkController:getSparkBelongCampId()
	local activityId = self:getActivityId()
	local planId = self:getMapPlanId()
	local sparkChunkId = ElementSparkModel.instance:getSparkChunkId()
	local occupyRequiredGuards = ElementSparkConfig.instance:getMapChunkCfgById(planId, sparkChunkId).occupyRequiredGuards
	local campId

	for _, chunkId in pairs(occupyRequiredGuards) do
		local belongCampId = ElementSparkModel.instance:getChunkBelong(chunkId)

		if belongCampId <= 0 then
			return -1
		elseif campId == nil then
			campId = belongCampId
		else
			if belongCampId ~= campId then
				return -1
			end

			campId = belongCampId
		end
	end

	return campId
end

function ElementSparkController:setPetShopChunkId()
	local activityId = self:getActivityId()
	local planId = self:getMapPlanId()
	local campId = ElementSparkModel.instance:getMyCampId()
	local mapChunkCfg = ElementSparkConfig.instance:getMapChunkCfgs(planId)

	for _, v in pairs(mapChunkCfg) do
		if v.chunkType == GameEnum.ElementSparkChunkType.PetShop and v.initCamp == campId then
			ElementSparkModel.instance:setPetShopId(v.chunkId)

			return
		end
	end
end

function ElementSparkController:getResourceInfo()
	local info = ElementSparkModel.instance:getResourceInfo()
	local myCampId = ElementSparkModel.instance:getMyCampId()
	local data = {}

	for i, v in ipairs(info) do
		local belongCampId = ElementSparkModel.instance:getChunkBelong(v.chunkId)

		if belongCampId == myCampId then
			table.insert(data, v)
		end
	end

	return data
end

function ElementSparkController:getResourceScoreData()
	local info = ElementSparkModel.instance:getResourceInfo()

	if TableUtil.isTableEmpty(info) then
		return
	end

	local myCampId = ElementSparkModel.instance:getMyCampId()
	local data = {}

	for i, v in ipairs(info) do
		local belongCampId = ElementSparkModel.instance:getChunkBelong(v.chunkId)
		local hasData = checknumber(v.personScoreCanGain) > 0 or checknumber(v.petShopScoreCanGain) > 0 or checknumber(v.campScoreCanGain) > 0

		if belongCampId == myCampId or hasData then
			table.insert(data, v)
		end
	end

	if data then
		table.sort(data, function(a, b)
			local isMineA = a.belongCampId == myCampId
			local isMineB = b.belongCampId == myCampId

			if isMineA ~= isMineB then
				return isMineA
			end

			return a.chunkId < b.chunkId
		end)
	end

	return data
end

function ElementSparkController:isCanGainResource()
	local info = ElementSparkModel.instance:getResourceInfo()

	if TableUtil.isTableEmpty(info) then
		return false
	end

	for i, v in ipairs(info) do
		if checknumber(v.personScoreCanGain) > 0 or checknumber(v.petShopScoreCanGain) > 0 or checknumber(v.campScoreCanGain) > 0 then
			return true
		end
	end

	return false
end

function ElementSparkController:filterCampDamageInfos(campDamageInfos)
	local damageInfo = {}
	local totalPercent = self:getTotalDamage(campDamageInfos)

	for i, v in ipairs(campDamageInfos) do
		local percent = v.bossPercent + v.defenseFormPercent

		if percent > 0 then
			local data = {}

			data.campId = v.campId
			data.campName = self:getCampNameById(v.campId)
			data.percent = percent / totalPercent * 100

			table.insert(damageInfo, data)
		end
	end

	return damageInfo
end

function ElementSparkController:getTotalDamage(campDamageInfos)
	local totalPercent = 0

	for i, v in ipairs(campDamageInfos) do
		local percent = v.bossPercent + v.defenseFormPercent

		totalPercent = totalPercent + percent
	end

	return totalPercent
end

function ElementSparkController:getTeamInfo()
	local forms = ElementSparkModel.instance:getMyFormInfo()
	local attackNum = ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_TEAM_NUM", true)
	local defenseNum = ElementSparkConfig.instance:getCommonCfgByKey("GUARD_TEAM_NUM", true)

	if not forms.attackForms then
		if not forms.defenseForms then
			local teamData = {}

			temData = self:getAttackInfo(teamData)
			temData = self:getDefenseInfo(teamData)

			return teamData
		end
	end
end

function ElementSparkController:getAttackInfo(list)
	local forms = ElementSparkModel.instance:getMyFormInfo()
	local attackNum = ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_TEAM_NUM", true)

	if not forms.attackForms then
		for i = 1, attackNum do
			local data = {}

			data.mode = "攻击"
			data.teamInfo = self:getAttackTeamInfoById(i)

			table.insert(list, data)
		end

		return list
	end
end

function ElementSparkController:getAttackTeamInfoById(teamId)
	local forms = ElementSparkModel.instance:getMyFormInfo()

	if not forms.attackForms then
		if #forms.attackForms > 0 then
			for i, v in ipairs(forms.attackForms) do
				if v.teamStrength.teamId == teamId then
					return v
				end
			end
		end

		return {}
	end
end

function ElementSparkController:getDefenseInfo(list)
	local forms = ElementSparkModel.instance:getMyFormInfo()
	local defenseNum = ElementSparkConfig.instance:getCommonCfgByKey("GUARD_TEAM_NUM", true)

	for i = 1, defenseNum do
		local data = {}

		data.mode = "防守地块"
		data.teamInfo = self:getDefenseTeamInfoById(i)

		table.insert(list, data)
	end
end

function ElementSparkController:getDefenseTeamInfoById(teamId)
	local forms = ElementSparkModel.instance:getMyFormInfo()

	if not forms.defenseForms then
		local id = 100 + teamId

		if #forms.defenseForms > 0 then
			for i, v in ipairs(forms.defenseForms) do
				if v.teamId == id then
					return v
				end
			end
		end

		return {}
	end
end

function ElementSparkController:getTeamMo(form)
	local teamMo = {}

	if form then
		for i, v in ipairs(form.pos) do
			local posId = v

			if posId > 0 then
				local mo = BagPetsController.instance:getPet(posId)

				if mo == nil then
					local petCo = ElementSparkConfig.instance:getSupportPetCfg(posId)

					if petCo then
						local fPowerPet = FightingPowerPetMo.New()

						fPowerPet:fromChallengeCreepCo(petCo)

						local petMo = fPowerPet:toBaseBagPetMo()

						petMo.isSupportedPet = true
						mo = petMo
					end
				end

				table.insert(teamMo, mo)
			end
		end
	end

	return teamMo
end

function ElementSparkController:setForms()
	local forms = ElementSparkModel.instance:getMyFormInfo()
	local attackNum = ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_TEAM_NUM", true)
	local defenseNum = ElementSparkConfig.instance:getCommonCfgByKey("GUARD_TEAM_NUM", true)

	if not forms.attackForms then
		if not forms.defenseForms then
			local defenseForms = {}
			local teamForms = {}

			for i = 1, attackNum do
				local form

				table.insert(teamForms, (forms.attackForms[i] or nil) and self:getAttackTeamInfoById(i).form)
			end

			for i = 1, defenseNum do
				local form

				table.insert(teamForms, (defenseForms[i] or nil) and self:getDefenseTeamInfoById(i).form)
			end

			return teamForms
		end
	end
end

function ElementSparkController:openElementSparkSetForm(activityId, teamId, isSetTeam, chunkId, challengeType)
	local customFmtMo = ElementSparkModel.instance:getChallengeFmtMo()

	customFmtMo:initParams(activityId, teamId, isSetTeam, chunkId, challengeType)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function ElementSparkController:getBelongMeChunkDesc()
	local planId = self:getMapPlanId()
	local mapInfo = ElementSparkModel.instance:getMapInfo()
	local belongCount = 0
	local starCount = {}
	local sparkCount = 0

	for i, v in pairs(mapInfo) do
		local belongMe = ElementSparkModel.instance:getChunlBelongMe(v.chunkId)
		local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, v.chunkId)

		if belongMe then
			if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Spark then
				belongCount = belongCount + 1
				sparkCount = sparkCount + 1
			elseif chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Guard then
				belongCount = belongCount + 1
				starCount[chunkCfg.star] = starCount[chunkCfg.star] or {
					star = 0,
					count = 0
				}
				starCount[chunkCfg.star].star = chunkCfg.star
				starCount[chunkCfg.star].count = starCount[chunkCfg.star].count + 1
			end
		end
	end

	local list = table.values(starCount)

	table.sort(list, function(a, b)
		return a.star < b.star
	end)

	local chunkStr = ""

	for i, v in ipairs(list) do
		chunkStr = chunkStr .. string.format("%s星地块%s个,", v.star, v.count)
	end

	local resourceData = self:getResourceInfo()
	local resourceCount = #resourceData
	local totalCount = belongCount + sparkCount

	return (string.format("占领地块数量%s个：%s资源地%s个,龙裔%s个", totalCount, chunkStr, resourceCount, sparkCount))
end

function ElementSparkController:getTagId(chunkId, signId)
	local tagInfo = ElementSparkModel.instance:getTagInfo(chunkId)

	if tagInfo and tagInfo.signId == signId then
		return tagInfo.tagId
	end

	return -1
end

function ElementSparkController:getDefenseChunkId2TeamId()
	local chunkId2TeamId = {}
	local forms = ElementSparkModel.instance:getMyFormInfo()

	if not forms.defenseForms then
		for i, v in ipairs(forms.defenseForms) do
			if v.defenseChunkId > 0 then
				chunkId2TeamId[v.defenseChunkId] = v.teamId
			end
		end

		return chunkId2TeamId
	end
end

function ElementSparkController:setDefensePetIcon(iconGo, chunkId)
	local chunkId2TeamId = ElementSparkModel.instance:getDefenseChunkId2TeamId()
	local teamId = chunkId2TeamId[chunkId]

	if not teamId then
		return false
	end

	local info = ElementSparkController.instance:getDefenseTeamInfoById(teamId - 100)

	if info.form then
		for i, petId in ipairs(info.form.pos) do
			if petId > 0 then
				local petMo = BagPetsController.instance:getPet(petId)
				local raceId = 0

				if not petMo then
					local supportCfg = ElementSparkConfig.instance:getSupportPetCfg(petId)

					if supportCfg then
						raceId = supportCfg.raceId
					end
				else
					raceId = petMo.raceId
				end

				if raceId > 0 then
					MaterialMgr.setIcon(iconGo, MatType.Pet, raceId)

					return true
				end
			end
		end
	end

	return false
end

function ElementSparkController:getTopName()
	self:setActivityId()

	local stageType = ElementSparkController.instance:getActivityStage()

	if stageType == GameEnum.ElementSparkStageType.Signup then
		return "开启报名"
	end

	return nil
end

ElementSparkController.instance = ElementSparkController.New()

return ElementSparkController
