-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivitySupportPailianHolidayMediator.lua

ActivitySupportPailianHolidayMediator = class("ActivitySupportPailianHolidayMediator", DmPopupViewMediator, _M)

ActivitySupportPailianHolidayMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.btn_back"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	},
	["main.btn_go"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickGo"
	}
}

function ActivitySupportPailianHolidayMediator:initialize()
	super.initialize(self)
end

function ActivitySupportPailianHolidayMediator:dispose()
	super.dispose(self)
end

function ActivitySupportPailianHolidayMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivitySupportPailianHolidayMediator:enterWithData(data)
	self._activityId = data.activityId

	self:setupView()
end

function ActivitySupportPailianHolidayMediator:setupView()
	local anim = cc.MovieClip:create("main_mengjinggehuizhan")

	anim:addTo(self._main, -1):center(self._main:getContentSize())
end

function ActivitySupportPailianHolidayMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function ActivitySupportPailianHolidayMediator:onClickGo(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._activitySystem:enterSagaSupportStage(self._activityId)
		self:close()
	end
end
