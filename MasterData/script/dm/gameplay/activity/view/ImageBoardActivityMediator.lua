-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ImageBoardActivityMediator.lua

ImageBoardActivityMediator = class("ImageBoardActivityMediator", BaseActivityMediator, _M)

ImageBoardActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.btn_go.button"] = {
		func = "onClickGo"
	}
}

function ImageBoardActivityMediator:initialize()
	super.initialize(self)
end

function ImageBoardActivityMediator:dispose()
	super.dispose(self)
end

function ImageBoardActivityMediator:onRemove()
	super.onRemove(self)
end

function ImageBoardActivityMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function ImageBoardActivityMediator:enterWithData(data)
	self._activity = data.activity

	self:bindWidget("main.btn_go", OneLevelViceButton, {})
	self:setupView()
end

function ImageBoardActivityMediator:setupView()
	local actConfig = self._activity:getActivityConfig()
	local timeNode = self._main:getChildByName("time_node")
	local timeWidget = self:bindWidget(timeNode, ActivityTimeWidget)
	local data = {
		startTime = self._activity:getStartTime(),
		endTime = self._activity:getEndTime(),
		title = Strings:get("ActivityCommon_UI03")
	}

	timeWidget:setTime(data)

	local bgImg = self._main:getChildByName("mainImg")

	bgImg:ignoreContentAdaptWithSize(true)
	bgImg:loadTexture("asset/scene/" .. actConfig.img .. ".jpg")

	local title = self._main:getChildByName("title")

	title:setString(Strings:get(self._activity:getTitle()))

	local text1 = self._main:getChildByName("test1")
	local text2 = self._main:getChildByName("test2")
	local descConfig = actConfig.desc

	dump(descConfig)
	text1:setString(Strings:get(descConfig[1]))
	text2:setString(Strings:get(descConfig[2]))
	text1:enableOutline(cc.c4b(4, 14, 28, 147.89999999999998), 1)
	text2:enableOutline(cc.c4b(4, 14, 28, 147.89999999999998), 1)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(206, 222, 255, 255)
		}
	}

	text1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function ImageBoardActivityMediator:onClickGo(sender, eventType)
	local actConfig = self._activity:getActivityConfig()
	local url = actConfig.link
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end
