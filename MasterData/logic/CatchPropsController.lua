-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/controller/CatchPropsController.lua

module("logic.extensions.catchprops.model.CatchPropsController", package.seeall)

local CatchPropsController = class("CatchPropsController", BaseController)

function CatchPropsController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._resetDailyActivity, self)
end

function CatchPropsController:onReset()
	self._clientKey = 0
	self._endGameChangesetId = 0
end

function CatchPropsController:getGameChangesetId()
	return self._endGameChangesetId
end

function CatchPropsController:openActivityView()
	if not self:isActivityOpended() then
		return
	end

	self:setCurrActivityId()
	UIStateManager.instance:push(ViewName.CatchPropsView)
end

function CatchPropsController:isActivityOpended()
	return self:getActivityId() ~= 0
end

function CatchPropsController:getActivityId()
	local activities = CatchPropsConfig.instance:getActivities()

	for i = 1, #activities do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.CatchProps, activities[i].activityId) then
			return activities[i].activityId
		end
	end

	return 0
end

function CatchPropsController:setCurrActivityId()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		CatchPropsModel.instance:setActivityId(0)
		CatchPropsModel.instance:setActivityInfo()

		return
	end

	local activityId = CatchPropsModel.instance:getActivityId()

	if activityId == currActivityId then
		return
	end

	CatchPropsModel.instance:setActivityId(currActivityId)
end

function CatchPropsController:requestActivityInfo()
	local currActivityId = self:getActivityId()

	if currActivityId == 0 then
		CatchPropsModel.instance:setActivityId(0)
		CatchPropsModel.instance:setActivityInfo()

		return
	end

	local activityId = CatchPropsModel.instance:getActivityId()
	local isActivityDataReady = CatchPropsModel.instance:isActivityDataReady()

	if activityId == currActivityId and isActivityDataReady then
		return
	end

	CatchPropsModel.instance:setActivityId(currActivityId)
	MoYanPreheatAgent.instance:sendPM_MoYanPreheatGetInfoReq(currActivityId)
end

function CatchPropsController:onMoYanPreheatGetInfo(msg)
	CatchPropsModel.instance:setActivityInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsInfo)
end

function CatchPropsController:sendPM_MoYanPreheatUnlockReq(activityId, zoneId)
	self._lastUnlockAcId = activityId
	self._lastUnlockZoneId = zoneId

	MoYanPreheatAgent.instance:sendPM_MoYanPreheatUnlockReq(activityId, zoneId)
end

function CatchPropsController:onMoYanPreheatUnlock(msg)
	if self._lastUnlockAcId == 0 then
		return
	end

	local activityId = self._lastUnlockAcId
	local zoneId = self._lastUnlockZoneId

	self._lastUnlockAcId = 0
	self._lastUnlockZoneId = 0

	if activityId ~= CatchPropsModel.instance:getActivityId() then
		return
	end

	CatchPropsModel.instance:onUnlockFragment(zoneId)
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsUnlockZone, zoneId)
end

function CatchPropsController:onMoYanPreheatBuyTimes(msg)
	CatchPropsModel.instance:onMoYanPreheatBuyTimes(msg.buyTimes)
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsBuyGameTimes)
end

function CatchPropsController:startCatchPropsGame()
	math.randomseed(os.time())

	self._clientKey = math.random(1, 100)

	MoYanPreheatAgent.instance:sendPM_MoYanPreheatStartGameReq(CatchPropsModel.instance:getActivityId(), self._clientKey)
end

function CatchPropsController:onMoYanPreheatStartGame(msg)
	if self._clientKey ~= msg.clientKey then
		return
	end

	CatchPropsModel.instance:setGamePropsNum(0)
	CatchPropsModel.instance:setGamingTime(CatchPropsConfig.instance:getOneGamePlayTime())

	self._serverkey = msg.serverKey

	UIStateManager.instance:push(ViewName.CatchPropsGameView)
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsGameStart)
end

function CatchPropsController:_resetDailyActivity()
	CatchPropsModel.instance:resetDailyActivity()
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsDailyReset)
end

function CatchPropsController:sendPM_MoYanPreheatEndGameReq()
	local fragransNum = CatchPropsModel.instance:getGamePropsNum()
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverkey, {
		fragransNum
	})

	MoYanPreheatAgent.instance:sendPM_MoYanPreheatEndGameReq(fragransNum, encryptedKey)
end

function CatchPropsController:onMoYanPreheatEndGame(msg)
	CatchPropsModel.instance:onMoYanPreheatEndGame()
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self._endGameChangesetId = msg.changeSetId

	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsGameEnd)

	if LuckyMoneyController.instance:isInActivityTime() then
		local score = CatchPropsModel.instance:onGetGameScore()
		local luckyMoneyActId = LuckyMoneyController.instance:getActivityId()

		LuckyMoneyController.instance:sendPM_LuckyMoneyActEndReq(luckyMoneyActId, score)
		ViewMgr.instance:open(ViewName.LuckyMoneyResultView)
	else
		ViewMgr.instance:open(ViewName.CatchPropsResultView)
	end
end

function CatchPropsController:onGetScore(score)
	CatchPropsModel.instance:onGetGameProps(score)
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsAddScores, score)
end

function CatchPropsController:onGetTime(time)
	CatchPropsModel.instance:onGetGamingTime(time)
	GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsAddTime, time)
end

CatchPropsController.instance = CatchPropsController.New()

return CatchPropsController
