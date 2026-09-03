-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarController.lua

require("dm.gameplay.miniGame.model.plane.PlaneWarConfig")
require("dm.gameplay.miniGame.model.plane.PlaneQuadtree")
require("dm.gameplay.miniGame.model.plane.PlaneEnemyFactory")
require("dm.gameplay.miniGame.model.plane.PlaneBulletFactory")
require("dm.gameplay.miniGame.model.plane.PlayerBulletFactory")
require("dm.gameplay.miniGame.model.plane.PlanePlayerFactory")
require("dm.gameplay.miniGame.model.plane.PlaneWarBgFactory")
require("dm.gameplay.miniGame.model.plane.PlaneCollision")
require("dm.gameplay.miniGame.model.plane.PlaneWarFightData")
require("dm.gameplay.miniGame.MiniGameConfig")

PlaneWarController = class("PlaneWarController", objectlua.Object, _M)

PlaneWarController:has("_enemyFactory", {
	is = "r"
})
PlaneWarController:has("_playerFactory", {
	is = "r"
})
PlaneWarController:has("_collision", {
	is = "r"
})
PlaneWarController:has("_fightData", {
	is = "r"
})
PlaneWarController:has("_pointData", {
	is = "r"
})
PlaneWarController:has("_scheduler", {
	is = "r"
})
PlaneWarController:has("_isGameOver", {
	is = "r"
})

function PlaneWarController:initialize(parent, data)
	super.initialize(self)
	self:initMainNode(parent)
	self:initData(data)
end

function PlaneWarController:initData(data)
	self._data = data
	self._isGameOver = false
	self._pointData = MiniPlanePoint:new(data.pointId)
	self._scheduler = LuaScheduler:new()

	self._scheduler:start()

	self._enemyFactory = PlaneEnemyFactory:new(self:getMainNode(), {
		wave = self._pointData:getWave(),
		firstTime = self._pointData:getFirstSleepTime()
	}, self)
	self._playerFactory = PlanePlayerFactory:new(self:getMainNode(), self)
	self._bgFactory = PlaneWarBgFactory:new(self:getMainNode(), self)
	self._collision = PlaneCollision:new(self)
	self._fightData = PlaneWarFightData:new()
end

function PlaneWarController:getPlayTime()
	return self._collision:getCheckTime()
end

function PlaneWarController:winGame()
	self._isGameOver = true

	if self._data.win then
		self._data.win()

		self._data.win = nil
	end
end

function PlaneWarController:initMainNode(parent)
	local mySelf = self
	local mainNode = cc.Node:create()

	function mainNode:onExit()
		mySelf._isGameOver = true

		mySelf:remove()
	end

	mainNode:enableNodeEvents()

	self._mainNode = mainNode

	self._mainNode:addTo(parent)

	self._textNode = cc.Node:create()

	self._textNode:addTo(self._mainNode, -1)

	local winSize = cc.Director:getInstance():getWinSize()

	self._touchLayer = ccui.Layout:create()

	self._touchLayer:setTouchEnabled(false)
	self._touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
	self._touchLayer:addTo(self._mainNode)
	self._touchLayer:addTouchEventListener(function(sender, eventType)
		self:touchClick(sender, eventType)
	end)
end

function PlaneWarController:getTextNode()
	return self._textNode
end

function PlaneWarController:getMainNode()
	return self._mainNode
end

function PlaneWarController:touchClick(sender, eventType)
	if self._isGameOver then
		return
	end

	if eventType == ccui.TouchEventType.moved then
		if not self._touchPos then
			return
		end

		local player = self:getPlayer()

		if not player then
			self._isGameOver = true

			return
		end

		local pos = sender:getTouchMovePosition()
		local changeX = pos.x - self._touchPos.x
		local changeY = pos.y - self._touchPos.y
		local endX = player:getPositionX() + changeX
		local endY = player:getPositionY() + changeY

		player:move(cc.p(endX, endY))

		self._touchPos = cc.p(pos.x, pos.y)
	elseif eventType == ccui.TouchEventType.began then
		local pos = sender:getTouchBeganPosition()

		self._touchPos = cc.p(pos.x, pos.y)
	elseif eventType == ccui.TouchEventType.ended then
		self._touchPos = nil
	end
end

function PlaneWarController:build()
	if self._isGameOver then
		return
	end

	self._pause = false

	self._touchLayer:setTouchEnabled(true)
	self._enemyFactory:build()
	self._playerFactory:build(self._pointData:getPlayerBulletAction())
	self._bgFactory:build()
	self._collision:beginCheck()
