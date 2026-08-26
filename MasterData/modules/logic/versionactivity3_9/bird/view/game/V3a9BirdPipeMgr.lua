-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/V3a9BirdPipeMgr.lua

module("modules.logic.versionactivity3_9.bird.view.game.V3a9BirdPipeMgr", package.seeall)

local V3a9BirdPipeMgr = class("V3a9BirdPipeMgr", BaseView)
local PIPE_WIDTH = 150

function V3a9BirdPipeMgr:onInitView()
	self._gopipe = gohelper.findChild(self.viewGO, "root/obstaclelayout/#go_pipe")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9BirdPipeMgr:addEvents()
	return
end

function V3a9BirdPipeMgr:removeEvents()
	return
end

function V3a9BirdPipeMgr:_editableInitView()
	gohelper.setActive(self._gopipe, false)

	self._pipeItems = self:getUserDataTb_()
	self._canUsePipeItems = self:getUserDataTb_()
	self._usedPipeItems = self:getUserDataTb_()
	self._pipeHalfWidth = PIPE_WIDTH / 2
end

function V3a9BirdPipeMgr:onUpdateParam()
	return
end

function V3a9BirdPipeMgr:onOpen()
	self._actId = V3a9BirdModel.instance:getActId()
	self._episodeId = V3a9BirdModel.instance:getEnterGameEpisodeId()
	self._screenWidth = gohelper.getUIScreenWidth()
	self._screenHeight = V3a9BirdModel.instance:getScreenBound()

	self:refreshParam()

	self._leftBoundary = -self._screenWidth

	self:_startGame()
end

function V3a9BirdPipeMgr:refreshDifficult()
	V3a9BirdModel.instance:passPipe()
end

function V3a9BirdPipeMgr:refreshParam()
	self._spawnDistance = V3a9BirdModel.instance:getGameParam(V3a9BirdEnum.BirdConst.spawnDistance)
	self._scrollSpeed = V3a9BirdModel.instance:getGameParam(V3a9BirdEnum.BirdConst.scrollSpeed)
	self._pipeGap = V3a9BirdModel.instance:getGameParam(V3a9BirdEnum.BirdConst.pipeGap)
	self._maxCount = math.ceil(self._screenWidth / self._spawnDistance) + 5
end

function V3a9BirdPipeMgr:UpdateFrame(dt)
	if V3a9BirdModel.instance:isGameOver() then
		return
	end

	local moveDistance = self._scrollSpeed * dt
	local birdEntity = self.viewContainer:getBirdEntity()
	local birdRect = birdEntity and birdEntity:getBirdRect()
	local leftBoundary = self._leftBoundary
	local usedItems = self._usedPipeItems
	local canUseItems = self._canUsePipeItems

	for i = #usedItems, 1, -1 do
		local item = usedItems[i]

		item.mo:moveX(moveDistance)
		item.entity:refreshPos()

		local posX = item.mo:getPosX()
		local pipeRight = posX + self._pipeHalfWidth

		if not item.mo:isPass() and birdRect and pipeRight < birdRect.left then
			item.mo:setPass()
			V3a9BirdModel.instance:passPipe()
			self.viewContainer:refreshScore()
			self:refreshParam()
			AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_chongran_fly_coin)
		end

		if posX < leftBoundary then
			item.entity:setActive(false)

			canUseItems[#canUseItems + 1] = item

			table.remove(usedItems, i)
		end
	end

	if birdRect then
		for _, item in ipairs(usedItems) do
			if self:_checkCollision(birdRect, item.mo) then
				V3a9BirdModel.instance:gameOver()
				AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_wangshi_argus_level_over)

				break
			end
		end
	end

	self:_createPipeItem()
end

function V3a9BirdPipeMgr:_checkCollision(birdRect, pipeMO)
	local pipeX = pipeMO:getPosX()
	local pipeLeft = pipeX - self._pipeHalfWidth
	local pipeRight = pipeX + self._pipeHalfWidth

	if pipeLeft > birdRect.right or pipeRight < birdRect.left then
		return false
	end

	local pipeTop, pipeBottom = pipeMO:getTopBottomY()

	if pipeTop < birdRect.top or pipeBottom > birdRect.bottom then
		return true
	end

	return false
end

function V3a9BirdPipeMgr:_startGame()
	self:_createPipeItem()
end

function V3a9BirdPipeMgr:_createPipeItem()
	while #self._usedPipeItems < self._maxCount do
		local item = self:_getCanUsePipeEntity()
		local posX, topY, bottomY = self:_getTopBottomY()

		item.mo:initMO(posX, topY, bottomY)
		item.entity:setMo(item.mo)
		item.entity:refreshPos()
		item.entity:setActive(true)
		table.insert(self._usedPipeItems, item)
	end
end

function V3a9BirdPipeMgr:_getTopBottomY()
	local lastItem = self._usedPipeItems[#self._usedPipeItems]
	local posX = 0

	posX = lastItem and lastItem.mo:getPosX() + self._spawnDistance or self._screenWidth / 2

	local gapCenter = self:_getRandomGapCenter()
	local halfGap = self._pipeGap / 2
	local topY = gapCenter + halfGap
	local bottomY = gapCenter - halfGap

	return posX, topY, bottomY
end

function V3a9BirdPipeMgr:_getRandomGapCenter()
	local maxOffset = self._screenHeight / 4

	return (math.random() * 2 - 1) * maxOffset
end

function V3a9BirdPipeMgr:_getCanUsePipeEntity()
	local canUseItems = self._canUsePipeItems
	local count = #canUseItems

	if count > 0 then
		canUseItems[count] = nil

		return canUseItems[count]
	end

	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self._gopipe)

	local mo = V3a9BirdPipeMO.New()

	item.entity = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, V3a9BirdPipeEntity)
	item.mo = mo

	return item
end

function V3a9BirdPipeMgr:resetPipes()
	local usedItems = self._usedPipeItems
	local canUseItems = self._canUsePipeItems

	while #usedItems > 0 do
		local item = table.remove(usedItems)

		item.entity:setActive(false)

		canUseItems[#canUseItems + 1] = item
	end

	self:_startGame()
end

function V3a9BirdPipeMgr:onClose()
	return
end

function V3a9BirdPipeMgr:onDestroyView()
	return
end

return V3a9BirdPipeMgr
