-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarRuleTipMediator.lua

PlaneWarRuleTipMediator = class("PlaneWarRuleTipMediator", DmPopupViewMediator, _M)

PlaneWarRuleTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarRuleTipMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

local kBtnHandlers = {}

function PlaneWarRuleTipMediator:initialize()
	super.initialize(self)
end

function PlaneWarRuleTipMediator:dispose()
	super.dispose(self)
end

function PlaneWarRuleTipMediator:userInject()
	return
end

function PlaneWarRuleTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlers(kBtnHandlers)
end

function PlaneWarRuleTipMediator:enterWithData(data)
	self._planeWarSystem = self._miniGameSystem:getPlaneWarSystem()

	local mainPanel = self:getView():getChildByFullName("main")
	local bgNode = mainPanel:getChildByFullName("bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("43e68c11_e279_11e8_96ca_7c04d0d9796c")
	})

	local listView = mainPanel:getChildByFullName("listview")

	listView:setScrollBarEnabled(false)
	listView:removeAllItems()

	local showPanel = mainPanel:getChildByFullName("showpanel")

	showPanel:removeFromParent(false)
	listView:pushBackCustomItem(showPanel)

	data = data or {}

	for i = 1, #data do
		local id = data[i]
		local descLabel = showPanel:getChildByFullName("desclabel" .. i)

		descLabel:setString(Strings:get(id))
	end

	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.activityClose)
end

function PlaneWarRuleTipMediator:activityClose(event)
	local data = event:getData()
	local planeWarActivity = self._planeWarSystem:getPlaneWarActivity()

	if data.activityId == planeWarActivity:getId() then
		self:close()
	end
end

function PlaneWarRuleTipMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
