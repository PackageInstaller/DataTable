-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/controller/MagicSchoolController.lua

module("logic.extensions.magicschool.controller.MagicSchoolController", package.seeall)

local MagicSchoolController = class("MagicSchoolController", BaseController)

MagicSchoolController.FIRST_ENTER_HUD_KEY = "MagicSchoolController_%s"

function MagicSchoolController:onInit()
	self:onReset()
end

function MagicSchoolController:getMagicSchoolActIdInTime()
	return (ActivityDefineController.instance:getActivityIdByType(514))
end

function MagicSchoolController:onReset()
	self.hasOpenedInvitedCard = false
	self._chooseCampParams = nil

	GlobalDispatcher:removeListener(GlobalNotify.PM_MagicSchoolGetInfoRes, self._dealOutsideAskCampInfo, self)
	GlobalDispatcher:addListener("ongotomagicschoollevelrewardview", self._onGotoMagicSchoolLevelRewardView, self)
end

function MagicSchoolController:sendSartGameMagicSchoolGetInfoReq()
	local activityId = ActivityDefineController.instance:getActivityIdByType(514)

	if activityId > 0 then
		MagicSchoolAgent.instance:sendPM_MagicSchoolGetInfoReq(activityId)
	end
end

function MagicSchoolController:sendPM_MagicSchoolGetInfoReq(activityId)
	MagicSchoolAgent.instance:sendPM_MagicSchoolGetInfoReq(activityId)
end

function MagicSchoolController:handlePM_MagicSchoolGetInfoRes(status, msg)
	if status == 0 then
		MagicSchoolModel.instance:handlePM_MagicSchoolGetInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_MagicSchoolGetInfoRes, status, msg)
end

function MagicSchoolController:sendPM_MagicSchoolVisitReq(activityId, prizeId)
	MagicSchoolAgent.instance:sendPM_MagicSchoolVisitReq(activityId, prizeId)
end

function MagicSchoolController:handlePM_MagicSchoolVisitRes(msg)
	MagicSchoolModel.instance:handlePM_MagicSchoolVisitRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MagicSchoolVisitRes)
end

function MagicSchoolController:sendPM_MagicSchoolJoinCampReq(activityId)
	MagicSchoolAgent.instance:sendPM_MagicSchoolJoinCampReq(activityId)
end

function MagicSchoolController:handlePM_MagicSchoolJoinCampRes(status, msg)
	if status == 0 then
		MagicSchoolModel.instance:handlePM_MagicSchoolJoinCampRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_MagicSchoolJoinCampRes, status)
end

function MagicSchoolController:sendPM_MagicSchoolSelectBuffReq(activityId, buffId)
	MagicSchoolAgent.instance:sendPM_MagicSchoolSelectBuffReq(activityId, buffId)
end

function MagicSchoolController:handlePM_MagicSchoolSelectBuffRes(msg)
	MagicSchoolModel.instance:handlePM_MagicSchoolSelectBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MagicSchoolSelectBuffRes)
end

function MagicSchoolController:sendPM_MagicSchoolGainLevelPrizeReq(activityId, level)
	MagicSchoolAgent.instance:sendPM_MagicSchoolGainLevelPrizeReq(activityId, level)
end

function MagicSchoolController:handlePM_MagicSchoolGainLevelPrizeRes(msg)
	MagicSchoolModel.instance:handlePM_MagicSchoolGainLevelPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MagicSchoolGainLevelPrizeRes)
end

function MagicSchoolController:sendPM_MagicSchoolChallengeReq(activityId, stageId, form)
	MagicSchoolAgent.instance:sendPM_MagicSchoolChallengeReq(activityId, stageId, form)
end

function MagicSchoolController:enterBattleClg(activityId, campId, stageId)
	local customFmtMo = MagicSchoolModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, campId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function MagicSchoolController:hasVisitAll(activityId)
	local prizeCfgs = MagicSchoolConfig.instance:getPrizeCfg(activityId)
	local info = MagicSchoolModel.instance:getInfo(activityId)
	local totalVisitNum = #prizeCfgs
	local hasVisitNum = #info.invitePrizeIds

	return totalVisitNum <= hasVisitNum
end

function MagicSchoolController:getPlayerLevel(activityId, campId)
	local info = MagicSchoolModel.instance:getInfo(activityId)
	local score = checknumber(info.score)
	local levelCfgs = MagicSchoolConfig.instance:getLevelPrizeCfgs(activityId, campId)

	for i, levelCfg in ipairs(levelCfgs) do
		if score < levelCfg.progress then
			return levelCfg.level - 1
		end
	end

	return #levelCfgs
end

function MagicSchoolController:canPlayAfterFinishChooseCamp(activityId, successCallBack, failCallBack, cancelCallBack)
	local info = MagicSchoolModel.instance:getInfo(activityId)

	if info == nil then
		self._chooseCampParams = {
			successCallBack = successCallBack,
			failCallBack = failCallBack,
			cancelCallBack = cancelCallBack
		}

		GlobalDispatcher:addListener(GlobalNotify.PM_MagicSchoolGetInfoRes, self._dealOutsideAskCampInfo, self)
		self:sendPM_MagicSchoolGetInfoReq(activityId)
	else
		self:_doCampSelect(activityId, successCallBack, failCallBack, cancelCallBack)
	end
end

