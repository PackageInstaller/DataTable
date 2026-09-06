-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/controller/UltimateTrialController.lua

module("logic.extensions.ultimatetrial.controller.UltimateTrialController", package.seeall)

local UltimateTrialController = class("UltimateTrialController", BaseController)

function UltimateTrialController:onInit()
	self:onReset()
end

function UltimateTrialController:onReset()
	GlobalDispatcher:addListener("gotofirstpassrankview", self._gotoFirstPassRankView, self)
end

function UltimateTrialController:sendPM_UltimateTrialGetInfoReq(activityId)
	UltimateTrialAgent.instance:sendPM_UltimateTrialGetInfoReq(activityId)
end

function UltimateTrialController:handlePM_UltimateTrialGetInfoRes(msg)
	local mo = self:getTrialMo(msg.activityId)

	mo:handlePM_UltimateTrialGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateTrialGetInfoRes)
end

function UltimateTrialController:sendPM_UltimateTrialSignInReq(activityId)
	UltimateTrialAgent.instance:sendPM_UltimateTrialSignInReq(activityId)
end

function UltimateTrialController:handlePM_UltimateTrialSignInRes(msg)
	local mo = self:getTrialMo(msg.activityId)

	mo:handlePM_UltimateTrialSignInRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateTrialSignInRes)
end

function UltimateTrialController:sendPM_UltimateTrialGetTimeRankViewReq(activityId, clgActId)
	UltimateTrialAgent.instance:sendPM_UltimateTrialGetTimeRankViewReq(activityId, clgActId)
end

function UltimateTrialController:handlePM_UltimateTrialGetTimeRankViewRes(msg)
	local mo = self:getTrialMo(msg.activityId)

	mo:handlePM_UltimateTrialGetTimeRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateTrialGetTimeRankViewRes, msg)
end

function UltimateTrialController:sendPM_UltimateTrialGetScoreRankViewReq(activityId, clgActId)
	UltimateTrialAgent.instance:sendPM_UltimateTrialGetScoreRankViewReq(activityId, clgActId)
end

function UltimateTrialController:handlePM_UltimateTrialGetScoreRankViewRes(msg)
	local mo = self:getTrialMo(msg.activityId)

	mo:handlePM_UltimateTrialGetScoreRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateTrialGetScoreRankViewRes, msg)
end

function UltimateTrialController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function UltimateTrialController:getActivityType()
	return GameEnum.ActivityType.UltimateTrial
end

function UltimateTrialController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function UltimateTrialController:getTrialMo(activityId)
	return UltimateTrialModel.instance:getTrialMo(activityId)
end

function UltimateTrialController:isInUltTrialTime(clgActId)
	local result = false
	local dataList = UltimateTrialConfig.instance:getChallengeDataListByClgId(clgActId)

	if dataList then
		for _, data in ipairs(dataList) do
			if self:isInActivityTime(data.activityId) and GameUtil.getTimePeriod(data.limitStartTime, nil) == GameUtil.inTimePeriod then
				result = true

				break
			end
		end
	end

	return result
end

function UltimateTrialController:isUltTrialClg(clgActId)
	local dataList = UltimateTrialConfig.instance:getChallengeDataListByClgId(clgActId)

	return dataList and #dataList > 0
end

function UltimateTrialController:getMode(activityId, clgActId)
	local data = UltimateTrialConfig.instance:getChallengeData(activityId, clgActId)

	return (data or nil) and (data.mode or 0)
end

function UltimateTrialController:getFmtExtraPercent(activityId, clgActId)
	local mo = self:getTrialMo(activityId)
	local day = mo:getCurSignDay()
	local propsData = UltimateTrialConfig.instance:getSystemPropsData(activityId, day)

	if propsData then
		if not propsData.extraPercent then
			local extraPercent = 0

			return extraPercent / 100
		end
	end
end

function UltimateTrialController:isBanInUltTrialClg(isShowTips, clgActId)
	if self:isUltTrialClg(clgActId) then
		local result = UltimateTrialController.instance:getTryResultAndTipsEnterUltClg(isShowTips, clgActId)

		if result ~= GameEnum.ResultCode.Success then
			return true
		end
	end

	return false
end

function UltimateTrialController:getTryResultAndTipsEnterUltClg(isShowTips, clgActId)
	local result = GameEnum.ResultCode.Success
	local tips

	if result == GameEnum.ResultCode.Success and not self:isInUltTrialTime(clgActId) then
		result = GameEnum.ResultCode.Error
		tips = "不在神炼时间范围内"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateTrialController:getTryResultAndTipsSignInBuff(isShowTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips

	if result == GameEnum.ResultCode.Success and not UltimateTrialController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	local trialMo = self:getTrialMo(activityId)

	if result == GameEnum.ResultCode.Success and trialMo:isHasSignInToday() then
		result = GameEnum.ResultCode.Error
		tips = "已签到"
	end

	if result == GameEnum.ResultCode.Success then
		local signDay = trialMo:getSignInDays()
		local maxDay = trialMo:getMaxSignDay()

		if maxDay <= signDay then
			result = GameEnum.ResultCode.Error
			tips = "已满级"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateTrialController:getCurActiveRankCfgs()
	local datalist = {}
	local cfgs = UltimateTrialConfig.instance:getAllFirstPassRankChallengeCfs() or {}

	for i, cfg in ipairs(cfgs) do
		if GameUtil.getTimePeriod(cfg.startTime, cfg.endTime) == GameUtil.inTimePeriod then
			table.insert(datalist, cfg)
		end
	end

	return datalist
end

function UltimateTrialController:sendPM_GetFirstPassRankViewReq(activityId)
	CommonRankAgent.instance:sendPM_GetFirstPassRankViewReq(activityId)
end

function UltimateTrialController:handlePM_GetFirstPassRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandleGetFirstPassRankViewRes, msg)
end

function UltimateTrialController:_gotoFirstPassRankView(params)
	self:gotoFirstPassRankView(checknumber(params[1]))
end

function UltimateTrialController:gotoFirstPassRankView(activityId)
	local cfgs = UltimateTrialConfig.instance:getAllFirstPassRankChallengeCfs() or {}
	local leafId = 0

	for i, cfg in ipairs(cfgs) do
		if GameUtil.getTimePeriod(cfg.startTime, cfg.endTime) == GameUtil.inTimePeriod then
			leafId = leafId + 1

			if cfg.challengeActivityId == activityId then
				UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.PetChallengeFirstPassRank, leafId)

				return
			end
		end
	end

	local cfg = UltimateTrialConfig.instance:getFirstPassRankChallengeCfg(activityId)

	if cfg then
		local dateOpen = GameUtil.string2date(cfg.startTime)
		local dateEnd = GameUtil.string2date(cfg.endTime)

		TipsFacade.instance:openCommonTips(string.format("%s.%02d.%02d-%s.%02d.%02d开启", dateOpen.year, dateOpen.month, dateOpen.day, dateEnd.year, dateEnd.month, dateEnd.day))

		return
	end

	TipsFacade.instance:openCommonTips("排行榜未在活动时间")
end

UltimateTrialController.instance = UltimateTrialController.New()

return UltimateTrialController
