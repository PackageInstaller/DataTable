-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/view/HolyStripeExploreGameView.lua

module("logic.extensions.holystripeexplore.view.HolyStripeExploreGameView", package.seeall)

local HolyStripeExploreGameView = class("HolyStripeExploreGameView", ViewComponent)

function HolyStripeExploreGameView:buildUI()
	HolyStripeExploreGameView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnPlay = self:getGo("btnPlay")
	self._txtPlay = goutil.findChildTextComponent(self._btnPlay, "txt")
	self._txtCountdown = self:getTxt("countdown/txt")
	self._txtTip = self:getTxt("title/txtTip")
	self._goBoard = self:getGo("board")
	self._numbersParent = goutil.findChild(self._goBoard, "numbers")
	self._goNum = goutil.findChild(self._numbersParent, "num")
	self._goPlayer = goutil.findChild(self._goBoard, "player")
	self._pos_first = goutil.findChild(self._goBoard, "pos_first")
	self._pos_end = goutil.findChild(self._goBoard, "pos_end")
	self._chessCells = {}
end

function HolyStripeExploreGameView:bindEvents()
	HolyStripeExploreGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnPlay, self._onClickPlay, self)
end

function HolyStripeExploreGameView:unbindEvents()
	HolyStripeExploreGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPlay)
	GameUtil.rmClickHandler(self._btnClose)
end

function HolyStripeExploreGameView:onEnter()
	HolyStripeExploreGameView.super.onEnter(self)
	HolyStripeExploreController:startGame()
	self:_resetGame()
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeExploreStartGame, self._onReady, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeExploreFinshGame, self._onInfoUpdate, self)
end

function HolyStripeExploreGameView:onExit()
	HolyStripeExploreGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeExploreStartGame, self._onReady, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeExploreFinshGame, self._onInfoUpdate, self)
	removetimer(self._onCountDown, self)
	self:_endMove()
	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeExploreMoveChess)
end

function HolyStripeExploreGameView:_onClickClose()
	if self._gameStare == 0 or self._gameStare == 1 or self._gameStare == 4 then
		self:close()
	end
end

function HolyStripeExploreGameView:_onClickPlay()
	if self._gameStare == 1 then
		self:_onGameStart()
	elseif self._gameStare == 2 then
		self:_onGameEnd()
	elseif self._gameStare == 4 then
		self:close()
	end
end

function HolyStripeExploreGameView:_resetGame()
	self._gameStare = 0
	self._txtPlay.text = lang("开始")
	self._countTimer = checkint(HolyStripeExploreConfig.instance:getCommonValue("GAME_COUNT_DOWN"))
	self._moveTimer = 0
	self._txtCountdown.text = langPara("%ss", self._countTimer)
	self._curSpeed = HolyStripeExploreModel.instance:getCurSpeed()
	self._cellNums = 6
	self._txtTip.text = lang("本次行进步数")

	self:buildBoard()

	self._textInt = 0
end

function HolyStripeExploreGameView:buildBoard()
	goutil.setActive(self._goNum, false)

	local nums = HolyStripeExploreModel.instance:getCurNumberList()

	for i = 1, self._cellNums do
		local transId = math.ceil(math.random(6))

		nums[transId] = nums[1]
		nums[1] = nums[transId]
	end

	for i = 1, self._cellNums do
		local cell = self._chessCells[i]

		if cell and cell.go then
			-- block empty
		else
			cell = {
				go = goutil.cloneAndSetParent(self._goNum, self._numbersParent.transform, "num" .. i)
			}
		end

		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.showValue = nums[i]
		cell.txt.text = cell.showValue
		self._chessCells[i] = cell

		goutil.setActive(cell.go, true)
	end

	local cellWidth = GameUtil.getWidth(self._goNum)

	self._curCellWidth = cellWidth

	local v2 = GameUtil.getAnchoredPos(self._goPlayer)

	self._pos_first_x = cellWidth * self._cellNums / 2

	GameUtil.setAnchoredPos(self._pos_first, -1 * self._pos_first_x, v2.y)
	GameUtil.setAnchoredPos(self._pos_end, self._pos_first_x, v2.y)
	GameUtil.setAnchoredPos(self._goPlayer, -1 * self._pos_first_x, v2.y)

	self._toLeft = false
end

function HolyStripeExploreGameView:_onReady()
	self._gameStare = 1
end

function HolyStripeExploreGameView:_onGameStart()
	if self._gameStare == 1 then
		self._gameStare = 2
		self._txtPlay.text = lang("确定")

		self:_startMove()
		settimer(0.1, self._onCountDown, self)
	end
end

function HolyStripeExploreGameView:_onGameEnd()
	if self._gameStare == 2 then
		self._gameStare = 3

		self:_endMove()
		removetimer(self._onCountDown, self)

		local v2 = GameUtil.getAnchoredPos(self._goPlayer)
		local moveWidth = checknumber(v2.x + self._pos_first_x)
		local curCellId = Mathf.Clamp(math.ceil(moveWidth / self._curCellWidth), 1, self._cellNums)

		self._step = self._chessCells[curCellId].showValue

		local encryptedKey = HolyStripeExploreModel.instance:getEncryptedKey(self._step)

		HolyStripeExploreController.instance:gameMove(self._step, encryptedKey)
	end
end

function HolyStripeExploreGameView:_onInfoUpdate()
	self._gameStare = 4

	FloatWordMgr.instance:show(langPara("本次行进步数为%s步", self._step))

	self._txtTip.text = langPara("本次行进步数:%s", self._step)
	self._txtPlay.text = lang("关闭")
end

function HolyStripeExploreGameView:_startMove()
	self._toLeft = not self._toLeft
	self._tweenList = self._tweenList or {}

	if self._toLeft then
		if not self._pos_end then
			local nextPos = self._pos_first
			local tween = self._goPlayer.transform:DOMove(nextPos.transform.position, self._curSpeed):SetEase(DG.Tweening.Ease.Linear)

			table.insert(self._tweenList, tween)
		end
	end
end

function HolyStripeExploreGameView:_endMove()
	if self._tweenList then
		self._goPlayer.transform:DOKill()

		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end
end

function HolyStripeExploreGameView:_onCountDown()
	self._txtCountdown.text = langPara("%.1fs", self._countTimer)
	self._countTimer = self._countTimer - 0.1
	self._moveTimer = self._moveTimer + 0.1

	if self._countTimer <= 0 then
		self._txtCountdown.text = langPara("0s")

		self:_onGameEnd()

		return
	end

	if self._moveTimer >= self._curSpeed then
		self._moveTimer = 0

		self:_startMove()
	end
end

return HolyStripeExploreGameView
