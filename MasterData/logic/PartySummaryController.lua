-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/controller/PartySummaryController.lua

module("logic.extensions.partysummary.controller.PartySummaryController", package.seeall)

local PartySummaryController = class("PartySummaryController", BaseController)

function PartySummaryController:ctor()
	return
end

function PartySummaryController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onHandTickDailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.ColorfulEggsData, self._onColorfulEggsOver, self)
	GlobalDispatcher:addListener(GlobalNotify.MainUIEntered, self._onMainUIEntered, self)
end

function PartySummaryController:onReset()
	removetimer(self._mainUIEnteredTimer, self)
end

function PartySummaryController:getActivityType()
	return GameEnum.ActivityType.PartyFood
end

function PartySummaryController:_onHandTickDailyRefresh()
	return
end

function PartySummaryController:_onColorfulEggsOver(eggId)
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	local eggCo = ColorfulEggConfig.instance:getColorfulEggCo(eggId)

	if not eggCo.npcId or #eggCo.npcId == 0 then
		return
	end

	local npcId = checknumber(eggCo.npcId[1])
	local temp = PartySummaryModel.instance:getPrizesReceiveByNpcId(npcId)

	if temp == nil or temp.ownLimit == nil then
		FloatWordMgr.instance:show("本轮派对美食已结束！")

		return
	end

	if temp.areaLimit > 0 and temp.areaLimit <= temp.areaCount then
		FloatWordMgr.instance:show(string.format("来晚一步，[%s]已经被抢光啦~", temp.name))

		return
	end

	if temp.ownLimit <= temp.ownCount then
		FloatWordMgr.instance:show(string.format("你今天食用的[%s]已达到上限，不要暴饮暴食哦~", temp.name))

		return
	end

	PotluckDinnerAgent.instance:sendPM_PotluckDinnerGainPrizeReq(npcId, temp.termId)
end

function PartySummaryController:_onMainUIEntered()
	local nowTime = ServerTime.nowDateServerLook()
	local value = checknumber(GameUtil.getUserDayData("ParyFoodUserDayData"))

	if value == nowTime.month * 100 + nowTime.day then
		return
	end

	if not FuncOpenModel.instance:getFuncIsOpen(685) then
		return
	end

	settimer(1, self._mainUIEnteredTimer, self, false)
end

function PartySummaryController:_mainUIEnteredTimer()
	removetimer(self._mainUIEnteredTimer, self)

	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	local allCfgs = PartySummaryConfig.instance:getFoodTermCfgs(actId)

	if allCfgs == nil or #allCfgs == 0 then
		return
	end

	local list = UIStateManager.instance:getCurStacks()

	if list == nil or #list == 0 then
		return
	end

	for i = #list, 1, -1 do
		if list[i] and not string.nilorempty(list[i].state) and list[i].state ~= ViewName.MainUI and ViewSetting.instance:isFullScreen(view) then
			return
		end
	end

	local isPlay = false

	for i = 1, #allCfgs do
		if allCfgs[i] and GameUtil.checkIsInTimePeriod(allCfgs[i].startTime, allCfgs[i].endTime) then
			isPlay = true

			break
		end
	end

	if isPlay then
		AnimationPlayer.play("storyconfig/animations/story_paidui.txt", nil, nil, nil, 1, true, true, nil)

		local nowTime = ServerTime.nowDateServerLook()

		GameUtil.saveUserDayData("ParyFoodUserDayData", nowTime.month * 100 + nowTime.day)
	end
end

function PartySummaryController:openPartyFoodView()
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		FloatWordMgr.instance:show("未达到开启条件！")

		return
	end

	UIStateManager.instance:push(ViewName.PartyFood, actId)
end

function PartySummaryController:csGetPotluckDinnerInfoReq()
	local actId = PartySummaryConfig.instance:getPartyFoodActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	PotluckDinnerAgent.instance:sendPM_PotluckDinnerInfoReq()
end

function PartySummaryController:scSendPotluckDinnerInfo(msg, status)
	PartySummaryModel.instance:scSendPotluckDinnerInfo(msg, status)

	local isRed = PartySummaryModel.instance:getPartyFoodViewRedPoint()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PARTYFOOD, isRed)

	isRed = PartySummaryModel.instance:getPartyFoodViewRedPoint(true)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PARTYFOOD_RED, isRed)
	GlobalDispatcher:dispatch(GlobalNotify.Party_UpdataPartyFoodInfo)
end

function PartySummaryController:csGetPartyGiftGetInfoReq()
	PartyGiftAgent.instance:sendPM_PartyGiftGetInfoReq()
end

function PartySummaryController:scSendPartyGiftGetInfo(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.Party_UpdataPartyGiftInfo, status, msg, false)
end

function PartySummaryController:scSendPartyGiftnotifyGift(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.Party_UpdataPartyGiftInfo, status, msg, true)
end

function PartySummaryController:sendPM_PartyGiftGetInfoReq()
	PartyGiftAgent.instance:sendPM_PartyGiftGetInfoReq()
end

function PartySummaryController:handlePM_PartyGiftGetInfoRes(msg)
	PartySummaryModel.instance:handlePM_PartyGiftGetInfoRes(msg)
end

PartySummaryController.instance = PartySummaryController.New()

return PartySummaryController
