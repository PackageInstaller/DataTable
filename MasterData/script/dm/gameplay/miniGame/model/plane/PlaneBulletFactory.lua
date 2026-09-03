-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneBulletFactory.lua

require("dm.gameplay.miniGame.model.plane.PlaneBullet")
require("dm.gameplay.miniGame.model.plane.PlaneEnemyCache")

PlaneBulletFactory = class("PlaneBulletFactory", objectlua.Object, _M)

PlaneBulletFactory:has("_bulletList", {
	is = "r"
})
PlaneBulletFactory:has("_stop", {
	is = "r"
})
PlaneBulletFactory:has("_config", {
	is = "r"
})

function PlaneBulletFactory:initialize(config, type, gameControl)
	super.initialize(self)

	self._config = config
	self._type = type
	self._gameController = gameControl

	self:initData()

	self._tag = 100
end

function PlaneBulletFactory:remove()
	self:closeAllScheduler()

	for _, bullet in pairs(self._bulletList) do
		bullet:singleRemove()
	end

	self._bulletList = {}
end

function PlaneBulletFactory:initData()
	self._bulletList = {}
end

function PlaneBulletFactory:buildBullet(parent, data, getPosFunc)
	self:closeScheduler()

	self._mainNode = parent

	local bulletType = self._config.type

	if bulletType == PlaneBulletType.kMove then
		self:createMoveTypeBullet(parent, data, getPosFunc)
	elseif bulletType == PlaneBulletType.kTrack then
		self:createTrackTypeBullet(parent, data, getPosFunc)
	elseif bulletType == PlaneBulletType.kFixedTrack then
		self:createFixedTrackTypeBullet(parent, data, getPosFunc)
	elseif bulletType == PlaneBulletType.kSplit then
		self:createSplitTypeBullet(parent, data, getPosFunc)
	end
end

function PlaneBulletFactory:createBullet(parent, data, pos)
	self._tag = self._tag + 1

	local planeBullet = PlaneBullet:new(self, data, self._gameController)
	local bodyImg = cc.MovieClip:create(data.body or "zidianxiao_dafeijitexiao")

	if data.offset then
		bodyImg:offset(data.offset.x, data.offset.y)
	end

	planeBullet:createBodyView(bodyImg)
	planeBullet:setType(self._type)

	if not data.zorder then
		planeBullet:addToParent(parent, pos, data.zorder)
		planeBullet:setHp(self._tag)
		self:addBullet(planeBullet)

		return planeBullet
	end
end

function PlaneBulletFactory:pause()
	for i = 1, #self._bulletList do
		local enemy = self._bulletList[i]

		enemy:pause()
	end
end

function PlaneBulletFactory:resume()
	for i = 1, #self._bulletList do
		local enemy = self._bulletList[i]

		enemy:resume()
	end
end

