-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneCollision.lua

PlaneCollision = class("PlaneCollision", objectlua.Object, _M)

PlaneCollision:has("_owner", {
	is = "r"
})
PlaneCollision:has("_checkTime", {
	is = "r"
})

function PlaneCollision:initialize(owner)
	super.initialize(self)

	self._owner = owner
	self._tag = 1
	self._checkTime = 0
end

function PlaneCollision:createScheduler(time)
	self:closeScheduler()

	if self._scheduler == nil then
		local function update(_, dt)
			if self._owner:getIsGameOver() then
				self:closeScheduler()

				return
			end

			self:check(dt)

			self._tag = self._tag + 1
			self._checkTime = self._checkTime + 1
		end

		self._scheduler = LuaScheduler:getInstance():schedule(update, time or 0, false)
	end
end

function PlaneCollision:closeScheduler()
	if self._scheduler then
		LuaScheduler:getInstance():unschedule(self._scheduler)

		self._scheduler = nil
	end
end

function PlaneCollision:beginCheck()
	local winSize = cc.Director:getInstance():getWinSize()

	self._planeQuadtree = PlaneQuadtree:new(QuadtreeBound:new(0, 0, winSize.width, winSize.height), 0, self._owner)
	self._bulletQuadtree = PlaneQuadtree:new(QuadtreeBound:new(0, 0, winSize.width, winSize.height), 0, self._owner)

	self:createScheduler()
end

local enemyEffect = {
	[PlaneEnemyType.kPlane1] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kPlane2] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kPlane3] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kPlane4] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kPlane5] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kPlane6] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kPlane7] = function(owner, member)
		owner:playerHurt(member)
	end,
	[PlaneEnemyType.kBomb] = function(owner, member)
		owner:addBomb()
	end,
	[PlaneEnemyType.kGold] = function(owner, member)
		owner:addItem(member)
	end,
	[PlaneEnemyType.kDiamond] = function(owner, member)
		owner:addItem(member)
	end,
	[PlaneEnemyType.kPiece] = function(owner, member)
		owner:addItem(member)
	end
}

function PlaneCollision:insertFunc(quadtree, member)
	member:refreshBounds(member:getBoundingBox())
	quadtree:insert(member:getBounds())
end

function PlaneCollision:insertQuadtree()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._planeQuadtree:clear()
	self._bulletQuadtree:clear()

	local player = self._owner:getPlayer()

	self:insertFunc(self._planeQuadtree, player)

	local enemyList = self._owner:getEnemyFactory():getEnemyList()
	local bulletFactoryList = self._owner:getEnemyFactory():getBulletFactoryList()

	self._checkEnemyList = {}

	for i = 1, #bulletFactoryList do
		local bullets = bulletFactoryList[i]:getBulletList()

		for j = 1, #bullets do
			local bullet = bullets[j]

			self:insertFunc(self._planeQuadtree, bullet)
		end
	end

	for i = 1, #enemyList do
		local planeEnemy = enemyList[i]

		self:insertFunc(self._planeQuadtree, planeEnemy)

		local boundingBox = planeEnemy:getBoundingBox()

		if PlaneWarConfig:isPlaneEnemy(planeEnemy:getEnemyType()) and boundingBox.x < winSize.width then
			self:insertFunc(self._bulletQuadtree, planeEnemy)

			self._checkEnemyList[#self._checkEnemyList + 1] = planeEnemy
		end
	end

	local bullets = player:getBullets()

	for i = 1, #bullets do
		local playerBullet = bullets[i]

		self:insertFunc(self._bulletQuadtree, playerBullet)
	end
end

function PlaneCollision:check()
	if self._stop then
		return
	end

	self:insertQuadtree()
	self:checkPlayer()
	self:checkPlayerBullet()
end

function PlaneCollision:checkPlayer()
	local curMember = self._owner:getPlayer()
	local checkList = {}

	curMember:refreshBounds(curMember:getBoundingBox())

	local result = self._planeQuadtree:retrieve(checkList, curMember:getBounds())

	if #checkList > 0 then
		local enemyCache = {}
		local bulletcache = {}

		for i = 1, #checkList do
			local member = checkList[i]:getOwner()

			member:refreshBounds(member:getBoundingBox())

			if member:getType() == PlaneMemberType.kEnemyPlane then
				if cc.rectIntersectsRect(curMember:getBoundingBox(), member:getBoundingBox()) and enemyEffect[member:getEnemyType()] then
					enemyCache[#enemyCache + 1] = member
				end
			elseif member:getType() == PlaneMemberType.kEnemyButtle and cc.rectIntersectsRect(curMember:getBoundingBox(), member:getBoundingBox()) then
				bulletcache[#bulletcache + 1] = member
			end
		end

		for i = 1, #enemyCache do
			local member = enemyCache[i]

			if enemyEffect[member:getEnemyType()] then
				enemyEffect[member:getEnemyType()](self._owner, member)
			end
		end

		for i = 1, #bulletcache do
			self._owner:enemyBulletHurt(bulletcache[i])
		end
	end
end

function PlaneCollision:checkPlayerBullet()
	local player = self._owner:getPlayer()
	local bulletList = player:getBullets()
	local enemyList = self._checkEnemyList
	local list1, list2 = bulletList, enemyList

	local function checkFunc(bound)
		return bound:getOwner():getType() == PlaneMemberType.kEnemyPlane
	end

	if #bulletList >= #enemyList then
		list2 = bulletList
		list1 = enemyList

		function checkFunc(bound)
			return bound:getOwner():getType() == PlaneMemberType.kPlayerButtle
		end
	end

	local removeData = {}

	for i = 1, #list1 do
		local member1 = list1[i]

		member1:refreshBounds(member1:getBoundingBox())

		local checkList = {}

		self._bulletQuadtree:retrieve(checkList, member1:getBounds(), checkFunc)

		if #checkList > 0 then
			for j = 1, #checkList do
				local member2 = checkList[j]:getOwner()

				member2:refreshBounds(member2:getBoundingBox())

				if cc.rectIntersectsRect(member1:getBoundingBox(), member2:getBoundingBox()) then
					removeData[#removeData + 1] = {
						member1 = member1,
						member2 = member2
					}
				end
			end
		end
	end

	if #removeData > 0 then
		-- block empty
	end

	local function removeFunc(owner, member)
		if member:getType() == PlaneMemberType.kPlayerButtle then
			owner:bulletHurt(member)
		elseif member:getType() == PlaneMemberType.kEnemyPlane then
			owner:enemyOnceHurt(member)
		end
	end

	for i = 1, #removeData do
		local data = removeData[i]

		removeFunc(self._owner, data.member1)
		removeFunc(self._owner, data.member2)
	end
end

function PlaneCollision:remove()
	self:closeScheduler()
end

function PlaneCollision:pause()
	self._stop = true
end

function PlaneCollision:resume()
	self._stop = false
end