end

function PlaneWarController:remove()
	if self._scheduler ~= nil then
		self._scheduler:stop()
	end

	self._enemyFactory:remove()
	self._playerFactory:remove()
	self._collision:remove()
	self._bgFactory:remove()

	self._scheduler = nil
end

function PlaneWarController:playerHurt(enemyMember)
	self:gameOver()
	enemyMember:setHp(0)
	self:enemyOnceHurt(enemyMember)
	self:getPlayer():hurt(function()
		return
	end)
	AudioEngine:getInstance():playEffect("Se_Effect_Leader_Die")
end

function PlaneWarController:hurtAllEnemy()
	local enemyList = self._enemyFactory:getEnemyList()
	local cache = {}

	for i = 1, #enemyList do
		cache[#cache + 1] = enemyList[i]
	end

	local isGameEnd

	for i = 1, #cache do
		local enemy = cache[i]
		local isGameOverEnemy = enemy:isGameOverEnemy()

		enemy:setHp(1)
		self:enemyHurt(enemy, function()
			if self._data.addScore then
				self._data.addScore()
			end
		end)

		if isGameOverEnemy then
			isGameEnd = true

			self:winGame()
		end
	end

	if isGameEnd then
		self._isGameOver = true
	else
		self:winGame()

		self._isGameOver = true
	end
end

function PlaneWarController:enemyOnceHurt(enemy)
	local isGameOverEnemy = enemy:isGameOverEnemy()

	if isGameOverEnemy and enemy:getHp() == 2 then
		self:pause()
		self:hurtAllEnemy()

		return
	end

	self:enemyHurt(enemy, function()
		if self._data.addScore then
			self._data.addScore()
		end
	end)
end

function PlaneWarController:enemyHurt(enemy, func, diedFinishFunc)
	enemy:hurt(function(score)
		self._fightData:addScore(score)
		self._fightData:addEnemy(enemy:getId())

		if self._data.addScore then
			self._data.addScore()
		end

		if func then
			func()
		end
	end, diedFinishFunc)
end

function PlaneWarController:bulletHurt(bullet)
	bullet:remove()
end

function PlaneWarController:enemyBulletHurt(enemyBullet)
	self:gameOver()
	self:getPlayer():hurt()
	enemyBullet:remove()
	AudioEngine:getInstance():playEffect("Se_Effect_Leader_Die")
end

function PlaneWarController:addBomb()
	self._enemyFactory:useBomb()
end

function PlaneWarController:bombAllEnergy()
	return
end

function PlaneWarController:addItem(member)
	member:hurt(function(score)
		self._fightData:addScore(score)

		local rewardId = member:getBoomReward()

		if rewardId then
			local rewardConfig = ConfigReader:getRecordById("Reward", rewardId)

			if rewardConfig then
				self._fightData:addReward(rewardId, rewardConfig.Content[1])
			end
		end

		self:checkAddItemFunc()
	end)
end

function PlaneWarController:addExtraRewards(rewardId)
	if rewardId then
		local rewardConfig = ConfigReader:getRecordById("Reward", rewardId)

		if rewardConfig then
			self._fightData:addReward(rewardId, rewardConfig.Content[1])
		end
	end

	self:checkAddItemFunc()
end

function PlaneWarController:checkAddItemFunc()
	if self._data.addItem then
		self._data.addItem()
	end
end

function PlaneWarController:gameOver()
	self._isGameOver = true

	self:pause()

	if self._data.gameOver then
		self._data.gameOver()

		self._data.gameOver = nil
	end
end

function PlaneWarController:pause()
	self._pause = true

	self._scheduler:pause()
	self._playerFactory:pause()
	self._enemyFactory:pause()
	self._collision:pause()
	self._bgFactory:pause()
	self._touchLayer:setTouchEnabled(false)
end

function PlaneWarController:resume()
	if self._isGameOver then
		return
	end

	self._pause = false

	self._scheduler:resume()
	self._playerFactory:resume()
	self._enemyFactory:resume()
	self._collision:resume()
	self._bgFactory:resume()
	self._touchLayer:setTouchEnabled(true)
end

function PlaneWarController:getPlayer()
	return self._playerFactory:getPlayer()
end

function PlaneWarController:getCheckMembers()
	return
end
