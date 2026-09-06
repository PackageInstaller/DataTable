-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/view/WeeklyBigBoxGameView.lua

module("logic.extensions.weeklybigbox.view.WeeklyBigBoxGameView", package.seeall)

local WeeklyBigBoxGameView = class("WeeklyBigBoxGameView", ViewComponent)
local DF_Alive = 0
local DF_Hitting = 1
local DF_DestroyNextFrame = 2
local DF_Destroyed = 3

function WeeklyBigBoxGameView:ctor()
	WeeklyBigBoxGameView.super.ctor(self)
end

function WeeklyBigBoxGameView:unbindEvents()
	WeeklyBigBoxGameView.super.unbindEvents(self)
end

function WeeklyBigBoxGameView:bindEvents()
	WeeklyBigBoxGameView.super.bindEvents(self)
end

function WeeklyBigBoxGameView:buildUI()
	WeeklyBigBoxGameView.super.buildUI(self)

	self._container = self:getGo("container")
	self._txtScore = self:getTxt("score/txtScore")
	self._cell = self:getGo("cell")
	self._addScoreCell = self:getGo("addScoreCell")
	self._tip = self:getGo("tip")
	self._downCount = self:getGo("downCount")
	self._time = self:getGo("time")
	self._containerWidth = GameUtil.getWidth(self._container)
	self._halfContainerWidth = self._containerWidth * 0.5
	self._cells = {}
	self._addScore2Tween = {}
	self._disappearTweens = {}
	self._cell2Data = {}
	self.destroyed = true
end

function WeeklyBigBoxGameView:onExit()
	WeeklyBigBoxGameView.super.onExit(self)
	removetimer(self._tick, self)

	self.destroyed = true

	self:_disposeReadyCounter()
	self:_disposePopupTips()
	self:_disposeCounter()
	self:_destroyAllCell()
	WeeklyBigBoxController.instance:reqEndGame(self._redPackageNum)
end

function WeeklyBigBoxGameView:_destroyAllCell()
	for _, cell in ipairs(self._cells) do
		local data = self._cell2Data[cell]

		if data then
			PointerDownHandler.Get(cell):RemoveLuaHandler(data.pointerDownHandler)
		end
	end

	for addScore, _ in pairs(self._addScore2Tween) do
		self:_destroyAddScore(addScore)
	end

	for cell, _ in pairs(self._disappearTweens) do
		self:_destroyDisappearTween(cell)
	end

	goutil.clearChildren(self._container)

	self._cells = {}
	self._cell2Data = {}
	self._addScore2Tween = {}
	self._disappearTweens = {}
end

function WeeklyBigBoxGameView:_destroyAddScore(targetItem)
	if not goutil.isNil(targetItem) then
		local tween = self._addScore2Tween[targetItem]

		tween:Kill(false)

		self._addScore2Tween[targetItem] = nil

		goutil.destroy(targetItem)
	end
end

function WeeklyBigBoxGameView:_destroyDisappearTween(targetItem)
	if not goutil.isNil(targetItem) then
		local tween = self._disappearTweens[targetItem]

		if tween then
			tween:Kill(false)
		end

		self._disappearTweens[targetItem] = nil
	end
end

function WeeklyBigBoxGameView:onEnter()
	WeeklyBigBoxGameView.super.onEnter(self)

	self.destroyed = false
	self._redPackageNum = 0
	self._rowIndex = 0
	self._maxRedPackageNum = WeeklyBigBoxConfig.instance:getCommonValue("RED_PACKAGE_MAX_NUM", true)

	self:_destroyAllCell()
	self:_disposePopupTips()

	self._tipsComp = WBB_UIPopupTips.New(self._tip)

	self._tipsComp:hide()
	self:_disposeCounter()

	self._timeComp = WBB_UITimeCounter.New(self._time)

	self._timeComp:stop()
	self:_disposeReadyCounter()

	self._readyCounterComp = WBB_UITimeCounter.New(self._downCount)

	self._readyCounterComp:stop()
	self:_updateScore()
	self:_initGenerateRandomData()

	local readyTimeSce = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_COUNDOWN", true)

	self._readyCounterComp:play(readyTimeSce, self._onGameReady, self)
