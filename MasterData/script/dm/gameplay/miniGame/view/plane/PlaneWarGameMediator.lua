-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarGameMediator.lua

PlaneWarGameMediator = class("PlaneWarGameMediator", DmAreaViewMediator, _M)

PlaneWarGameMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarGameMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
PlaneWarGameMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
PlaneWarGameMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.back_btn"] = "onClickBack"
}

function PlaneWarGameMediator:initialize()
	super.initialize(self)
end

function PlaneWarGameMediator:dispose()
	super.dispose(self)
end

function PlaneWarGameMediator:userInject()
	return
end

function PlaneWarGameMediator:onRegister()
	super.onRegister(self)
end

function PlaneWarGameMediator:bindWidgets()
	return
end

function PlaneWarGameMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function PlaneWarGameMediator:enterWithData(pMediator, data, viewOffsetX)
	self._pMediator = pMediator

	self:mapButtonHandlersClick(kBtnHandlers)
	self:initData(data)
	self:initNodes(viewOffsetX)
	self:enterTime()
	self:createPlaneWarController()
	self:refreshRewardPanel()
	self:refreshScorePanel()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_QUITGAME, self, self.quitGame)
end

function PlaneWarGameMediator:initData(data)
	self._data = data
end

function PlaneWarGameMediator:initNodes(viewOffsetX)
	viewOffsetX = viewOffsetX or 0
	self._mainPanel = self:getView():getChildByFullName("main")
	self._backBtn = self._mainPanel:getChildByFullName("back_btn")

	self._backBtn:setLocalZOrder(10)
	self._backBtn:setVisible(false)

	self._rewardNode = self._mainPanel:getChildByFullName("rewardnode")

	self._rewardNode:setLocalZOrder(10)
	self._rewardNode:setVisible(false)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local safeAreaInset = director:getOpenGLView():getSafeAreaInset()
	local winSizeWidth = winSize.width - safeAreaInset.left - safeAreaInset.right - 1136
	local winSizeHeight = winSize.height - 640

	self._rewardNode:offset(-winSizeWidth / 2, winSizeHeight / 2)
	self._backBtn:offset(winSizeWidth / 2 - viewOffsetX, winSizeHeight / 2)
end

function PlaneWarGameMediator:enterTime()
	local key = self._developSystem:getPlayer():getRid() .. MiniGameType.kPlaneWar .. "enterTime"
	local curTime = self._gameServerAgent:remoteTimestamp()

	cc.UserDefault:getInstance():setIntegerForKey(key, curTime)
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	self:dispatch(Event:new(EVT_CLUB_PUSHREDPOINT_SUCC))
end

function PlaneWarGameMediator:refreshScorePanel()
	local scoreLabel = self._rewardNode:getChildByFullName("scorelabel1")

	scoreLabel:setString(Strings:get("Activity_Jump_UI_6", {
		Num1 = self._fightData:getScore()
	}))
end

function PlaneWarGameMediator:refreshRewardPanel()
	local rewardParent = self._rewardNode:getChildByFullName("rewardlabel")

	rewardParent:removeAllChildren(true)

	local scoreLabel = self._rewardNode:getChildByFullName("scorelabel1")

	scoreLabel:setString(Strings:get("Activity_Jump_UI_6", {
		Num1 = self._fightData:getScore()
	}))

	local rewardList = self._fightData:getRewardList()

	rewardParent:setVisible(table.nums(rewardList) > 0)

	local width = 110
	local list = {}

	if rewardList[CurrencyIdKind.kDiamond] then
		local reward = rewardList[CurrencyIdKind.kDiamond]

		list[#list + 1] = {
			id = reward.id,
			amount = reward.amount
		}
	end

	for id, amount in pairs(rewardList) do
		if id ~= CurrencyIdKind.kDiamond and id ~= CurrencyIdKind.kGold then
			list[#list + 1] = {
				id = id,
				amount = amount.amount
			}
		end
	end

	if rewardList[CurrencyIdKind.kGold] then
		local reward = rewardList[CurrencyIdKind.kGold]

		list[#list + 1] = {
			id = reward.id,
			amount = reward.amount
		}
	end

	local rewardBg = self._rewardNode:getChildByFullName("bg")

	for i = 1, #list do
		local data = list[i]
		local icon = IconFactory:createIcon(data, {
			showAmount = false
		})

		icon:setScale(0.3)
		icon:setAnchorPoint(cc.p(0, 0))
		icon:addTo(rewardParent):posite(width, 0)

		width = width + 40

		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 20)

		label:setAnchorPoint(cc.p(0, 0.5))
		label:setString(tostring(data.amount))
		label:addTo(rewardParent):posite(width, 13)

		self._width = width
		width = width + label:getContentSize().width + 8
		self._label = label
	end

	local line = self._rewardNode:getChildByFullName("line")

	line:setVisible(table.nums(rewardList) > 0)

	if table.nums(rewardList) > 0 then
		rewardBg:setContentSize(cc.size(self._width + self._label:getContentSize().width + 8 + 160, 31))
	else
		rewardBg:setContentSize(cc.size(140, 31))
	end
end

