-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/BannerActivityMediator.lua

BannerActivityMediator = class("BannerActivityMediator", BaseActivityMediator, _M)

BannerActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function BannerActivityMediator:initialize()
	super.initialize(self)
end

function BannerActivityMediator:dispose()
	super.dispose(self)
end

function BannerActivityMediator:onRemove()
	super.onRemove(self)
end

function BannerActivityMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")

	self._listView:setScrollBarEnabled(false)
end

function BannerActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function BannerActivityMediator:setupView()
	self._bannerList = self._activity:getBannerList()

	self:setupBannerList()
end

function BannerActivityMediator:setupBannerList()
	for i, value in pairs(self._bannerList) do
		local widget = ccui.Widget:create()
		local node = ActivityBannerCellWidget:createWidgetNode()
		local cellWidget = ActivityBannerCellWidget:new(node)

		self:getInjector():injectInto(cellWidget)
		cellWidget:setupView(value, {
			mediator = self,
			activityId = self._activity:getId()
		})
		cellWidget:getView():addTo(widget)
		widget:setContentSize(cellWidget:getView():getContentSize())
		self._listView:pushBackCustomItem(widget)
	end
end