end

function WeeklyBigBoxGameView:_disposeReadyCounter()
	if self._readyCounterComp then
		self._readyCounterComp:dispose()

		self._readyCounterComp = nil
	end
end

function WeeklyBigBoxGameView:_disposePopupTips()
	if self._tipsComp then
		self._tipsComp:dispose()

		self._tipsComp = nil
	end
end

function WeeklyBigBoxGameView:_disposeCounter()
	if self._timeComp then
		self._timeComp:dispose()

		self._timeComp = nil
	end
end

function WeeklyBigBoxGameView:_onGameReady()
	local gameTimeSec = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_TIME", true)

	self._timeComp:play(gameTimeSec, self._onGameEndTimeOut, self, lang("WeeklyBigBoxGameView__4"))

	self._beginTimeStamp = UnityEngine.Time.realtimeSinceStartup

	settimer(0.02, self._tick, self)

	self._bCanClick = true
end

function WeeklyBigBoxGameView:_onGameEndTimeOut()
	self._bCanClick = false

	self._tipsComp:show(1.6, lang("WeeklyBigBoxGameView__3"), self.close, self)
end

function WeeklyBigBoxGameView:_onGameEndFull()
	self._bCanClick = false

	self._timeComp:stop()
	self._tipsComp:show(1.6, lang("WeeklyBigBoxGameView__2"), self.close, self)
end

function WeeklyBigBoxGameView:_tick()
	if self._bCanClick then
		local delta = UnityEngine.Time.realtimeSinceStartup - self._beginTimeStamp

		for cell, data in pairs(self._cell2Data) do
			if data.destroyingFlag == DF_Alive then
				local x = data.beginX
				local y = data.beginY - (delta - data.delta) * data.speedY

				if y >= -1200 then
					GameUtil.setLocalPos(cell, x, y, 0)
				else
					data.destroyingFlag = DF_DestroyNextFrame
				end
			end
		end

		for i = #self._cells, 1, -1 do
			local cell = self._cells[i]
			local data = self._cell2Data[cell]

			if cell and (not data or data and data.destroyingFlag == DF_DestroyNextFrame) then
				if data then
					data.destroyingFlag = DF_Destroyed
				end

				self:_destroyDisappearTween(cell)
				PointerDownHandler.Get(cell):RemoveLuaHandler(data.pointerDownHandler)
				table.remove(self._cells, i)
				goutil.destroy(cell)

				self._cell2Data[cell] = nil
			end
		end

		local newRowIndex = math.ceil(delta / self._generateDelta)

		if newRowIndex > self._rowIndex then
			self:_tryAddCells()

			self._rowIndex = newRowIndex
		end
	end
end

function WeeklyBigBoxGameView:_initGenerateRandomData()
	self._gridCountX = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_GRID_X_COUNT", true)
	self._generateDelta = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_GENERATE_DELTA", true)

	local speedRangeStr = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_DROP_SPEED")

	self._speedRange = string.splitToNumber(speedRangeStr, "#")

	local angleRangeStr = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_DROP_ANGLE")

	self._angleRange = string.splitToNumber(angleRangeStr, "#")
	self._rate = WeeklyBigBoxConfig.instance:getClientCommonValue("GAME_DROP_RATE", true)
	self._gridSizeX = self._containerWidth / self._gridCountX
end

