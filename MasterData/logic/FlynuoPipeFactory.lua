-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/controller/FlynuoPipeFactory.lua

module("logic.extensions.flyingnuo.view.game.FlynuoPipeFactory", package.seeall)

local FlynuoPipeFactory = class("FlynuoPipeFactory")
local table_insert = table.insert
local table_remove = table.remove
local height = 0
local limitMin, limitMax = 0, 0
local offsetMin, offsetMax = 0, 0

function FlynuoPipeFactory:ctor()
	self._uiCamera = goutil.find("UICamera"):GetComponent(ComponentType.Camera)
	self._cornors = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	self._creatIndex = 1
	height = FlyNuoConfig.instance:getPipeHeight()
	limitMin, limitMax = FlyNuoConfig.instance:getPipeOffsetLimit()
	offsetMin, offsetMax = FlyNuoConfig.instance:getPipeOffset()
end

function FlynuoPipeFactory:init(player, parent, cellGo, noPropItem)
	self._parentTr = parent
	self._cell = cellGo
	self._space = FlyNuoConfig.instance:getPipeSpace()
	self._speed = 0
	self._currIndex = 0
	self._lastPipe = false
	self._noPropItem = noPropItem
	self._hitPipeList = {}
	self._pipePool = {}
	self._itemList = {}

	self:setPlayer(player)
	self:_initPipe()
	self:_resetItems()
end

function FlynuoPipeFactory:onReset()
	removetimer(self._update, self)
end

function FlynuoPipeFactory:onInit()
	return
end

function FlynuoPipeFactory:setPlayer(player)
	self._player = player
end

function FlynuoPipeFactory:startPipe(speed)
	self._speed = speed

	self:_resetItems()
	self:_itemMove()
end

function FlynuoPipeFactory:stopPipe()
	removetimer(self._update, self)

	for k, item in pairs(self._hitPipeList) do
		item:stop()
	end
end

function FlynuoPipeFactory:destroyPipe()
	self:stopPipe()
	self:_resetItems()

	for i, item in ipairs(self._itemList) do
		item:onExit()
		goutil.destroy(item.mainGO)
	end

	self._itemList = {}
end

function FlynuoPipeFactory:_initPipe()
	self._itemList = {}

	for i = 1, 10 do
		self._itemList[i] = self:_creatNewPipe()
	end
end

function FlynuoPipeFactory:_creatNewPipe()
	local go = goutil.cloneAndSetParent(self._cell, self._parentTr, "cell" .. self._creatIndex)

	self._creatIndex = self._creatIndex + 1

	goutil.setActive(go, true)

	local item = GameUtil.AddLuaOnce(go, FlynuoPipe)

	item:setLocalPos(2000, 0)

	return item
end

function FlynuoPipeFactory:_resetItems()
	for i, item in ipairs(self._itemList) do
		item:changeSpeed(0)
		item:setLocalPos(2000, 0)
	end

	self._hitPipeList = {}
	self._lastPipe = false
end

function FlynuoPipeFactory:_getItemPos(lastPipe)
	if lastPipe then
		local var_12_0 = lastPipe:getLocalPosX()

		if not var_12_0 then
			var_12_0 = FlyNuoConfig.instance:getPipeBornSafeDistance()

			local lastX = var_12_0

			return lastX + self._space
		end
	end
end

function FlynuoPipeFactory:_itemMove()
	self._lastPipe = false

	local centerY = 0

	self._hitPipeList = {}

	for i, pipe in ipairs(self._itemList) do
		centerY = self:_getCenterY(self._lastPipe)

		pipe:setLocalPos(self:_getItemPos(self._lastPipe), 0)
		pipe:move(self, self._speed, centerY, height)

		if not self._noPropItem then
			pipe:randomItem()
		end

		table_insert(self._hitPipeList, pipe)

		self._lastPipe = pipe
	end

	settimer(0.02, self._update, self, true)
end

function FlynuoPipeFactory:recyclePipe(pipe)
	local centerY = self:_getCenterY(self._lastPipe)

	pipe:setLocalPos(2000, 0)
	pipe:setLocalPos(self:_getItemPos(self._lastPipe), 0)
	pipe:move(self, self._speed, centerY, height)

	if not self._noPropItem then
		pipe:randomItem()
	end

	table_insert(self._hitPipeList, pipe)

	self._lastPipe = pipe
end

function FlynuoPipeFactory:_getCenterY(lastPipe)
	local pass = false
	local centerY = 0
	local lastCenterY = lastPipe and lastPipe:getCenterY() or 0

	for i = 1, 100 do
		offset = math.random(offsetMin, offsetMax)
		centerY = lastCenterY + offset

		if lastCenterY + offset > offsetMin and centerY < offsetMax then
			pass = true

			break
		end
	end

	if not pass then
		centerY = lastCenterY
	end

	return centerY
end

function FlynuoPipeFactory:_update()
	for i, item in ipairs(self._itemList) do
		item:update(Time.deltaTime)
	end
end

function FlynuoPipeFactory:_clear()
	return
end

function FlynuoPipeFactory:changeSpeed(speed)
	self._speed = speed

	for k, item in pairs(self._itemList) do
		item:changeSpeed(speed)
	end
end

local checkPipe = false
local isHit = false
local isPass = false
local pipePos = false
local playerPos = false
local boundsup = false
local boundsdown = false
local isHitPropItem = false

