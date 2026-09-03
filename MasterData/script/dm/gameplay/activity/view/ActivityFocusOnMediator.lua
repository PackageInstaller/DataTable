-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityFocusOnMediator.lua

ActivityFocusOnMediator = class("ActivityFocusOnMediator", BaseActivityMediator, _M)

ActivityFocusOnMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ActivityFocusOnMediator:initialize()
	super.initialize(self)
end

function ActivityFocusOnMediator:dispose()
	super.dispose(self)
end

function ActivityFocusOnMediator:onRemove()
	super.onRemove(self)
end

function ActivityFocusOnMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ENTER_FOREGROUND, self, self.appWillEnterForeground)

	self._taskBtn = bindWidget(self, "main.GoToBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onGoToBtnClicked, self)
		}
	})

	bindWidget(self, "main.RewardBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onRewardClicked, self)
		}
	})
end

function ActivityFocusOnMediator:enterWithData(data)
	self._activity = data.activity
	self._activityConfig = self._activity:getConfig()
	self._activityUIType = data.activity:getConfig().UI
	self._parentMediator = data.parentMediator

	self:initWidget()
	self:setupView()
end

function ActivityFocusOnMediator:initWidget()
	self._bg = self:getView():getChildByFullName("main.FocuseBg")
	self._ksView = self:getView():getChildByFullName("main.InfoKSPanel")
	self._acView = self:getView():getChildByFullName("main.InfoACPanel")
	self._gotoBtn = self:getView():getChildByFullName("main.GoToBtn")
	self._rewardBtn = self:getView():getChildByFullName("main.RewardBtn")
	self._finish = self:getView():getChildByFullName("main.finish")

	self._taskBtn:setButtonName(Strings:get(self._activity:getActivityBtnText()), "")

	local anim = cc.MovieClip:create("shiciguang_choukarenwu")

	anim:addTo(self._gotoBtn)
	anim:setPosition(cc.p(0, -32))

	local anim = cc.MovieClip:create("shiciguang_choukarenwu")

	anim:addTo(self._rewardBtn)
	anim:setPosition(cc.p(0, -32))
	self:refreshView()
end

function ActivityFocusOnMediator:setupView()
	local str = self._activity:getActivityBgImg()

	self._bg:loadTexture("asset/scene/" .. self._activity:getActivityBgImg())
	self._ksView:setVisible(ActivityType.KKuaiShouApp == self._activityUIType)
	self._acView:setVisible(ActivityType.KAZhanApp == self._activityUIType)

	if ActivityType.KKuaiShouApp == self._activityUIType then
		self._infoView = self._ksView or self._acView
	end

	self._infoView:getChildByFullName("Info_1.Text"):setString(Strings:get(self._activity:getActivityDesc1()))
	self._infoView:getChildByFullName("Info_2.Text"):setString(Strings:get(self._activity:getActivityDesc2()))

	local rewrdList = self._infoView:getChildByFullName("ListView")

	rewrdList:setScrollBarEnabled(false)
	rewrdList:removeAllItems()

	local rewardId = self._activity:getActivityReward()
	local rewardData = ConfigReader:getRecordById("Reward", rewardId).Content

	for i = 1, #rewardData do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(65, 65))

		local icon = IconFactory:createRewardIcon(rewardData[i], {
			showAmount = true,
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData[i], {
			needDelay = true
		})
		icon:setScaleNotCascade(0.5)
		icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
		rewrdList:pushBackCustomItem(layout)
	end
end

function ActivityFocusOnMediator:refreshView()
	self._gotoBtn:setVisible(false)
	self._rewardBtn:setVisible(false)

	if not self._activity:getRewardStates() then
		self._finish:setVisible(false)

		local param = {
			doActivityType = 101
		}

		self._activitySystem:requestDoActivity(self._activity:getId(), param, function(response)
			if response.data.finish then
				self._gotoBtn:setVisible(false)
				self._rewardBtn:setVisible(true)
			else
				self._gotoBtn:setVisible(true)
				self._rewardBtn:setVisible(false)
			end
		end)
	else
		self._finish:setVisible(true)
	end
end

local ACFunAndroidPackName = "tv.acfundanmaku.video"

function ActivityFocusOnMediator:onGoToBtnClicked()
	if SDKHelper and SDKHelper:isEnableSdk() then
		local url = self._activity:getActivityURL()
		local isInstall = PlatformHelper and PlatformHelper:isInstallApp(ACFunAndroidPackName) and 1 or 0
		local openId = SDKHelper:getOpenId()
		local urlParms = "openid=" .. tostring(openId) .. "&taskid=" .. tostring(self._activity:getId()) .. "&isready=" .. tostring(isInstall)

		print("KS URL:" .. url .. "?" .. urlParms)
		cc.Application:getInstance():openURL(url .. "?" .. urlParms)
	end
end

function ActivityFocusOnMediator:onRewardClicked()
	local param = {
		doActivityType = 102
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), param, function(response)
		self._gotoBtn:setVisible(false)
		self._rewardBtn:setVisible(false)
		self._finish:setVisible(true)

		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				needClick = true,
				rewards = rewards
			}))
		end
	end)
end

function ActivityFocusOnMediator:appWillEnterForeground()
	self:refreshView()
end
