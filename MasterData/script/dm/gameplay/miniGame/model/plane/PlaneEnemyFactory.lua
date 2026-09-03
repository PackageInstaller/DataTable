-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneEnemyFactory.lua

require("dm.gameplay.miniGame.model.plane.PlaneEnemy")
require("dm.gameplay.miniGame.model.plane.PlaneEnemyCache")

PlaneEnemyFactory = class("PlaneEnemyFactory", objectlua.Object, _M)

PlaneEnemyFactory:has("_enemyCache", {
	is = "r"
})
PlaneEnemyFactory:has("_enemyList", {
	is = "r"
})
PlaneEnemyFactory:has("_bulletFactoryList", {
	is = "r"
})

function PlaneEnemyFactory:initialize(mainNode, data, gameController)
	super.initialize(self)

	self._mainNode = mainNode
	self._gameController = gameController
	self._firstSleepTime = (data.firstTime or 0) / 1000
	self._enemyCache = PlaneEnemyCache:new(data.wave)
	self._bulletFactoryList = {}

	self:initData()
end

function PlaneEnemyFactory:getGameControl()
	return self._gameController
end

function PlaneEnemyFactory:initData()
	self._enemyList = {}
	self._updateTime = 0
	self._isFirstPlane = true
	self._nextSleepTime = nil
	self._tag = 1
end

function PlaneEnemyFactory:createScheduler(time)
	self:closeScheduler()

	if self._scheduler == nil then
		local function update(_, dt)
			self:update(dt)
		end

		self._scheduler = self._gameController:getScheduler():schedule(update, time or 0, false)
	end
end

function PlaneEnemyFactory:closeScheduler()
	if self._scheduler then
		self._gameController:getScheduler():unschedule(self._scheduler)

		self._scheduler = nil
	end
end

function PlaneEnemyFactory:update(dt)
	if self._stop then
		return
	end

	if self._gameController:getIsGameOver() then
		self:pause()
		self:closeScheduler()

		return
	end

	self._tag = self._tag + 1
	self._updateTime = self._updateTime + dt

	if self._isFirstPlane and self._updateTime >= self._firstSleepTime then
		self._updateTime = 0
		self._isFirstPlane = false
		self._nextSleepTime = self._enemyCache:getAppearSleepTime()

		self:buildNextPlane()

		return
	end

	if not self._isFirstPlane and self._nextSleepTime and self._updateTime >= self._nextSleepTime then
		self._updateTime = 0
		self._nextSleepTime = self._enemyCache:getAppearSleepTime()

		self:buildNextPlane()
	end
end

function PlaneEnemyFactory:resetIndex()
	self._enemyCache:setGroupIndex(1)
	self._enemyCache:setPointIndex(1)
end

function PlaneEnemyFactory:build()
	self:closeScheduler()
	self:initData()

	local firstGroup = self._enemyCache:getGroupByIndex(1)

	if firstGroup then
		firstGroup:firstCreateEnemy()
	end

	self:resetIndex()
	self:createScheduler()
end

function PlaneEnemyFactory:buildNextPlane()
	self:createEnemy()
	self:refreshPlaneIndex()
end

function PlaneEnemyFactory:createEnemy(enemyId, pos)
	if not enemyId then
		::label_11_0::

		local curEnemyId = self._enemyCache:getCurEnemyId()
		local enemyConfig = ConfigReader:getRecordById("MiniPlaneEnemy", curEnemyId)

		if not enemyConfig then
			self:closeScheduler()
			self:win()

			return
		end

		local data = kPlaneEnemyConfig[enemyConfig.type]

		if data then
			local newEnemy = data.planeClass:new(curEnemyId, self)

			newEnemy:addToParent(self._mainNode, pos, PlaneWarConfig.enemyZorder)
			newEnemy:move(function()
				self:removeEnemy(newEnemy)
				newEnemy:remove()
			end)
			self:addEnemy(newEnemy)

			local config = newEnemy:getConfig()

			for i = 1, #config.BulletMoveType do
				local bulletFactory = PlaneBulletFactory:new(config.BulletMoveType[i], PlaneMemberType.kEnemyButtle, self._gameController)

				self:addBulletFactory(bulletFactory)
				newEnemy:bindBulletFactory(bulletFactory)
				newEnemy:buildBullet(bulletFactory, self._mainNode)
			end

			return newEnemy
		end
	end
end

function PlaneEnemyFactory:addBulletFactory(bulletFactory)
	self._bulletFactoryList[#self._bulletFactoryList + 1] = bulletFactory
end

function PlaneEnemyFactory:removeBulletFactory(bulletFactory)
	local index = table.find(self._bulletFactoryList, bulletFactory)

	if index then
		table.remove(self._bulletFactoryList, bulletFactory)
	end
end

function PlaneEnemyFactory:refreshPlaneIndex()
	local curGroup = self._enemyCache:getCurGroup()
	local curPointIndex = self._enemyCache:getPointIndex()
	local curGroupIndex = self._enemyCache:getGroupIndex()
	local groupCount = curGroup:getEnemyCount()

	if curPointIndex == groupCount then
		if self._enemyCache:isLastGroup(curGroupIndex) then
			self:closeScheduler()

			return
		end

		local nextGroup = self._enemyCache:getNextGroup()

		if nextGroup then
			nextGroup:rCreateEnemyQueue()
		end

		self._enemyCache:setPointIndex(1)
		self._enemyCache:setGroupIndex(self._enemyCache:getGroupIndex() + 1)
	else
		self._enemyCache:setPointIndex(self._enemyCache:getPointIndex() + 1)
	end
end

function PlaneEnemyFactory:win()
	self._gameController:winGame()
end

function PlaneEnemyFactory:useBomb()
	return
end

function PlaneEnemyFactory:pause()
	for i = 1, #self._enemyList do
		local enemy = self._enemyList[i]

		enemy:pause()
	end

	for i = 1, #self._bulletFactoryList do
		local bulletFactory = self._bulletFactoryList[i]

		bulletFactory:pause()
	end
end

function PlaneEnemyFactory:resume()
	for i = 1, #self._enemyList do
		local enemy = self._enemyList[i]

		enemy:resume()
	end

	for i = 1, #self._bulletFactoryList do
		local bulletFactory = self._bulletFactoryList[i]

		bulletFactory:resume()
	end
end

function PlaneEnemyFactory:addEnemy(enemy)
	self._enemyList[#self._enemyList + 1] = enemy
end

function PlaneEnemyFactory:removeEnemy(enemy)
	local index = table.find(self._enemyList, enemy)

	if index then
		table.remove(self._enemyList, index)
	end
end

function PlaneEnemyFactory:remove()
	self:closeScheduler()

	for i = 1, #self._enemyList do
		local enemy = self._enemyList[i]

		enemy:clearEnemy()
	end

	self._enemyList = {}
	self._bulletFactoryList = {}
end

function PlaneEnemyFactory:bombAllEnergy()
	return
end

function PlaneEnemyFactory:removeAllBulletFactory()
	for i = 1, #self._enemyList do
		local enemy = self._enemyList[i]

		enemy:removeAllBulletFactory()
	end
end
