-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/QuestionActivityMediator.lua

QuestionActivityMediator = class("QuestionActivityMediator", BaseActivityMediator, _M)

QuestionActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.Button_go"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onQuestionClicked"
	},
	["main.Button_get"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onRewardClicked"
	}
}

function QuestionActivityMediator:initialize()
	super.initialize(self)
end

function QuestionActivityMediator:dispose()
	if self._timeScheduler then
		self._timeScheduler:stop()

		self._timeScheduler = nil
	end

	local activityData = self._activityData

	if activityData._rewardStatus == true then
		activityData._endTime = 0
	end

	super.dispose(self)
end

function QuestionActivityMediator:onRemove()
	super.onRemove(self)
end

function QuestionActivityMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function QuestionActivityMediator:enterWithData(data)
	self._activityData = data.activity
	self._parentMediator = data.parentMediator
	self._activityConfig = self._activityData._config.ActivityConfig

	self:setupView()
end

function QuestionActivityMediator:setupView()
	self:refreshView()
	self:updateTime()
	self:initAnim()
end

function QuestionActivityMediator:refreshView()
	local node_reward = self:getView():getChildByFullName("main.Node_reward")
	local button_go = self:getView():getChildByFullName("main.Button_go")
	local button_get = self:getView():getChildByFullName("main.Button_get")
	local node_complete = self:getView():getChildByFullName("main.Node_complete")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 218, 68, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 250, 227, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}
	local text1 = button_go:getChildByFullName("Text_1")
	local text2 = button_go:getChildByFullName("Text_2")

	text1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	text2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local text1 = button_get:getChildByFullName("Text_1")

	text1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local text1 = node_complete:getChildByFullName("Text_1")

	text1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local canGetRewSta = self._activityData._canGetRewSta
	local rewardStatus = self._activityData._rewardStatus

	if rewardStatus then
		button_go:setVisible(false)
		button_get:setVisible(false)
		node_complete:setVisible(true)
	else
		node_complete:setVisible(false)

		if canGetRewSta then
			button_go:setVisible(false)
			button_get:setVisible(true)
		else
			button_go:setVisible(true)
			button_get:setVisible(false)
		end
	end

	node_reward:removeAllChildren()

	local rewardId = self._activityConfig.reward

	if rewardId then
		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

		if rewards then
			local num = #rewards
			local kIconWigth = 105

			for k, v in pairs(rewards) do
				local rewardData = v
				local icon = IconFactory:createRewardIcon(rewardData, {
					isWidget = true
				})

				icon:addTo(node_reward, 1):center(node_reward:getContentSize())
				icon:setScaleNotCascade(0.7)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
					needDelay = true
				})

				local initX = node_reward:getContentSize().width / 2 - (num - 1) * 0.5 * kIconWigth

				icon:setPosition(cc.p(initX + (k - 1) * kIconWigth, 0))
			end
		end
	end
end

function QuestionActivityMediator:onQuestionClicked(data)
	local url

	if self._activityData then
		local dict = self._activityConfig.URL
		local language = getCurrentLanguage()

		url = dict[language] or dict.en
	end

	if url then
		local loginSystem = self:getInjector():getInstance(LoginSystem)
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local curServer = loginSystem:getCurServer()
		local player = developSystem:getPlayer()

		url = string.format("%sroleid=%s&serverid=%s&uid=%s", url, player:getRid(), curServer:getSecId(), loginSystem:getUid())

		local view = cc.CSLoader:createNode("asset/ui/NativeWebView.csb")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))

		self._activityData._canGetRewSta = true

		self:refreshView()

		local mediator = NativeWebViewMediator:new()

		mediator:setView(view)
		mediator:onRegister()
		mediator:enterWithData({
			url = url
		})
	end
end

function QuestionActivityMediator:onRewardClicked()
	local activityData = self._activityData
	local activityId = self._activityData._id
	local param = {
		doActivityType = 101
	}

	self._activitySystem:requestDoActivity(activityId, param, function(response)
		activityData._rewardStatus = true

		self:showRewardView(response.data)
		self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	end)
end

function QuestionActivityMediator:updateTime()
	local function update()
		local button_go = self:getView():getChildByFullName("main.Button_go")
		local button_get = self:getView():getChildByFullName("main.Button_get")
		local activityId = self._activityData._id
		local leaveTime = self:getActivitySystem():getActivityRemainTime(activityId)

		if self._activitySystem:isActivityOver(activityId) then
			button_go:setVisible(false)
			button_get:setVisible(false)

			return
		end

		if leaveTime <= 0 then
			button_go:setVisible(false)

			return
		end
	end

	if self._timeScheduler == nil then
		self._timeScheduler = LuaScheduler:getInstance():schedule(update, 1, true)
	end

	update()
end

function QuestionActivityMediator:initAnim()
	return
end