function WeeklyBigBoxGameView:_tryAddCells()
	local delta = UnityEngine.Time.realtimeSinceStartup - self._beginTimeStamp

	for i = 1, self._gridCountX do
		if math.random() <= self._rate then
			local cell = goutil.cloneAndSetParent(self._cell, self._container.transform)

			goutil.setActive(cell, true)

			local image = cell:GetComponent("Image")
			local x = self:_randomInRange(self._gridSizeX * (i - 1), self._gridSizeX * i) - self._halfContainerWidth
			local y = self:_randomInRange(0, 300)
			local speedY = self:_randomInRange(self._speedRange[1], self._speedRange[2])
			local angle = self:_randomInRange(self._angleRange[1], self._angleRange[2])

			GameUtil.setLocalPos(cell, x, y, 0)
			GameUtil.setLocalRotation(cell, 0, 0, angle)

			self._cell2Data[cell] = {
				speedY = speedY,
				beginY = y,
				beginX = x,
				delta = delta,
				image = image,
				destroyingFlag = DF_Alive
			}
			self._cell2Data[cell].pointerDownHandler = PointerDownHandler.Get(cell):AddLuaHandler(function(go, data)
				self:_hitCell(cell)
			end)

			table.insert(self._cells, cell)
		end
	end
end

function WeeklyBigBoxGameView:_hitCell(cell)
	if self._bCanClick then
		local data = self._cell2Data[cell]

		if data and data.destroyingFlag == DF_Alive then
			data.destroyingFlag = DF_Hitting

			local addScore = goutil.cloneAndSetParent(self._addScoreCell, self._container.transform)

			goutil.setActive(addScore, true)

			local itemPos = GameUtil.getLocalPos(cell)

			GameUtil.setLocalPos(addScore, itemPos.x + 60, itemPos.y + 80, 0)

			self._addScore2Tween[addScore] = self:_doFlyTween(addScore, function()
				self:_destroyAddScore(addScore)
			end)
			self._disappearTweens[cell] = self:_doDisappear(data.image, function()
				self:_destroyDisappearTween(cell)

				if data.destroyingFlag == DF_Alive then
					data.destroyingFlag = DF_DestroyNextFrame
				end
			end)
			self._redPackageNum = self._redPackageNum + 1

			self:_updateScore()

			if self._redPackageNum >= self._maxRedPackageNum then
				self:_onGameEndFull()
			end
		end
	end
end

function WeeklyBigBoxGameView:_doFlyTween(targetGo, onCompleteCallback)
	local transform = targetGo.transform
	local s = DG.Tweening.DOTween.Sequence()

	GameUtil.setLocalScale(targetGo, 0.6, 0.6, 0.6)
	s:Join(transform:DOScale(Vector3.New(1.2, 1.2, 1.2), 0.8))
	s:OnComplete(function()
		if onCompleteCallback then
			onCompleteCallback()
		end
	end)

	return s
end

function WeeklyBigBoxGameView:_doDisappear(image, onCompleteCallback)
	local function updateTween(num)
		Game.ImageUtil.SetImageAlpha(image, num)
	end

	local s = DG.Tweening.DOTween.Sequence()

	s:Append(TweenUtil.DOTweenNum(1, 0, 0.6, updateTween, {}))
	s:OnComplete(function()
		if onCompleteCallback then
			onCompleteCallback()
		end
	end)

	return s
end

function WeeklyBigBoxGameView:_getRandomPos(colArray, gridCountY)
	local result = {}

	for _, v in ipairs(colArray) do
		local array = {}

		for i = 1, gridCountY do
			if i <= v then
				table.insert(array, 1)
			else
				table.insert(array, 0)
			end
		end

		GameUtil.permuteArray(array)
		table.insert(result, array)
	end

	return result
end

function WeeklyBigBoxGameView:_randomInRange(minValue, maxValue)
	minValue, maxValue = self:_confirmMax(minValue, maxValue)

	return math.random() * (maxValue - minValue) + minValue
end

function WeeklyBigBoxGameView:_confirmMax(a, b)
	if a <= b then
		return a, b
	else
		return b, a
	end
end

function WeeklyBigBoxGameView:_updateScore()
	self._txtScore.text = langPara("WeeklyBigBoxGameView__1", self._redPackageNum, self._maxRedPackageNum)
end

return WeeklyBigBoxGameView
