-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/controller/FireworkController.lua

module("logic.extensions.firework.controller.FireworkController", package.seeall)

local FireworkController = class("FireworkController", BaseController)

function FireworkController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.PM_FIREWORK_GETINFO, self._startLogic, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_FIREWORK_FIREONE, self._onRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.ColorfulEggsData, self._onEggOver, self)
	ClockMgr.instance:addListener(ClockMgr.TickDay, self._initTimeData, self)

	self.curActId = FireworkModel.instance.curActId
	self.curTimeId = nil
	self.lastTimeId = 1
	self.startTimes = {}
	self.overTimes = {}
end

function FireworkController:onReset()
	self._isStart = false

	removetimer(self.checkTime, self)
end

function FireworkController:_startLogic()
	if self._isStart then
		return
	end

	self._isStart = true

	self:_initTimeData()
	self:checkTime()
	settimer(10, self.checkTime, self, true)
end

function FireworkController:_onEggOver(eggId)
	local eggCo = ColorfulEggConfig.instance:getColorfulEggCo(eggId)

	if not eggCo.npcId then
		return
	end

	if eggCo.idle_strategy ~= "3_idle" then
		return
	end

	self:checkTime()

	if not self.curTimeId then
		FloatWordMgr.instance:show("烟花盛典已结束")

		return
	end

	local sceneId = FireworkConfig.instance:getSceneTimeCfgs(self.curActId, self.curTimeId).sceneId
	local scene = SceneMgr.instance:getCurScene()
	local curSceneId = scene and scene:getSceneId() or 0

	if sceneId ~= checknumber(curSceneId) then
		FloatWordMgr.instance:show("烟花已刷新，请到活动界面中重新前往盛典场景")

		return
	end

	local npcId = checknumber(eggCo.npcId[1])
	local id = FireworkConfig.instance:getIdByNpcId(self.curActId, self.curTimeId, npcId)

	if not id then
		return
	end

	local isFire = FireworkModel.instance:isNpcFireOver(self.curTimeId, id)

	if isFire then
		return
	end

	FireworkController.instance:setOff(self.curTimeId, id)
end

function FireworkController:_onRefreshData(msg)
	local times = checknumber(msg.cirticalTimes)

	for i = 1, times do
		FloatWordMgr.instance:show(string.format("暴击%d倍！烟花积分+1~", times))
	end
end

function FireworkController:checkTime()
	local curTime = ServerTime.now()
	local addId, removeId = 0, #self.startTimes

	for i, start in ipairs(self.startTimes) do
		local over = self.overTimes[i]

		if curTime < start then
			break
		elseif start <= curTime and curTime <= over then
			addId = i

			break
		elseif over < curTime then
			removeId = i
		end
	end

	if addId > 0 and self.curTimeId ~= addId then
		self.curTimeId = addId
		self.lastTimeId = addId

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_HUD_FIREWORK, FireworkModel.instance:isHaveTimes(), nil, self.startTimes[self.curTimeId], self.overTimes[self.curTimeId])
	end

	if addId == 0 and self.curTimeId == removeId then
		self.curTimeId = nil
		self.lastTimeId = removeId

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_HUD_FIREWORK, false, nil, 0, 0)
	end

	print("-----------checkTime", self.curTimeId, addId, removeId, GameUtil.formatTimeStamp("%m.%d %H:%M", curTime))
end

function FireworkController:_initTimeData()
	local cfgs = FireworkConfig.instance:getSceneTimeCfgs(self.curActId)

	for i, v in ipairs(cfgs) do
		local openTime = string.split(v.openTime, "-")

		self.startTimes[v.id] = GameUtil.string2time("0-0-0 " .. openTime[1])
		self.overTimes[v.id] = GameUtil.string2time("0-0-0 " .. openTime[2])
	end
end

function FireworkController:getInfo()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FireWork) or 145004

	FireworkModel.instance:setActivityId(activityId)

	local inAct = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FireWork, activityId)

	if not inAct then
		return
	end

	FireWorksDisplayAgent.instance:sendPM_FireWorksDisplayGetInfoReq(activityId)
end

function FireworkController:setOff(timeId, npcId)
	local activityId = FireworkModel.instance.curActId

	if not FireworkModel.instance:isHaveTimes() then
		FloatWordMgr.instance:show(string.format("今日烟花燃放次数已达上限~"))

		return
	end

	FireWorksDisplayAgent.instance:sendPM_FireWorksDisplaySetOffReq(activityId, timeId, npcId)
end

function FireworkController:gainNormalPrize(index)
	local activityId = FireworkModel.instance.curActId

	FireWorksDisplayAgent.instance:sendPM_FireWorksDisplayGainNormalPrizeReq(activityId, index)
end

function FireworkController:gainWorldPrize(index)
	local activityId = FireworkModel.instance.curActId

	FireWorksDisplayAgent.instance:sendPM_FireWorksDisplayGainWorldPrizeReq(activityId, index)
end

FireworkController.instance = FireworkController.New()

return FireworkController
