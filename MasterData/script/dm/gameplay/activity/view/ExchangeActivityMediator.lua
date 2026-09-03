-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ExchangeActivityMediator.lua

ExchangeActivityMediator = class("ExchangeActivityMediator", BaseActivityMediator, _M)

ExchangeActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ExchangeActivityMediator:initialize()
	super.initialize(self)
end

function ExchangeActivityMediator:dispose()
	super.dispose(self)
end

function ExchangeActivityMediator:onRemove()
	super.onRemove(self)
end

function ExchangeActivityMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")
	self._descPanel = self._main:getChildByName("panel_desc")

	self._listView:setScrollBarEnabled(false)
end

function ExchangeActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ExchangeActivityMediator:setupView()
	self:setupDescPanel()
	self:setupTaskList()
end

function ExchangeActivityMediator:mapEventListeners()
	return
end

function ExchangeActivityMediator:setupDescPanel()
	local activityConfig = self._activity:getActivityConfig()
	local timeNode = self._descPanel:getChildByName("actTime")
	local timeWidget = self:bindWidget(timeNode, ActivityTimeWidget)
	local data = {
		startTime = self._activity:getStartTime(),
		endTime = self._activity:getEndTime(),
		title = Strings:get("ActivityCommon_UI03")
	}

	timeWidget:setTime(data)

	local countdownNode = self._descPanel:getChildByName("remainTime")
	local countdownWidget = self:bindWidget(countdownNode, ActivityRemainTimeWidget)
	local data = {
		activityId = self._activity:getId()
	}

	countdownWidget:updateTime(data)

	if activityConfig.showHero then
		local heroPanel = self._descPanel:getChildByName("portrait")
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", activityConfig.showHero)
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:setScale(0.7)
		heroSprite:addTo(heroPanel)
		heroSprite:setPosition(cc.p(150, 220))

		if activityConfig.showHero == "LLan" then
			heroSprite:setPosition(cc.p(160, 220))
		end
	end

	local desc = self._descPanel:getChildByName("desc")

	desc:setString(Strings:get(self._activity:getDesc()))
	desc:enableOutline(cc.c4b(3, 1, 4, 255), 1)

	local title = self._descPanel:getChildByName("title")

	title:setString(Strings:get(self._activity:getTitle()))
end

function ExchangeActivityMediator:setupTaskList()
	local exchangeList = self._activity:getSortExchangeList()

	self._cellWidgetArr = {}

	for i, value in pairs(exchangeList) do
		local widget = ccui.Widget:create()
		local node = ActivityExchangeCellWidget:createWidgetNode()
		local cellWidget = ActivityExchangeCellWidget:new(node)

		self:getInjector():injectInto(cellWidget)
		cellWidget:setupView(value, {
			mediator = self,
			parentMediator = self._parentMediator,
			activityId = self._activity:getId()
		})
		cellWidget:getView():addTo(widget):offset(0, -15)
		widget:setContentSize(cc.size(681, 96))
		self._listView:pushBackCustomItem(widget)

		self._cellWidgetArr[#self._cellWidgetArr + 1] = cellWidget
	end
end

function ExchangeActivityMediator:refreshView(data)
	local exchangeList = self._activity:getSortExchangeList()
	local exchangeData = self._activity:getExchangeDataById(data.exchangeId)

	if exchangeData and exchangeData.amount > 0 then
		for i, widget in pairs(self._cellWidgetArr) do
			widget:updateView(exchangeList[i], {
				mediator = self,
				activityId = self._activity:getId()
			})
		end
	else
		self._listView:removeAllChildren(true)
		self:setupTaskList()
	end
end
