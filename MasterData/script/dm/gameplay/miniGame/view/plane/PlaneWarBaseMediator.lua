-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarBaseMediator.lua

PlaneWarBaseMediator = class("PlaneWarBaseMediator", DmAreaViewMediator, _M)

PlaneWarBaseMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarBaseMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
PlaneWarBaseMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

local touchLayerTag = 999
local gameLayerTag = 990
local timeAnimTag = 800

function PlaneWarBaseMediator:initialize()
	super.initialize(self)
end

function PlaneWarBaseMediator:dispose()
	super.dispose(self)
end

function PlaneWarBaseMediator:userInject()
	return
end

function PlaneWarBaseMediator:onRegister()
	super.onRegister(self)
end

function PlaneWarBaseMediator:bindWidgets()
	return
end

function PlaneWarBaseMediator:adjustLayout(targetFrame)
	self._targetFrame = targetFrame

	super.adjustLayout(self, targetFrame)
end

function PlaneWarBaseMediator:initData(data)
	self._data = data
end

function PlaneWarBaseMediator:getPlaneWarSystem()
	return self._miniGameSystem:getPlaneWarSystem()
end

function PlaneWarBaseMediator:getData()
	return self._data
end

function PlaneWarBaseMediator:getMainPanel()
	return self._mainPanel
end

function PlaneWarBaseMediator:enterWithData(data)
	super.enterWithData(self, data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESIGN_ACTIVE, self, self.activeHomeIn)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BECOME_ACTIVE, self, self.activeHomeBack)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_STAGE_PAUSE, self, self.popPauseTipView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_PAUSETIP_CLOSE, self, self.closePauseTipView)
end

function PlaneWarBaseMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")

	local winSize = cc.Director:getInstance():getWinSize()

	self._touchLayer = ccui.Layout:create()

	self._touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
	self._touchLayer:setTouchEnabled(true)
	self._touchLayer:addTo(self._mainPanel, touchLayerTag):center(self._mainPanel:getContentSize())
	self._touchLayer:setVisible(false)
	self:createGameView()
end

function PlaneWarBaseMediator:isGameOver()
	if self._gameView and self._gameView.mediator then
		return self._gameView.mediator:isGameOver()
	end
end

function PlaneWarBaseMediator:getIsRunGame()
	return self._isRunGame
end

function PlaneWarBaseMediator:createGameView()
	if not self._gameView then
		self._isRunGame = false

		local view = self:getInjector():getInstance("PlaneWarGameView")

		self._gameView = view

		if view then
			local targetPos = self._mainPanel:convertToNodeSpace(cc.p(self._targetFrame.x + self._targetFrame.width / 2, self._targetFrame.y + self._targetFrame.height / 2))
			local viewOffsetX = targetPos.x - 568

			view:addTo(self._mainPanel, gameLayerTag):setPosition(targetPos):offset(-568, -320)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				mediator:enterWithData(self, self:getData(), viewOffsetX)

				self._gameView.mediator = mediator
			end
		end
	end

	return self._gameView
end

function PlaneWarBaseMediator:rCreateGameView()
	if self._gameView then
		self._gameView:removeFromParent(true)

		self._gameView = nil
	end

	self:createGameView()
end

function PlaneWarBaseMediator:runGame()
	if self._gameView then
		self._gameView.mediator:runGame()

		self._isRunGame = true
	end
end

local animFrame = {
	3,
	23,
	43,
	57
}

function PlaneWarBaseMediator:runSleepAnim(func)
	self._mainPanel:removeChildByTag(timeAnimTag, true)

	local sleepAnim = cc.MovieClip:create("go_kaishitongguan")

	sleepAnim:setVisible(false)
	sleepAnim:stop()
	sleepAnim:addTo(self._mainPanel, 999, timeAnimTag):center(self._mainPanel:getContentSize())
	sleepAnim:setVisible(true)
	sleepAnim:gotoAndPlay(0)
	self._touchLayer:setVisible(true)
	sleepAnim:addEndCallback(function()
		sleepAnim:removeFromParent(true)
		self._touchLayer:setVisible(false)

		if func then
			func()
		end
	end)

	local effectSound = {
		"Se_Effect_Monster_2",
		"Se_Effect_Monster_1",
		"Se_Effect_Monster_1",
		"Se_Effect_Monster_Go"
	}

	for i = 1, #animFrame do
		sleepAnim:addCallbackAtFrame(animFrame[i], function(fid, mc, frameIndex)
			AudioEngine:getInstance():playEffect(effectSound[i])
		end)
	end
end

function PlaneWarBaseMediator:resume()
	if self:isGameOver() then
		return
	end

	self._gameView.mediator:resume()

	self._isRunGame = true
end

function PlaneWarBaseMediator:pause()
	self._gameView.mediator:pause()

	self._isRunGame = false
end

function PlaneWarBaseMediator:setPopPasueTip(popPasueTip)
	self._popPasueTip = popPasueTip
end

function PlaneWarBaseMediator:activeHomeBack(event)
	if not self._popPasueTip then
		if self:isGameOver() then
			return
		end

		self:runSleepAnim(function()
			self:resume()
		end)
	end
end

function PlaneWarBaseMediator:activeHomeIn(event)
	if self._isRunGame then
		self:pause()
	end
end

function PlaneWarBaseMediator:popPauseTipView(event)
	self._popPasueTip = true
end

function PlaneWarBaseMediator:closePauseTipView(event)
	self._popPasueTip = false
end