function MagicSchoolController:_dealOutsideAskCampInfo(status, msg)
	local params = self._chooseCampParams

	self._chooseCampParams = nil

	GlobalDispatcher:removeListener(GlobalNotify.PM_MagicSchoolGetInfoRes, self._dealOutsideAskCampInfo, self)

	if status ~= 0 then
		return
	end

	if params then
		self:_doCampSelect(msg.activityId, params.successCallBack, params.failCallBack, params.cancelCallBack)
	else
		self:_doCampSelect(msg.activityId, nil, nil, nil)
	end
end

function MagicSchoolController:_doCampSelect(activityId, successCallBack, failCallBack, cancelCallBack)
	local info = MagicSchoolModel.instance:getInfo(activityId)
	local campId = info.campId
	local actCfg = MagicSchoolConfig.instance:getActCfg(activityId)
	local result = true
	local hasVisitAll = self:hasVisitAll(activityId)
	local acceptInvite = info.acceptInvite

	if not acceptInvite and not self.hasOpenedInvitedCard then
		TipsFacade.instance:openPopupWindow(lang("tip"), "尚未接受邀请函，接受并拜访完所有院长后可选择阵营", function()
			UIStateManager.instance:push(ViewName.MagicSchoolMainView, activityId)
			UIStateManager.instance:push(ViewName.InvitationCardView, actCfg.activitySummaryId)
		end, function()
			GameUtil.callBack(cancelCallBack)
		end)
	elseif not hasVisitAll then
		result = false

		TipsFacade.instance:openPopupWindow(lang("tip"), "尚未拜访完所有院长，拜访后可选择阵营", function()
			UIStateManager.instance:push(ViewName.MagicSchoolMainView, activityId)
		end, function()
			GameUtil.callBack(cancelCallBack)
		end)
	elseif campId == 0 then
		result = false

		TipsFacade.instance:openPopupWindow(lang("tip"), "尚未选择阵营，请先选择阵营", function()
			UIStateManager.instance:push(ViewName.MagicSchoolChooseView, activityId)
		end, function()
			GameUtil.callBack(cancelCallBack)
		end)
	end

	if result == true then
		GameUtil.callBack(successCallBack)
	else
		GameUtil.callBack(failCallBack)
	end
end

function MagicSchoolController:getBuffStr(activityId, campId)
	local buffCfgs = MagicSchoolConfig.instance:getBuffCfgsByCampId(activityId, campId)
	local curLv = MagicSchoolController.instance:getPlayerLevel(activityId, campId)
	local finalStr = ""

	for i, buffCfg in ipairs(buffCfgs) do
		if curLv >= buffCfg.unlockLv then
			local curBuffStr = string.format("\n%s", buffCfg.desc)

			finalStr = finalStr .. curBuffStr
		end
	end

	return finalStr
end

function MagicSchoolController:getChangeCampDays(activityId)
	local timeStampList = {}
	local data = MagicSchoolConfig.instance:getActCfg(activityId)
	local day = data.changeCampDays

	if day > 0 then
		local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
		local startTime, endTime = ActivityDefineController:getStartTimeAndEndTime(activityType, activityId)
		local durationStamp = (day - 1) * 24 * 60 * 60
		local switchTime = startTime + durationStamp

		while switchTime <= endTime do
			local switchDate = GameUtil.time2date(switchTime)
			local switchTimestamp = GameUtil.date2time(switchDate.year, switchDate.month, switchDate.day, GameUtil.SERVER_TICK_DAILYR_EFRESH, 0, 0)

			if startTime <= switchTimestamp and switchTimestamp <= endTime then
				table.insert(timeStampList, switchTimestamp)
			end

			switchTime = switchTime + durationStamp
		end

		table.insert(timeStampList, endTime)
	end

	return timeStampList
end

function MagicSchoolController:handlePM_Notify_MagicSchoolChallengeResult(msg)
	if msg.win then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MagicSchoolModel.instance:pushChangeSetId(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_MagicSchoolChallengeResult)
end

function MagicSchoolController:_onGotoMagicSchoolLevelRewardView(param)
	local actId = checknumber(param[1])

	GlobalDispatcher:addListener(GlobalNotify.PM_MagicSchoolGetInfoRes, self._getGotoMagicSchoolLevelRewardViewInfo, self)

	local info = MagicSchoolModel.instance:getInfo(actId)

	if info == nil then
		self:sendPM_MagicSchoolGetInfoReq(checknumber(actId))

		return
	else
		GlobalDispatcher:removeListener(GlobalNotify.PM_MagicSchoolGetInfoRes, self._getGotoMagicSchoolLevelRewardViewInfo, self)
	end

	local campId = info and info.campId

	if checknumber(campId) > 0 then
		UIStateManager.instance:push(ViewName.MagicSchoolLevelRewardView, actId)
	else
		FloatWordMgr.instance:show("尚未选择阵营，请先选择阵营")

		return
	end
end

function MagicSchoolController:_getGotoMagicSchoolLevelRewardViewInfo(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MagicSchoolGetInfoRes, self._getGotoMagicSchoolLevelRewardViewInfo, self)

	local campId = msg and msg.campId

	if checknumber(campId) > 0 then
		UIStateManager.instance:push(ViewName.MagicSchoolLevelRewardView, msg.activityId)
	else
		FloatWordMgr.instance:show("尚未选择阵营，请先选择阵营")

		return
	end
end

function MagicSchoolController:setOpenedInvitedCard(hasOpen)
	self.hasOpenedInvitedCard = hasOpen
end

function MagicSchoolController:getOpenedInvitedCard()
	return self.hasOpenedInvitedCard
end

MagicSchoolController.instance = MagicSchoolController.New()

return MagicSchoolController
