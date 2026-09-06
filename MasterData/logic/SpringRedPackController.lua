-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/controller/SpringRedPackController.lua

module("logic.extensions.springredpack.controller.SpringRedPackController", package.seeall)

local SpringRedPackController = class("SpringRedPackController", BaseController)

function SpringRedPackController:ctor()
	self._funcId = checknumber(SpringRedPackConfig.instance:getConstValue("EDITION_FUNC"))
end

function SpringRedPackController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateData, self)
end

function SpringRedPackController:onReset()
	self._isEnterGame = false

	removetimer(self._onSecond, self)
end

function SpringRedPackController:_onStartEnterGame()
	self._isEnterGame = true

	settimer(1, self._onSecond, self)
end

function SpringRedPackController:_updateData()
	local activityId = SpringRedPackModel.instance:getCurActivityId()

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.SpringRedPack, activityId) == true then
		SpringRedPackAgent.instance:sendPM_GetRedPackInfoReq(activityId)
	end

	if ViewMgr.instance:isOpen(ViewName.SpringRedPackSelectView) then
		ViewMgr.instance:close(ViewName.SpringRedPackSelectView)
	end

	if ViewMgr.instance:isOpen(ViewName.SpringRedPackPopView) then
		ViewMgr.instance:close(ViewName.SpringRedPackPopView)
	end
end

function SpringRedPackController:_onSecond()
	if self._isEnterGame and self:isInActivityTime() then
		local activityId = SpringRedPackModel.instance:getCurActivityId()
		local cfg = SpringRedPackConfig.instance:getActivityCfg(activityId)

		if cfg then
			local noticeTime = cfg.noticeTime
			local durationSec = cfg.durationSec
			local list = SpringRedPackConfig.instance:getRoundCfgList(activityId)
			local curTime = ServerTime.now()

			for i, v in ipairs(list) do
				local beginTime = GameUtil.string2time(v.roundBeginTime)
				local preTime = beginTime - noticeTime
				local endTime = beginTime + durationSec

				if curTime < preTime then
					SpringRedPackModel.instance:setCurRedPackState(SpringRedPackModel.None, v.roundId)

					break
				elseif preTime <= curTime and curTime < beginTime then
					SpringRedPackModel.instance:setCurRedPackState(SpringRedPackModel.Countdown, v.roundId)

					break
				elseif beginTime <= curTime and curTime < endTime then
					SpringRedPackModel.instance:setCurRedPackState(SpringRedPackModel.StartRedPack, v.roundId)

					break
				elseif endTime <= curTime then
					SpringRedPackModel.instance:setCurRedPackState(SpringRedPackModel.None, v.roundId)
				end
			end
		end
	end
end

function SpringRedPackController:isInActivityTime()
	local isFuncOpen = FuncOpenModel.instance:getFuncIsOpen(self._funcId)

	if not isFuncOpen then
		return false
	end

	local activityId = SpringRedPackModel.instance:getCurActivityId()
	local cfg = SpringRedPackConfig.instance:getActivityCfg(activityId)

	if cfg then
		local timeList = string.split(cfg.dailyTime, ",")

		for i, v in ipairs(timeList) do
			local rangeList = string.split(v, "#")

			if rangeList[1] and rangeList[2] and GameUtil.checkIsInTimePeriod(rangeList[1], rangeList[2]) then
				return true
			end
		end

		return false
	else
		return false
	end
end

SpringRedPackController.instance = SpringRedPackController.New()

return SpringRedPackController