function PlaneBulletFactory:addBullet(bullet)
	self._bulletList[#self._bulletList + 1] = bullet
end

function PlaneBulletFactory:removeBullet(bullet)
	local index = table.find(self._bulletList, bullet)

	if index then
		table.remove(self._bulletList, index)
	end
end

function PlaneBulletFactory:createScheduler(updateTime, func)
	self:closeScheduler()

	if self._scheduler == nil then
		local function update(_, dt)
			if self._gameController:getIsGameOver() then
				self:closeAllScheduler()

				return
			end

			if func then
				func(dt)
			end
		end

		self._scheduler = self._gameController:getScheduler():schedule(update, 0, false)
	end
end

function PlaneBulletFactory:closeScheduler()
	if self._scheduler then
		self._gameController:getScheduler():unschedule(self._scheduler)

		self._scheduler = nil
	end
end

function PlaneBulletFactory:closeAllScheduler()
	self:closeScheduler()
end

function PlaneBulletFactory:createMoveBullet(parent, data, startPos)
	local planeBullet = self:createBullet(parent, data, startPos)

	planeBullet:move(self._config, function()
		self:removeBullet(planeBullet)
		planeBullet:remove()
	end)
end

function PlaneBulletFactory:createSplitBullet(parent, data, startPos, splitData)
	local planeBullet = self:createBullet(parent, data, startPos)

	planeBullet:split(self._config, data, splitData, function()
		self:removeBullet(planeBullet)
		planeBullet:remove()
	end)
end

function PlaneBulletFactory:addPlayerDoubleBullet(parent, data, getPosFunc, updateTime)
	self._mainNode = parent

	local doubleBulletTime = updateTime
	local updateTime = 0
	local delayTimeIndex = 1
	local delayTimeList = self._config.factor.delayTime
	local beginDelayTime = self._config.factor.beginDelayTime

	self:createDoubleBulletScheduler(0, function(dt)
		updateTime = updateTime + dt

		if doubleBulletTime <= 0 then
			self:createDoubleBulletScheduler()
		end

		doubleBulletTime = doubleBulletTime - dt

		if beginDelayTime and updateTime >= beginDelayTime / 1000 then
			updateTime = 0
			beginDelayTime = nil
		end

		local delayTime = delayTimeList[delayTimeIndex]

		if not beginDelayTime and updateTime >= delayTime / 1000 then
			delayTimeIndex = delayTimeIndex + 1

			if delayTimeIndex > #delayTimeList then
				delayTimeIndex = 1
			end

			updateTime = 0

			self:createMoveBullet(parent, data, getPosFunc())
		end
	end)
end

function PlaneBulletFactory:createMoveTypeBullet(parent, data, getPosFunc)
	local updateTime = 0
	local delayTimeIndex = 1
	local delayTimeList = self._config.factor.delayTime
	local beginDelayTime = self._config.factor.beginDelayTime

	self:createScheduler(0, function(dt)
		updateTime = updateTime + dt

		local canCreate = false

		if beginDelayTime and updateTime >= beginDelayTime / 1000 then
			updateTime = 0
			beginDelayTime = nil
			canCreate = true
		end

		local delayTime = delayTimeList[delayTimeIndex]

		if not beginDelayTime and updateTime >= delayTime / 1000 then
			delayTimeIndex = delayTimeIndex + 1

			if delayTimeIndex > #delayTimeList then
				delayTimeIndex = 1
			end

			updateTime = 0
			canCreate = true
		end

		if canCreate then
			self:createMoveBullet(parent, data, getPosFunc())
		end
	end)
end

function PlaneBulletFactory:createTrackTypeBullet(parent, data, getPosFunc)
	local updateTime = 0
	local delayTimeIndex = 1
	local delayTimeList = self._config.factor.delayTime
	local beginDelayTime = self._config.factor.beginDelayTime
	local playerNode = self._gameController:getPlayer():getView()

	self:createScheduler(0, function(dt)
		updateTime = updateTime + dt

		local canCreate = false

		if beginDelayTime and updateTime >= beginDelayTime / 1000 then
			updateTime = 0
			beginDelayTime = nil
			canCreate = true
		end

		local delayTime = delayTimeList[delayTimeIndex]

		if not beginDelayTime and updateTime >= delayTime / 1000 then
			delayTimeIndex = delayTimeIndex + 1

			if delayTimeIndex > #delayTimeList then
				delayTimeIndex = 1
			end

			updateTime = 0
			canCreate = true

			local targetPos = cc.p(playerNode:getPositionX(), playerNode:getPositionY())
		end

		if canCreate then
			self:createSplitBullet(parent, data, getPosFunc(), {
				targetPos = targetPos
			})
		end
	end)
end

function PlaneBulletFactory:createFixedTrackTypeBullet(parent, data, getPosFunc)
	local updateTime = 0
	local delayTimeIndex = 1
	local delayTimeList = self._config.factor.delayTime
	local beginDelayTime = self._config.factor.beginDelayTime
	local playerNode = self._gameController:getPlayer():getView()
	local targetPos = cc.p(playerNode:getPositionX(), playerNode:getPositionY())

	self:createScheduler(0, function(dt)
		updateTime = updateTime + dt

		local canCreate = false

		if beginDelayTime and updateTime >= beginDelayTime / 1000 then
			updateTime = 0
			beginDelayTime = nil
			canCreate = true
		end

		local delayTime = delayTimeList[delayTimeIndex]

		if not beginDelayTime and updateTime >= delayTime / 1000 then
			delayTimeIndex = delayTimeIndex + 1

			if delayTimeIndex > #delayTimeList then
				delayTimeIndex = 1
			end

			updateTime = 0
			canCreate = true
		end

		if canCreate then
			targetPos = cc.p(playerNode:getPositionX(), playerNode:getPositionY())

			self:createSplitBullet(parent, data, getPosFunc(), {
				targetPos = targetPos
			})
		end
	end)
end

function PlaneBulletFactory:createSplitTypeBullet(parent, data, getPosFunc)
	local updateTime = 0
	local delayTimeIndex = 1
	local delayTimeList = self._config.factor.delayTime
	local beginDelayTime = self._config.factor.beginDelayTime
	local winSizeHeight = cc.Director:getInstance():getWinSize().height

	self:createScheduler(0, function(dt)
		updateTime = updateTime + dt

		local canCreate = false

		if beginDelayTime and updateTime >= beginDelayTime / 1000 then
			updateTime = 0
			beginDelayTime = nil
			canCreate = true
		end

		local delayTime = delayTimeList[delayTimeIndex]

		if not beginDelayTime and updateTime >= delayTime / 1000 then
			canCreate = true
			delayTimeIndex = delayTimeIndex + 1

			if delayTimeIndex > #delayTimeList then
				delayTimeIndex = 1
			end

			updateTime = 0
		end

		if canCreate then
			local bulletNum = self._config.factor.bulletNum
			local changeHeight = self._config.factor.degree
			local curPosY = getPosFunc().y
			local posYList = {}

			posYList[1] = curPosY

			for i = 1, math.modf((bulletNum - 1) / 2) do
				posYList[#posYList + 1] = curPosY - i * changeHeight
				posYList[#posYList + 1] = curPosY + i * changeHeight
			end

			for i = 1, #posYList do
				local targetPos = cc.p(0, posYList[i])

				self:createSplitBullet(parent, data, getPosFunc(), {
					targetPos = targetPos
				})
			end
		end
	end)
end
