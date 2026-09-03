-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/common/MiniGameResultMediator.lua

MiniGameResultMediator = class("MiniGameResultMediator", DmPopupViewMediator, _M)

MiniGameResultMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MiniGameResultMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
MiniGameResultMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
MiniGameResultMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function MiniGameResultMediator:initialize()
	super.initialize(self)
end

function MiniGameResultMediator:dispose()
	super.dispose(self)
end

function MiniGameResultMediator:userInject()
	return
end

function MiniGameResultMediator:onRegister()
	super.onRegister(self)

	self._confirmBtn = self:bindWidget("main.challenge_btn", TwoLevelMainButton, {
		clickAudio = "Se_Click_Confirm",
		handler = bind1(self.onClickAgain, self)
	})
	self._cancelBtn = self:bindWidget("main.cancel_btn", TwoLevelViceButton, {
		clickAudio = "Se_Click_Cancle",
		handler = bind1(self.onClickClose, self)
	})
	self._mainPanel = self:getView():getChildByFullName("main")
	self._rewardPanel = self._mainPanel:getChildByFullName("Panel_reward")
end

function MiniGameResultMediator:bindWidgets()
	return
end

function MiniGameResultMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function MiniGameResultMediator:enterWithData(data)
	self._data = data
	self._activityId = self._data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._bagSystem = self._developSystem:getBagSystem()

	self:createAnim(data)
	self:refreshView(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesScuessActivity)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dayRsetPush)
end

function MiniGameResultMediator:createAnim(data)
	local animNode = self._mainPanel:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

	anim:addTo(animNode)
	anim:addEndCallback(function()
		anim:stop()
	end)

	local winNode = anim:getChildByFullName("winNode")
	local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:addTo(winNode)

	local winPanel = winAnim:getChildByFullName("winTitle")
	local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

	title:addTo(winPanel)

	local heroNode = anim:getChildByFullName("roleNode")
	local heroIcon = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = self._data.modelId
	})

	heroIcon:setScale(1.1)
	heroIcon:setPosition(cc.p(-320, -300))
	heroNode:addChild(heroIcon)

	local curScore = self._mainPanel:getChildByFullName("Text_curScore")

	curScore:setString(Strings:get("MiniGame_Common_UI5", {
		score = self._data.score
	}))

	local highestScore = self._mainPanel:getChildByFullName("Text_highestScore")

	highestScore:setString(Strings:get("MiniGame_Common_UI6", {
		score = self._data.highscore
	}))

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(222, 172, 108, 255)
		}
	}

	highestScore:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local newRecordText = self._mainPanel:getChildByFullName("Text_new")
	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 241, 91, 255)
		}
	}

	newRecordText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	newRecordText:setVisible(self._data.isHightScore)

	local timesText = self._mainPanel:getChildByFullName("Text_times")

	timesText:setString(Strings:get("Activity_Darts_Residualtimes") .. self._data.todaytimes)
	self:runAction(curScore, -50)
	self:runAction(highestScore, -50)
	self:runAction(timesText, 30)

	local listView = self._rewardPanel:getChildByFullName("mRewardList")

	for k, v in pairs(self._data.rewards) do
		if v.amount > 0 then
			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(80, 80))

			local icon = IconFactory:createRewardIcon(v, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
				needDelay = true
			})
			icon:setScale(0.57)
			icon:addTo(layout):center(layout:getContentSize()):offset(-5, -5):setName("rewardIcon")
			listView:pushBackCustomItem(layout)
		end
	end

	local items = listView:getItems()

	for i = 1, #items do
		local _item = items[i]:getChildByName("rewardIcon")

		if _item then
			self:runAction(_item, 30)
		end
	end

	self:runAction2(self._confirmBtn:getView())
	self:runAction2(self._cancelBtn:getView())

	local mvpNode = anim:getChildByName("mvpNode")

	anim:addCallbackAtFrame(9, function()
		mvpNode:setVisible(false)
	end)
	anim:addCallbackAtFrame(17, function()
		mvpNode:setVisible(false)
	end)
end

function MiniGameResultMediator:runAction(node, xOffset)
	local posX, posY = node:getPosition()

	node:setPositionX(posX + xOffset)
	node:setOpacity(0)
	node:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY))))
end

function MiniGameResultMediator:runAction2(node)
	node:setOpacity(0)
	node:runAction(cc.FadeIn:create(0.3))
end

function MiniGameResultMediator:refreshView(data)
	self:refreshTimesPanel(data)
end

function MiniGameResultMediator:refreshTimesPanel(data)
	self._data.todaytimes = self._activity:getGameTimes()

	local timesText = self._mainPanel:getChildByFullName("Text_times")

	timesText:setString(Strings:get("Activity_Darts_Residualtimes") .. self._activity:getGameTimes())
end

function MiniGameResultMediator:dayRsetPush(event)
	self:refreshTimesPanel()
end

function MiniGameResultMediator:buyTimesScuessActivity(event)
	self:refreshTimesPanel()

	self.closeType = 2

	self:dispatch(Event:new(self._data.event))
	self:close({
		ignoreRefresh = true
	})
end

function MiniGameResultMediator:activityClose(event)
	self:close()
end

function MiniGameResultMediator:buyTimes()
	if not self._data.amountlist[self._data.buytimes + 1] then
		local cost = self._data.amountlist[#self._data.amountlist]
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				if not outSelf._bagSystem:checkCostEnough(outSelf._data.costid, cost, {
					type = "tip"
				}) then
					return
				end

				outSelf._miniGameSystem:requestActivityGameBuyTimes(outSelf._activityId)
			end
		end

		local data = {
			isRich = true,
			title = Strings:get("MiniGame_BuyTimes_UI1"),
			title1 = Strings:get("MiniGame_BuyTimes_UI2"),
			content = Strings:get("Activity_Darts_UI_16", {
				fontName = TTF_FONT_FZYH_R,
				num = cost,
				count = outSelf._data.eachbuynum
			}),
			sureBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end

function MiniGameResultMediator:onClickAgain(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local times = self._data.todaytimes
		local buytimes = self._data.buytimes
		local maxtimes = self._data.buymaxtimes
		local factor1 = times == 0
		local factor2 = buytimes == maxtimes

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Times_Out")
			}))

			return
		end

		if factor1 and not factor2 then
			local isRewardLimit = self._data.isGetRewardLimit

			if isRewardLimit then
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					if data.response == "ok" then
						outSelf:buyTimes()
					end
				end

				local data = {
					title = Strings:get("Pass_UI50"),
					title1 = Strings:get("Pass_UI51"),
					content = Strings:get("MiniGame_Common_UI7"),
					sureBtn = {},
					cancelBtn = {}
				}
				local view = self:getInjector():getInstance("AlertView")

				self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))

				return
			end

			self:buyTimes()

			return
		end

		self.closeType = 2

		self:dispatch(Event:new(self._data.event))
		self:close({
			ignoreRefresh = true
		})
	end
end

function MiniGameResultMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dispatch(Event:new(self._data.eventback, {}))
		self:close()
	end
end
