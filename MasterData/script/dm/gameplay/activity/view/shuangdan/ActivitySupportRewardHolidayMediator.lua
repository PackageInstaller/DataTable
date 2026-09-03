-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivitySupportRewardHolidayMediator.lua

ActivitySupportRewardHolidayMediator = class("ActivitySupportRewardHolidayMediator", DmPopupViewMediator, _M)

ActivitySupportRewardHolidayMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.btn_back"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	}
}

function ActivitySupportRewardHolidayMediator:initialize()
	super.initialize(self)
end

function ActivitySupportRewardHolidayMediator:dispose()
	super.dispose(self)
end

function ActivitySupportRewardHolidayMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function ActivitySupportRewardHolidayMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function ActivitySupportRewardHolidayMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	self:mapEventListeners()
	self:setupView()
end

function ActivitySupportRewardHolidayMediator:resumeWithData(data)
	super.resumeWithData(self, data)
end

function ActivitySupportRewardHolidayMediator:mapEventListeners()
	return
end

function ActivitySupportRewardHolidayMediator:setupView()
	local actConfig = self._activity:getActivityConfig()
	local showReward = actConfig.ShowWin
	local redNode = self._main:getChildByName("Node_red")
	local whiteNode = self._main:getChildByName("Node_white")

	self:setRewardPanel(redNode:getChildByName("reward"), showReward[1])
	self:setRewardPanel(whiteNode:getChildByName("reward"), showReward[2])
end

function ActivitySupportRewardHolidayMediator:setRewardPanel(panel, rewardId)
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	if rewards then
		for i = 1, 2 do
			for j = 1, 2 do
				local reward = rewards[j + (i - 1) * 2]

				if reward then
					local icon = IconFactory:createRewardIcon(reward, {
						isWidget = true
					})

					icon:addTo(panel):posite(55 + (j - 1) * 140, 195 - (i - 1) * 140)
					IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
						needDelay = true
					})
				end
			end
		end
	end
end

function ActivitySupportRewardHolidayMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