function PlaneWarGameMediator:isGameOver()
	if not self._planeWarController then
		return true
	elseif self._planeWarController and self._planeWarController:getIsGameOver() == true then
		return true
	end

	return false
end

function PlaneWarGameMediator:quitGame()
	local mySelf = self

	mySelf:refreshScorePanel()
	mySelf:pause()

	local params = {
		isWin = false,
		planes = mySelf._fightData:getEnemyList(),
		score = mySelf._fightData:getScore(),
		rewards = mySelf._fightData:collectServerData(),
		time = mySelf._planeWarController:getPlayTime()
	}

	mySelf:dispatch(Event:new(EVT_PLANEWAR_GAMEOVER, params))
end

function PlaneWarGameMediator:createPlaneWarController()
	self._isPlayWinAnim = false

	if self._planeWarController then
		self._planeWarController:remove()
		self._planeWarController:getMainNode():removeFromParent(true)

		self._planeWarController = nil
	end

	require("dm.gameplay.miniGame.model.plane.PlaneWarController")

	local mySelf = self
	local data = self._data

	function data:gameOver()
		mySelf:refreshScorePanel()
		mySelf:pause()

		local params = {
			isWin = false,
			planes = mySelf._fightData:getEnemyList(),
			score = mySelf._fightData:getScore(),
			rewards = mySelf._fightData:collectServerData(),
			time = mySelf._planeWarController:getPlayTime()
		}

		mySelf:dispatch(Event:new(EVT_PLANEWAR_GAMEOVER, params))
	end

	function data:win()
		mySelf:dispatch(Event:new(EVT_CLUB_MINIGAME_STOPSCENESOUND_CONFIRM))
		mySelf:refreshScorePanel()
		mySelf:pause()

		mySelf._isPlayWinAnim = true

		mySelf._backBtn:setTouchEnabled(false)
		AudioEngine:getInstance():playEffect("Se_Effect_Monster_Success")

		local winAnim = cc.MovieClip:create("tongguan_meishidazuozhantiaoyitiao")
		local displayNode = winAnim:getChildByFullName("bg.bg"):getChildByName("bitmap")
		local repleaceNode = cc.Sprite:create("asset/ui/minigame/Fly_img_bg_gxtg.png")

		repleaceNode:setAnchorPoint(cc.p(0, 0.26))
		repleaceNode:addTo(displayNode:getParent())
		repleaceNode:setPosition(displayNode:getPosition())
		displayNode:removeFromParent()

		local displayNode = winAnim:getChildByFullName("bg1.bg"):getChildByName("bitmap")
		local repleaceNode = cc.Sprite:create("asset/ui/minigame/Fly_img_bg_gxtg.png")

		repleaceNode:addTo(displayNode:getParent())
		repleaceNode:setAnchorPoint(cc.p(0, 0.26))
		repleaceNode:setPosition(displayNode:getPosition())
		displayNode:removeFromParent()
		winAnim:addTo(mySelf._mainPanel):center(mySelf._mainPanel:getContentSize())
		winAnim:addEndCallback(function()
			mySelf:refreshScorePanel()
			winAnim:stop()
			winAnim:removeFromParent(true)

			local params = {
				isWin = true,
				planes = mySelf._fightData:getEnemyList(),
				score = mySelf._fightData:getScore(),
				rewards = mySelf._fightData:collectServerData(),
				time = mySelf._planeWarController:getPlayTime()
			}

			mySelf:dispatch(Event:new(EVT_PLANEWAR_GAMEOVER, params))

			mySelf._isPlayWinAnim = false

			mySelf._backBtn:setTouchEnabled(true)
		end)
	end

	function data:addItem()
		if mySelf:isGameOver() then
			return
		end

		mySelf:refreshScorePanel()
		mySelf:refreshRewardPanel()
	end

	function data:addScore()
		if mySelf:isGameOver() then
			return
		end

		mySelf:refreshScorePanel()
	end

	self._planeWarController = PlaneWarController:new(self._mainPanel, self._data)

	local mianNode = self._planeWarController:getMainNode()
	local winSize = cc.Director:getInstance():getWinSize()

	mianNode:setPosition(-(winSize.width - 1136) / 2, -(winSize.height - 640) / 2)

	self._fightData = self._planeWarController:getFightData()
	self._pointData = self._planeWarController:getPointData()
end

function PlaneWarGameMediator:runGame()
	self._isPlayWinAnim = false

	self._planeWarController:build()
	self._backBtn:setVisible(true)
	self._rewardNode:setVisible(true)
end

function PlaneWarGameMediator:getPlayer()
	if self._planeWarController and self._planeWarController:getPlayerFactory() then
		local playerFactory = self._planeWarController:getPlayerFactory()

		if playerFactory:getPlayer() then
			return playerFactory:getPlayer()
		end
	end
end

function PlaneWarGameMediator:pause()
	self._planeWarController:pause()
end

function PlaneWarGameMediator:resume()
	if not self._isPlayWinAnim and not self:isGameOver() then
		self._planeWarController:resume()
	end
end

function PlaneWarGameMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:pause()
		self:dispatch(Event:new(EVT_PLANEWAR_STAGE_PAUSE, {
			rewards = self._fightData:collectServerData()
		}))
	end
end
