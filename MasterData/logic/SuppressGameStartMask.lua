-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameStartMask.lua

module("logic.extensions.suppressgame.view.SuppressGameStartMask", package.seeall)

local SuppressGameStartMask = class("SuppressGameStartMask", ViewComponent)

function SuppressGameStartMask:buildUI()
	SuppressGameStartMask.super.buildUI(self)

	self._clickMask = goutil.findChild(self.mainGO, "clickMask")
	self._txtTipsGo = goutil.findChild(self.mainGO, "txtTips")
	self._imgNum = goutil.findChild(self.mainGO, "txtTips/imgNum")
	self._UIImgNumeralText = self._imgNum:GetComponent(typeof(UIImgNumeralText))
end

function SuppressGameStartMask:bindEvents()
	SuppressGameStartMask.super.bindEvents(self)
	GameUtil.addClickHandler(self._clickMask, self._onClickMask, self)
end

function SuppressGameStartMask:unbindEvents()
	SuppressGameStartMask.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._clickMask)
end

function SuppressGameStartMask:onEnter()
	SuppressGameStartMask.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._handler, self._handlerObj = params[1], params[2]

	self:_onSetUI()
	self:_readyStartGame()
end

function SuppressGameStartMask:onExit()
	SuppressGameStartMask.super.onExit(self)
	removetimer(self._startGameCountDown, self)
end

function SuppressGameStartMask:_onSetUI()
	return
end

function SuppressGameStartMask:_readyStartGame()
	self._countDown = 3
	self._isRunning = true

	GameUtil.SetActive(self._txtTipsGo, true)
	removetimer(self._startGameCountDown, self)
	settimer(1, self._startGameCountDown, self, true)
	self:_startGameCountDown()
end

function SuppressGameStartMask:_startGameCountDown()
	if self._countDown < 1 then
		removetimer(self._startGameCountDown, self)
		self:_startGame()

		return
	end

	self._UIImgNumeralText:SetText(self._countDown)

	self._countDown = self._countDown - 1
end

function SuppressGameStartMask:_startGame()
	removetimer(self._startGameCountDown, self)

	self._isRunning = false

	GameUtil.SetActive(self._txtTipsGo, true)
	self:close()
	GameUtil.callBack(self._handler, self._handlerObj)
	FloatWordMgr.instance:show("开始！")
end

function SuppressGameStartMask:_onClickMask()
	if self._isRunning then
		-- block empty
	end
end

return SuppressGameStartMask
