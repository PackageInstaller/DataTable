-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/FirePowerContestHandler.lua

module("logic.extensions.firepowercontest.game.FirePowerContestHandler", package.seeall)

local FirePowerContestHandler = class("FirePowerContestHandler")

FirePowerContestHandler.ST_None = 1
FirePowerContestHandler.ST_Matching = 2
FirePowerContestHandler.ST_Preparing = 3
FirePowerContestHandler.ST_Playing = 4
FirePowerContestHandler.ST_End = 5

function FirePowerContestHandler:ctor()
	if FirePowerContestConfig.debugClient then
		self._state = FirePowerContestHandler.ST_Preparing
		self._debugGroup = {
			{
				curId = 1,
				curStage = 1
			},
			{
				curId = 2,
				curStage = 1
			},
			{
				curId = 3,
				curStage = 1
			},
			{
				curId = 1,
				curStage = 3
			},
			{
				curId = 2,
				curStage = 3
			},
			{
				curId = 3,
				curStage = 3
			},
			{
				curId = 4,
				curStage = 3
			},
			{
				curId = 5,
				curStage = 3
			},
			{
				curId = 1,
				curStage = 5
			},
			{
				curId = 2,
				curStage = 5
			},
			{
				curId = 3,
				curStage = 5
			},
			{
				curId = 4,
				curStage = 5
			}
		}
		self._debugGroupIndex = 1
	else
		self._state = FirePowerContestHandler.ST_None
	end

	self.data = FirePowerContestData.New()
end

function FirePowerContestHandler:isState(value)
	return self._state == value
end

function FirePowerContestHandler:setState(value)
	self._state = value

	if self._state == FirePowerContestHandler.ST_None then
		FirePowerContestController.instance:reqDisposeGame()

		if FirePowerContestController.instance:getIsTourArenaMode() then
			-- block empty
		end
	end
end

function FirePowerContestHandler:reqLeaveGame()
	self.data.isLeaving = true

	if self:isState(FirePowerContestHandler.ST_Playing) then
		if not FirePowerContestConfig.debugClient then
			FirePowerContestAgent.instance:sendPM_FPCLeaveGameReq()
		else
			self.data.isSelfLeave = true

			self:reqEndGame()
		end
	else
		FloatWordMgr.instance:show(lang("FirePowerContestHandler__1"))
	end
end

function FirePowerContestHandler:reqEnterGame()
	if self:isState(FirePowerContestHandler.ST_Preparing) then
		if FirePowerContestConfig.debugClient then
			local group = self._debugGroup[self._debugGroupIndex]

			FirePowerContestController.instance:handleNofityGameStart(0, {
				curStage = group.curStage,
				curId = group.curId,
				startTime = ServerTime.nowMs(),
				itemInfo = {}
			})
		else
			FirePowerContestAgent.instance:sendPM_FPCGameBeginReq()
		end

		self:setState(FirePowerContestHandler.ST_Playing)
	else
		FloatWordMgr.instance:show(lang("FirePowerContestHandler__2"))
	end
end

function FirePowerContestHandler:debugNext()
	self._debugGroupIndex = self._debugGroupIndex + 1

	print(".................................." .. tostring(self._debugGroupIndex))

	local group = self._debugGroup[self._debugGroupIndex]

	if group then
		FirePowerContestController.instance:handleNofityGameNext(0, {
			curStage = group.curStage,
			curId = group.curId,
			startTime = ServerTime.nowMs(),
			itemInfo = {}
		})
	end
end

function FirePowerContestHandler:reqEndGame()
	if self:isState(FirePowerContestHandler.ST_Playing) then
		self:setState(FirePowerContestHandler.ST_End)

		local result = FirePowerContestModel.instance:getGameResultAndClear()

		if not result then
			FirePowerContestController.instance:showResultView({
				score = 100,
				winState = 1,
				winTimes = 12,
				iconType = self.data:getIconType(self.data.myUserInfo.userId),
				userName = RoleModel.instance:getUserName(),
				userId = checknumber(LoginModel.instance.userId)
			})
		else
			local winState = 0
			local winerId = checknumber(result.winUserId)

			winState = winerId == checknumber(LoginModel.instance.userId) and 1 or winerId == -1 and -1 or 0

			FirePowerContestController.instance:showResultView({
				winTimes = result.winTimes,
				score = result.score,
				winState = winState,
				iconType = result.iconType,
				userName = RoleModel.instance:getUserName(),
				userId = checknumber(LoginModel.instance.userId)
			})
		end
	else
		FloatWordMgr.instance:show(lang("FirePowerContestHandler__1"))
	end

	FirePowerContestController.instance:reqDisposeGame()
end

function FirePowerContestHandler:dispose()
	UIStateManager.instance:popByName(ViewName.FirePowerContestMatchView)
	UIStateManager.instance:popByName(ViewName.FirePowerContestPrepareView)
	UIStateManager.instance:popByName(ViewName.FirePowerContestGameView)
end

function FirePowerContestHandler:launch(angle, bulletId, launchTimes)
	if not FirePowerContestConfig.debugClient then
		FirePowerContestAgent.instance:sendPM_FPCPreLaunchReq(angle, bulletId, launchTimes)
	end

	self.data:useBullet()
end

function FirePowerContestHandler:hit(bulletId, posId)
	if not FirePowerContestConfig.debugClient then
		FirePowerContestAgent.instance:sendPM_FPCLaunchReq(bulletId, posId)
	end
end

return FirePowerContestHandler
