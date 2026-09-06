-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/FirePowerContestData.lua

module("logic.extensions.firepowercontest.game.FirePowerContestData", package.seeall)

local FirePowerContestData = class("FirePowerContestData")

function FirePowerContestData:ctor()
	self._bulletHitCounters = {}
	self.myScore = 0
	self.rivalScore = 0
	self.isSelfLeave = false
	self.isRivalLeave = false
	self.isLeaving = false

	if FirePowerContestConfig.debugClient then
		self:updateUserInfo({
			{
				userId = LoginModel.instance.userId,
				userName = RoleModel.instance:getUserName()
			},
			{
				userName = "AI",
				userId = -1
			}
		})
	end

	self._isSelfHangup = false
	self._isRivalHangup = false
	self.curStage = 0
end

function FirePowerContestData:_randomIcon()
	local result = math.random()

	if result >= 0.5 then
		return 1, 2
	else
		return 2, 1
	end
end

local Width = 372
local Height = 324

function FirePowerContestData:updateStage(msg)
	if self.curStage == 0 then
		self._isSelfHangup = false
		self._isRivalHangup = false
	else
		self._isSelfHangup = self.bulletCount == self.gameStageConf.bulletNum
		self._isRivalHangup = self.rivalBulletCount == self.gameStageConf.bulletNum
	end

	self.curStage = msg.curStage
	self.curId = msg.curId
	self.itemInfoByPosId = {}

	local itemInfos = msg.itemInfo

	for _, itemInfo in ipairs(itemInfos) do
		self.itemInfoByPosId[itemInfo.posId] = itemInfo
	end

	self.startTime = msg.startTime

	local delta = ServerTime.nowMs() - msg.startTime

	self.startTimeClient = UnityEngine.Time.realtimeSinceStartup * 1000 - delta
	self.maxStage = FirePowerContestConfig.instance:getMaxStage()
	self.activityConf = FirePowerContestConfig.instance:getGameActivityConf()
	self.gameStageConf = FirePowerContestConfig.instance:getGameStageConf(self.curStage, self.curId)
	self.pathConfig = FirePowerContestConfig.instance:getInteractiveConf(self.gameStageConf.pathType)
	self.continueHitScore = FirePowerContestConfig.instance:getContinueHitScore()

	table.sort(self.continueHitScore, function(a, b)
		return a.hit > b.hit
	end)

	self.initPositions = {}

	if FirePowerContestConfig.debugClient then
		self.itemInfoByPosId = {}
	end

	for i, v in ipairs(self.pathConfig.n) do
		if v.t == 1 then
			table.insert(self.initPositions, Vector2.New(v.x, v.y))

			if FirePowerContestConfig.debugClient then
				self.itemInfoByPosId[#self.initPositions] = {
					itemId = 1,
					posId = #self.initPositions
				}
			end
		end
	end

	self.bulletCount = self.gameStageConf.bulletNum
	self.rivalBulletCount = self.gameStageConf.bulletNum
	self.oneCircleTimeMap = {}
	self.oneCircleTotalSteps = 0

	local startGrid = self.initPositions[1]
	local curGrid = startGrid
	local index = 0

	self.gridSize = math.min(Width / self.pathConfig.x, Height / self.pathConfig.y)
	self.speedValue = self.gameStageConf.speed / FirePowerContestConfig.SpeedZoom

	local anchorPos = Vector3.New(0, 0)

	while true do
		index = index + 1

		if index > 500 then
			error("链表过长")

			break
		end

		local targetGrid = self:getTargetGrid(curGrid)
		local curPos = FPC_MoveStrategyBase.getPosByGrid(curGrid, self.gridSize, anchorPos)
		local targetPos = FPC_MoveStrategyBase.getPosByGrid(targetGrid, self.gridSize, anchorPos)
		local step = Vector2.Distance(targetPos, curPos) / self.speedValue

		self.oneCircleTimeMap[curGrid.x] = self.oneCircleTimeMap[curGrid.x] or {}
		self.oneCircleTimeMap[curGrid.x][curGrid.y] = step
		self.oneCircleTotalSteps = self.oneCircleTotalSteps + step
		curGrid = targetGrid

		if targetGrid.x == startGrid.x and curGrid.y == startGrid.y then
			break
		end
	end
end

function FirePowerContestData:updateUserInfo(userInfos)
	if checknumber(userInfos[2].userId) == checknumber(LoginModel.instance.userId) then
		self.myUserInfo = userInfos[2]
		self.rivalUserInfo = userInfos[1]
	else
		self.myUserInfo = userInfos[1]
		self.rivalUserInfo = userInfos[2]
	end

	if not self.iconTypeMap then
		self.iconTypeMap = {}
		self.iconTypeMap[self.myUserInfo.userId], self.iconTypeMap[self.rivalUserInfo.userId] = self:_randomIcon()
	end
end

function FirePowerContestData:getIconType(userId)
	return self.iconTypeMap[userId]
end

function FirePowerContestData:addMyScore(value)
	self.myScore = self.myScore + value
end

function FirePowerContestData:updateRivalScore(value)
	self.rivalScore = value
end

function FirePowerContestData:_getTargetGrid(pos)
	local target = self.pathConfig.l[tostring(pos.x)][tostring(pos.y)].ta

	return Vector2.New(target.x, target.y)
end

function FirePowerContestData:_getNodeData(posId)
	return self.initPositions[posId]
end

function FirePowerContestData:getTargetGrid(pos)
	if not pos then
		-- block empty
	end

	local status, result = xpcall(self._getTargetGrid, function(errMsg)
		local text = string.format("配置错误1：getTargetGrid(pos=(x=%s,y=%s)) curStage=%s, curId=%s", tostring(pos.x), tostring(pos.y), tostring(self.curStage), tostring(self.curId))

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			return
		end)
	end, self, pos)

	return result
end

function FirePowerContestData:getNodeData(posId)
	local status, result = xpcall(self._getNodeData, function(errMsg)
		local text = string.format("配置错误2：getNodeData(posId=%s) curStage=%s, curId=%s", tostring(posId), tostring(self.curStage), tostring(self.curId))

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			return
		end)
	end, self, posId)

	if not result then
		local text = string.format("配置错误3：getNodeData(posId=%s) curStage=%s, curId=%s", tostring(posId), tostring(self.curStage), tostring(self.curId))

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			return
		end)
	end

	return result
end

function FirePowerContestData:useBullet()
	self.bulletCount = self.bulletCount - 1
	self._isSelfHangup = false
end

function FirePowerContestData:getMyBulletId()
	return self.bulletCount
end

function FirePowerContestData:useRivalBullet()
	self.rivalBulletCount = self.rivalBulletCount - 1
	self._isRivalHangup = false
end

function FirePowerContestData:isSelfHangup()
	return self._isSelfHangup
end

function FirePowerContestData:isRivalHangup()
	return self._isRivalHangup
end

return FirePowerContestData
