-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarCloud.lua

PlaneWarCloud = class("PlaneWarCloud", objectlua.Object, _M)

function PlaneWarCloud:initialize(mainNode, data)
	super.initialize(self)

	self._mainNode = mainNode
	self._cloudList = {}
end

function PlaneWarCloud:createScheduler(time)
	self:closeScheduler()

	if self._scheduler == nil then
		local function update(_, dt)
			self:update(dt)
		end

		self._scheduler = LuaScheduler:getInstance():schedule(update, time or 0, false)
	end
end

function PlaneWarCloud:update(dt)
	if self._stop then
		return
	end

	local count = math.random(1, 4)

	for i = 1, count do
		self._cloudList[#self._cloudList + 1] = self:createCloud()
	end
end

function PlaneWarCloud:removeCloud(cloud)
	local index = table.find(self._cloudList, cloud)

	if index then
		table.remove(self._cloudList, index)
	end
end

function PlaneWarCloud:createCloud()
	local mySelf = self
	local winSize = cc.Director:getInstance():getWinSize()
	local imgPath = "asset/ui/miniplane/img_miniplane_yun0" .. math.random(1, 4) .. ".png"
	local cloudImg = cc.Sprite:create(imgPath)

	cloudImg:addTo(self._mainNode, PlaneWarConfig.bgZorder)
	cloudImg:setAnchorPoint(cc.p(0, 0))
	cloudImg:posite(winSize.width + cloudImg:getContentSize().width, math.random(winSize.height / 200, winSize.height / 100) * 100)

	local posX = -cloudImg:getContentSize().width - 40 + math.random(1, 10) * 10
	local moveTo = cc.MoveTo:create(math.random(10, 20), cc.p(posX, cloudImg:getPositionY()))

	cloudImg:runAction(cc.Sequence:create(moveTo, cc.CallFunc:create(function()
		mySelf:removeCloud(cloudImg)
	end)))
	cloudImg:setOpacity(math.random(4, 12) * 10)

	return cloudImg
end

function PlaneWarCloud:closeScheduler()
	if self._scheduler then
		LuaScheduler:getInstance():unschedule(self._scheduler)

		self._scheduler = nil
	end
end

function PlaneWarCloud:build()
	self:createScheduler(8)
	self:update()
end

function PlaneWarCloud:remove()
	self:closeScheduler()
end

function PlaneWarCloud:pause()
	self._stop = true

	for i = 1, #self._cloudList do
		self._cloudList[i]:pause()
	end
end

function PlaneWarCloud:resume()
	self._stop = false

	for i = 1, #self._cloudList do
		self._cloudList[i]:resume()
	end
end
