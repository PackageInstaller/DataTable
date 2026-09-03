-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlayerBulletFactory.lua

require("dm.gameplay.miniGame.model.plane.PlaneBullet")

PlayerBulletFactory = class("PlayerBulletFactory", objectlua.Object, _M)

PlayerBulletFactory:has("_bulletList", {
	is = "r"
})
PlayerBulletFactory:has("_stop", {
	is = "r"
})
PlayerBulletFactory:has("_config", {
	is = "r"
})

function PlayerBulletFactory:initialize(config, type, gameControl)
	super.initialize(self)

	self._config = config
	self._type = type
	self._gameController = gameControl

	self:initData()

	self._tag = 100
end

function PlayerBulletFactory:remove()
	self:closeAllScheduler()

	for _, bullet in pairs(self._bulletList) do
		bullet:singleRemove()
	end

	self._bulletList = {}
end

function PlayerBulletFactory:initData()
	self._bulletList = {}
	self._schedulers = {}
end

function PlayerBulletFactory:buildBullet(parent, getPosFunc)
	self:closeScheduler()

	self._mainNode = parent

	for i = 1, #self._config do
		local bulletConfig = self._config[i]
		local bulletData = {
			delayTimeIndex = 1,
			updateTime = 0,
			bounds = QuadtreeBound:new(0, 0, 106, 14, self)
		}

		if bulletConfig.type == PlaneBulletType.kMove then
			self:createMoveTypeBullet(parent, bulletConfig, bulletData, getPosFunc, i)
		end
	end
end

function PlayerBulletFactory:createBullet(parent, data, pos)
	self._tag = self._tag + 1

	local planeBullet = PlaneBullet:new(self, data, self._gameController)
	local bodyImg = cc.MovieClip:create("yumao_dafeijitexiao")

	bodyImg:setScale(0.8)
	planeBullet:createBodyView(bodyImg)
	bodyImg:offset(51, 8)
	planeBullet:setType(self._type)
	planeBullet:addToParent(parent, pos, PlaneWarConfig.bulletZorder)
	planeBullet:setHp(self._tag)
	self:addBullet(planeBullet)

	return planeBullet
end

function PlayerBulletFactory:pause()
	for i = 1, #self._bulletList do
		local enemy = self._bulletList[i]

		enemy:pause()
	end
end

function PlayerBulletFactory:resume()
	for i = 1, #self._bulletList do
		local enemy = self._bulletList[i]

		enemy:resume()
	end
end

function PlayerBulletFactory:addBullet(bullet)
	self._bulletList[#self._bulletList + 1] = bullet
end

function PlayerBulletFactory:removeBullet(bullet)
	local index = table.find(self._bulletList, bullet)

	if index then
		table.remove(self._bulletList, index)
	end
end

function PlayerBulletFactory:createScheduler(index, func)
	self:closeScheduler(index)

	if self._schedulers[index] == nil then
		local function update(_, dt)
			if self._gameController:getIsGameOver() then
				self:closeAllScheduler()

				return
			end

			if func then
				func(dt)
			end
		end

		self._schedulers[index] = self._gameController:getScheduler():schedule(update, 0, false)
	end
end

function PlayerBulletFactory:closeScheduler(index)
	if self._schedulers[index] then
		self._gameController:getScheduler():unschedule(self._schedulers[index])

		self._schedulers[index] = nil
	end
end

function PlayerBulletFactory:closeAllScheduler()
	for index, _ in pairs(self._schedulers) do
		self:closeScheduler(index)
	end
end

function PlayerBulletFactory:createMoveBullet(parent, config, bulletData, pos)
	local planeBullet = self:createBullet(parent, bulletData, pos)

	planeBullet:move(config, function()
		self:removeBullet(planeBullet)
		planeBullet:remove()
	end)
end

function PlayerBulletFactory:createMoveTypeBullet(parent, bulletConfig, bulletData, getPosFunc, index)
	local updateTime = bulletData.updateTime
	local delayTimeIndex = bulletData.delayTimeIndex
	local delayTimeList = bulletConfig.factor.delayTime
	local beginDelayTime = bulletConfig.factor.beginDelayTime

	self:createScheduler(index, function(dt)
		updateTime = updateTime + dt

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

			local pos = getPosFunc(index)

			self:createMoveBullet(parent, bulletConfig, bulletData, pos)
		end
	end)
end