function FlynuoPipeFactory:isPlayerHit(playerbound)
	isHit = false

	if not self._player:isWudi() and #self._hitPipeList > 0 then
		checkPipe = self._hitPipeList[1]
		boundsup, boundsdown = checkPipe:getHitBounds()
		isHit = self:_checkInBound(playerbound, boundsup, boundsdown, checkPipe)

		if isHit then
			if self._player:isGetShield() then
				isHit = false

				self._player:littleWudi()
				GlobalDispatcher:dispatch(FlyNuoGameController.ShieldChange, FlyNuoGameController.ShieldState, Delete)
			else
				table_remove(self._hitPipeList, 1)
			end
		end
	end

	if isHit then
		AudioPlayerEx.instance:playEffect(30306)
	end

	return isHit
end

function FlynuoPipeFactory:_checkInBound(playerBound, boundsUp, boundsDown, checkPipe)
	local newplayerBound = {}
	local newboundsUp = {}

	for i = 0, 3 do
		newplayerBound[i] = self:worldPosToScreenPos(playerBound[i])
	end

	newboundsUp[1] = self:worldPosToScreenPos(boundsUp[1])

	if newplayerBound[0].y >= newboundsUp[1].y then
		if newplayerBound[2].x >= newboundsUp[1].x then
			return true
		end
	elseif newplayerBound[0].y <= 0 then
		return true
	else
		local playerRect = self._player:getRectTr()
		local rect1, rect2 = checkPipe:getRectTrs()
		local newplayerRect = self:_rectTransToScreenPos(playerRect)
		local newrect1 = self:_rectTransToScreenPos(rect1)

		if newplayerRect:Overlaps(newrect1) then
			return true
		else
			local newrect2 = self:_rectTransToScreenPos(rect2)

			if newplayerRect:Overlaps(newrect2) then
				return true
			end
		end

		return false
	end
end

function FlynuoPipeFactory:_inSmallRect(bound1, bound2)
	bound1[0] = self:worldPosToScreenPos(bound1[0])
	bound1[1] = self:worldPosToScreenPos(bound1[1])
	bound1[3] = self:worldPosToScreenPos(bound1[3])
	bound2[0] = self:worldPosToScreenPos(bound2[0])
	bound2[1] = self:worldPosToScreenPos(bound2[1])
	bound2[3] = self:worldPosToScreenPos(bound2[3])

	local l1 = (bound1[0].x + bound1[3].x) * 0.5 - (bound2[0].x + bound2[3].x) * 0.5
	local l2 = (bound1[3].x - bound1[0].x + bound2[3].x - bound2[0].x) * 0.5
	local s1 = (bound1[0].y + bound1[1].y) * 0.5 - (bound2[0].y + bound2[1].y) * 0.5
	local s2 = (bound1[1].y - bound1[0].y + bound2[1].y - bound2[0].y) * 0.5

	if l1 < 0 then
		l1 = -l1
	end

	if l2 < 0 then
		l2 = -l2
	end

	if s1 < 0 then
		s1 = -s1
	end

	if s2 < 0 then
		s2 = -s2
	end

	if l1 < l2 and s1 < s2 then
		return true
	end

	return false
end

function FlynuoPipeFactory:_rectTransToScreenPos(rectTr)
	rectTr:GetWorldCorners(self._cornors)

	local v0 = self:worldPosToScreenPos(self._cornors[0])
	local v1 = self:worldPosToScreenPos(self._cornors[2])

	return (UnityEngine.Rect.New(v0, v1 - v0))
end

function FlynuoPipeFactory:isPlayerPass()
	isPass = false

	if #self._hitPipeList > 0 then
		checkPipe = self._hitPipeList[1]
		pipePos = self:worldPosToScreenPos(checkPipe:getPassPipePos())
		playerPos = self:worldPosToScreenPos(self._player:getPos())
		isPass = playerPos.x > pipePos.x

		if isPass then
			table_remove(self._hitPipeList, 1)
		end
	end

	return isPass
end

function FlynuoPipeFactory:worldPosToScreenPos(pos)
	return self._uiCamera:WorldToScreenPoint(pos)
end

function FlynuoPipeFactory:playerEndFly(speed)
	self:changeSpeed(speed)
	self:stopPipe()
	self:_resetItems()
	self:_itemMove()
end

local playerScreenBound = {}
local propScreenBound = {}
local playerBound = false
local propBound = false

function FlynuoPipeFactory:checkPlayerHitPropItem()
	isHitPropItem = false

	if #self._hitPipeList > 0 then
		checkPipe = self._hitPipeList[1]

		if checkPipe:isItemBorn() and not checkPipe:isHitProp() then
			propBound = checkPipe:getPropBound()
			playerBound = self._player:getBound()

			for i = 0, 3 do
				propScreenBound[i] = self:worldPosToScreenPos(propBound[i])
				playerScreenBound[i] = self:worldPosToScreenPos(playerBound[i])
			end

			isHitPropItem = self:_inSmallRect(propScreenBound, playerScreenBound)

			if isHitPropItem then
				checkPipe:setHitPorp(true)

				local propType = checkPipe:getPropItemType()

				if propType == FlynuoPipe.ItemType.HpShield then
					GlobalDispatcher:dispatch(FlyNuoGameController.ShieldChange, FlyNuoGameController.ShieldState.Add)
				elseif propType == FlynuoPipe.ItemType.Score then
					FlyNuoModel.instance:addPropScore(checkPipe:getItemScore())
					GlobalDispatcher:dispatch(FlyNuoGameController.ScoreChange)
				end
			end
		end
	end

	if isHitPropItem then
		AudioPlayerEx.instance:playEffect(30304)
	end

	return isHitPropItem
end

return FlynuoPipeFactory
