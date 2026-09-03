-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ExtraRewardActivityMediator.lua

ExtraRewardActivityMediator = class("ExtraRewardActivityMediator", BaseActivityMediator, _M)

ExtraRewardActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.btn_go"] = {
		func = "onClickGo"
	}
}

function ExtraRewardActivityMediator:initialize()
	super.initialize(self)
end

function ExtraRewardActivityMediator:dispose()
	super.dispose(self)
end

function ExtraRewardActivityMediator:onRemove()
	super.onRemove(self)
end

function ExtraRewardActivityMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")

	self._listView:setScrollBarEnabled(false)
end

function ExtraRewardActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ExtraRewardActivityMediator:setupView()
	local actConfig = self._activity:getActivityConfig()
	local timeNode = self._main:getChildByName("time_node")
	local timeWidget = self:bindWidget(timeNode, ActivityTimeWidget)
	local data = {
		icon = "ico_Activity_gift.png",
		startTime = self._activity:getStartTime(),
		endTime = self._activity:getEndTime(),
		title = Strings:get("ActivityCommon_UI03"),
		color = cc.c3b(244, 172, 141)
	}

	timeWidget:setTime(data)

	local countdownNode = self._main:getChildByName("countdown_node")
	local countdownWidget = self:bindWidget(countdownNode, ActivityCountdownWidget)
	local data = {
		notOutLine = true,
		icon = "ico_Activity_time.png",
		activityId = self._activity:getId(),
		title = Strings:get("ActivityCommon_UI04"),
		color = cc.c3b(244, 172, 141)
	}

	countdownWidget:setTime(data)

	local desc = self._activity:getDesc()
	local descText = ccui.Text:create(Strings:get(desc), TTF_FONT_FZYH_M, 22)

	descText:setColor(cc.c3b(64, 3, 2))
	self._listView:pushBackCustomItem(descText)
end

function ExtraRewardActivityMediator:onClickGo(sender, eventType)
	local actConfig = self._activity:getActivityConfig()
	local url = actConfig.link
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end
