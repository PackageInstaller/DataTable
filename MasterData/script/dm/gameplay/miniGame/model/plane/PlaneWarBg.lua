-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarBg.lua

PlaneWarBg = class("PlaneWarBg", objectlua.Object, _M)

function PlaneWarBg:initialize(mainNode, data, gameController)
	self._gameController = gameController

	super.initialize(self)

	self._changeWidth = data.changeWidth or 10
	self._posY = data.posY or 10
	self._mainNode = mainNode

	local winSize = cc.Director:getInstance():getWinSize()

	self._bgImg1 = cc.Sprite:create(data.imgPath1)
	self._bgImgWidth = self._bgImg1:getContentSize().width
	self._bgWidth = 0
	self._direction = true

	self._bgImg1:setAnchorPoint(cc.p(0, 0))
	self._bgImg1:addTo(self._mainNode, PlaneWarConfig.bgZorder):posite(0, self._posY)

	self._bgImg2 = cc.Sprite:create(data.imgPath2)

	self._bgImg2:setAnchorPoint(cc.p(0, 0))
	self._bgImg2:addTo(self._mainNode, PlaneWarConfig.bgZorder):posite(self._bgImgWidth, self._posY)
end

function PlaneWarBg:createScheduler(time)
	self:closeScheduler()

	if self._scheduler == nil then
		local function update(_, dt)
			self:update(dt)
		end

		self._scheduler = self._gameController:getScheduler():schedule(update, time or 0, false)
	end
end

function PlaneWarBg:update(dt)
	if self._stop then
		return
	end

	self._bgWidth = self._bgWidth - self._changeWidth

	if self._bgWidth <= -self._bgImgWidth then
		self._bgWidth = 0
		self._direction = not self._direction
	end

	if self._direction then
		self._bgImg1:setPosition(self._bgWidth, self._posY)
		self._bgImg2:setPosition(self._bgWidth + self._bgImgWidth, self._posY)
	else
		self._bgImg2:setPosition(self._bgWidth, self._posY)
		self._bgImg1:setPosition(self._bgWidth + self._bgImgWidth, self._posY)
	end
end

function PlaneWarBg:closeScheduler()
	if self._scheduler then
		self._gameController:getScheduler():unschedule(self._scheduler)

		self._scheduler = nil
	end
end

function PlaneWarBg:build()
	self:createScheduler()
end

function PlaneWarBg:remove()
	self:closeScheduler()
end

function PlaneWarBg:pause()
	self._stop = true
end

function PlaneWarBg:resume()
	self._stop = false
end
