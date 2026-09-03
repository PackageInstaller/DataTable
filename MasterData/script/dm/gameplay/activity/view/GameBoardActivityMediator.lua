-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/GameBoardActivityMediator.lua

GameBoardActivityMediator = class("GameBoardActivityMediator", BaseActivityMediator, _M)

GameBoardActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.btn_go"] = {
		func = "onClickGo"
	}
}

function GameBoardActivityMediator:initialize()
	super.initialize(self)
end

function GameBoardActivityMediator:dispose()
	super.dispose(self)
end

function GameBoardActivityMediator:onRemove()
	super.onRemove(self)
end

function GameBoardActivityMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlerClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function GameBoardActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function GameBoardActivityMediator:setupView()
	local actConfig = self._activity:getActivityConfig()
	local timeNode = self._main:getChildByName("time_node")
	local timeWidget = self:bindWidget(timeNode, ActivityTimeWidget)
	local data = {
		startTime = self._activity:getStartTime(),
		endTime = self._activity:getEndTime(),
		title = Strings:get("ActivityCommon_UI03")
	}

	timeWidget:setTime(data)

	local countdownNode = self._main:getChildByName("countdown_node")
	local countdownWidget = self:bindWidget(countdownNode, ActivityCountdownWidget)
	local data = {
		activityId = self._activity:getId(),
		title = Strings:get("ActivityCommon_UI04")
	}

	countdownWidget:setTime(data)

	local mainImg = self._main:getChildByName("mainImg")

	mainImg:loadTexture("asset/ui/activity/" .. actConfig.img)
end

function GameBoardActivityMediator:onClickGo(sender, eventType)
	local actConfig = self._activity:getActivityConfig()
	local url = actConfig.link
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end
