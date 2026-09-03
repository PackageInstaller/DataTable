-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarRewardListTipMediator.lua

PlaneWarRewardListTipMediator = class("PlaneWarRewardListTipMediator", DmPopupViewMediator, _M)

PlaneWarRewardListTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarRewardListTipMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
PlaneWarRewardListTipMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")

local kBtnHandlers = {}

function PlaneWarRewardListTipMediator:initialize()
	super.initialize(self)
end

function PlaneWarRewardListTipMediator:dispose()
	super.dispose(self)
end

function PlaneWarRewardListTipMediator:userInject()
	return
end

function PlaneWarRewardListTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlers(kBtnHandlers)
end

function PlaneWarRewardListTipMediator:enterWithData(data)
	self._planeWarSystem = self._miniGameSystem:getPlaneWarSystem()

	local mainPanel = self:getView():getChildByFullName("main")
	local bgNode = mainPanel:getChildByFullName("bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("43ef8a2e_e279_11e8_8383_7c04d0d9796c")
	})

	local mainPanel = self:getView():getChildByFullName("main")

	self._curScoreText = mainPanel:getChildByFullName("cur_score_text")
	self._curScore = 0
	self._scoreLabel = mainPanel:getChildByFullName("score_text_0")

	local listView = mainPanel:getChildByFullName("listview")

	listView:offset(4, 0)
	self:refreshListView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_GETREWARD_SCUESS, self, self.refreshByGetReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.activityClose)
end

function PlaneWarRewardListTipMediator:activityClose(event)
	local data = event:getData()
	local planeWarActivity = self._planeWarSystem:getPlaneWarActivity()

	if data.activityId == planeWarActivity:getId() then
		self:close()
	end
end

local sortTask = {
	[ActivityTaskStatus.kFinishNotGet] = 3,
	[ActivityTaskStatus.kUnfinish] = 2,
	[ActivityTaskStatus.kGet] = 1
}

function PlaneWarRewardListTipMediator:refreshListView()
	local mainPanel = self:getView():getChildByFullName("main")
	local listView = mainPanel:getChildByFullName("listview")

	listView:setScrollBarEnabled(false)
	listView:removeAllItems()

	local planeWarActivity = self._planeWarSystem:getPlaneWarActivity()
	local list = planeWarActivity:getTaskList()
	local cache = {}

	for i = 1, #list do
		cache[#cache + 1] = list[i]
	end

	table.sort(cache, function(a, b)
		local status_A = a:getStatus()
		local status_B = b:getStatus()

		if sortTask[status_A] ~= sortTask[status_B] then
			return sortTask[status_A] > sortTask[status_B]
		end

		return a:getOrderNum() > b:getOrderNum()
	end)

	for i = 1, #cache do
		local data = cache[i]
		local newPanel = self:createRewardPanel(data)

		newPanel:removeFromParent(false)
		listView:pushBackCustomItem(newPanel)
	end

	if cache ~= nil and #cache > 0 then
		local curScore = self._planeWarSystem:getPlaneWarActivity():getTotalScore()

		if curScore then
			self._curScore = curScore
		end
	end

	self._curScoreText:setString(tostring(self._curScore))
	self._scoreLabel:setPositionX(self._curScoreText:getPositionX() - self._curScoreText:getContentSize().width - 1)
end

function PlaneWarRewardListTipMediator:refreshByGetReward(event)
	self:refreshListView()

	local response = event:getData().response
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		rewards = response
	}))
end

function PlaneWarRewardListTipMediator:createRewardPanel(data)
	local rewardList = data:getReward().Content
	local newPanel = cc.CSLoader:createNode("asset/ui/miniplaneActivityRewardCell.csb")
	local panel = newPanel:getChildByFullName("cellpanel")

	for i = 1, #rewardList do
		local reward = rewardList[i]
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHander:new(self), reward, {
			needDelay = true
		})
		icon:setScale(0.55)
		icon:setPosition(75 + (i - 1) * 68, 46)
		panel:addChild(icon)
	end

	local status = data:getStatus()
	local hasGetImg = panel:getChildByFullName("hasgetimg")

	hasGetImg:setVisible(status == TaskStatus.kGet)

	local okBtn = panel:getChildByFullName("okbtn")
	local btnWidget = self:bindWidget(okBtn, TwoLevelMainButton, {
		handler = bind2(self.onClickOk, self, data:getId())
	})

	okBtn:setVisible(status == TaskStatus.kFinishNotGet)

	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionkeeper:getConditionDesc(data:getCondition()[1])
	local descLabel = ccui.RichText:createWithXML(str, {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0, 0.5))
	descLabel:renderContent()
	descLabel:addTo(panel):posite(40, 103)

	return panel
end

function PlaneWarRewardListTipMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function PlaneWarRewardListTipMediator:onClickOk(taskId, sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")
		self._miniGameSystem:requestActivityGameGetReward(PlaneWarConfig.activityId, taskId)
	end
end
