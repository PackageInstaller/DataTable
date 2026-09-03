-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityEggRewardMediator.lua

ActivityEggRewardMediator = class("ActivityEggRewardMediator", DmPopupViewMediator, _M)

ActivityEggRewardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function ActivityEggRewardMediator:initialize()
	super.initialize(self)
end

function ActivityEggRewardMediator:dispose()
	super.dispose(self)
end

function ActivityEggRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._rewardPanel = self:getView():getChildByName("panel")
	self._tabPanel = self:getView():getChildByName("tabPanel")

	self._tabPanel:setScrollBarEnabled(false)

	self._text1 = self:getView():getChildByName("text1")
	self._text2 = self:getView():getChildByName("text2")
	self._btnClone = self:getView():getChildByName("btnClone")

	self._btnClone:setVisible(false)

	self._line = self:getView():getChildByName("line")

	self._line:setVisible(false)
	self:bindWidget("bgNode", PopupNewWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("ActivityBlock_UI_1"),
		title1 = Strings:get("UITitle_EN_Jiangli")
	})
end

function ActivityEggRewardMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlock

	self:initData()
	self:initTabView()

	self._text1PosY = self._text1:getPositionY()

	self:initView()
end

function ActivityEggRewardMediator:initData()
	self._activityModel = self._activitySystem:getActivityById(self._activityId)

	if self._activityModel:getType() == ActivityType.KActivityBlock then
		self._eggActivity = self._activityModel:getEggActivity()
		self._isSubAct = true
	else
		self._eggActivity = self._activityModel
		self._isSubAct = false
	end

	self._round = self._eggActivity:getNum()
	self._rewards = self._eggActivity:getPreviewRewards()
	self._tabNum = #self._rewards
	self._tabIndex = math.min(self._round, self._tabNum)
	self._showRewards = self._rewards[self._tabIndex]
end

function ActivityEggRewardMediator:initTabView()
	self._tabBtns = {}

	for i = 1, self._tabNum do
		local btn = self._btnClone:clone()

		btn:setVisible(true)

		local dark = btn:getChildByName("dark")
		local light = btn:getChildByName("light")

		dark:setVisible(self._tabIndex ~= i)
		dark:getChildByName("image"):setVisible(self._tabNum ~= i)
		light:setVisible(self._tabIndex == i)

		if self._tabNum == i then
			local var_6_0 = Strings:get("ActivityBlock_UI_14")

			if not var_6_0 then
				var_6_0 = Strings:get("ActivityBlock_UI_4", {
					num = i
				})

				local name = var_6_0

				dark:getChildByName("text"):setString(name)
				light:getChildByName("text"):setString(name)

				if getCurrentLanguage() ~= GameLanguageType.CN then
					dark:getChildByName("text"):setFontSize(14)
					light:getChildByName("text"):setFontSize(14)
				end

				local function callFunc()
					self:onClickTab(i)
				end

				mapButtonHandlerClick(nil, btn, {
					clickAudio = "Se_Click_Select_1",
					func = callFunc
				})
				self._tabPanel:pushBackCustomItem(btn)

				self._tabBtns[i] = btn
			end
		end
	end

	local percent = (self._tabIndex - 1) * (self._btnClone:getContentSize().width + 3) / (self._btnClone:getContentSize().width * self._tabNum) * 100

	self._tabPanel:jumpToPercentHorizontal(percent)
end

function ActivityEggRewardMediator:refreshTabBtn()
	for i, btn in ipairs(self._tabBtns) do
		local dark = btn:getChildByName("dark")
		local light = btn:getChildByName("light")

		dark:setVisible(self._tabIndex ~= i)
		light:setVisible(self._tabIndex == i)
	end
end

function ActivityEggRewardMediator:initView()
	self._rewardPanel:removeAllChildren()

	local posX = 50
	local posY = 325
	local add = 88

	if self._showRewards.bigRewards then
		self._line:setVisible(true)
		self._text1:setString(Strings:get("ActivityBlock_UI_11"))
		self._text1:setPositionY(self._text1PosY)
		self._text2:setVisible(true)

		for i = 1, #self._showRewards.bigRewards do
			self:createReward(self._showRewards.bigRewards[i], {
				x = 136 + (add + 2) * (i - 1),
				y = posY
			}, 0.7)
		end

		for i = 1, math.ceil(#self._showRewards.normalRewards / 5) do
			for jj = 1, 5 do
				local index = 5 * (i - 1) + jj
				local reward = self._showRewards.normalRewards[index]

				if reward then
					self:createReward(reward, {
						x = posX + add * (jj - 1),
						y = posY - 126 - (add - 10) * (i - 1)
					}, 0.6)
				end
			end
		end
	else
		self._line:setVisible(false)
		self._text1:setString(Strings:get("ActivityBlock_UI_12"))
		self._text1:setPositionY(self._text1PosY - 7)
		self._text2:setVisible(false)

		for i = 1, math.ceil(#self._showRewards / 5) do
			for jj = 1, 5 do
				local index = 5 * (i - 1) + jj
				local reward = self._showRewards[index]

				if reward then
					self:createReward(reward, {
						x = posX + add * (jj - 1),
						y = posY - 10 - (add - 10) * (i - 1)
					}, 0.6)
				end
			end
		end
	end
end

function ActivityEggRewardMediator:createReward(reward, pos, scale)
	local icon = IconFactory:createRewardIcon(reward, {
		isWidget = true
	})

	icon:addTo(self._rewardPanel):posite(pos.x, pos.y):setScale(scale)
	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
		needDelay = true
	})
end

function ActivityEggRewardMediator:onClickClose()
	self:close()
end

function ActivityEggRewardMediator:onClickTab(index)
	self._tabIndex = index
	self._showRewards = self._rewards[self._tabIndex]

	self:refreshTabBtn()
	self:initView()
end
