-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/TaskActivityMediator.lua

TaskActivityMediator = class("TaskActivityMediator", BaseActivityMediator, _M)

TaskActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function TaskActivityMediator:initialize()
	super.initialize(self)
end

function TaskActivityMediator:dispose()
	super.dispose(self)
end

function TaskActivityMediator:onRemove()
	super.onRemove(self)
end

function TaskActivityMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")
	self._descPanel = self._main:getChildByName("panel_desc")

	self._listView:setScrollBarEnabled(false)
end

function TaskActivityMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function TaskActivityMediator:setupView()
	self:setupDescPanel()
	self:setupTaskList()
end

function TaskActivityMediator:mapEventListeners()
	return
end

function TaskActivityMediator:setupDescPanel()
	local activityConfig = self._activity:getActivityConfig()

	if activityConfig.showHero then
		local heroPanel = self._descPanel:getChildByName("portrait")
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", activityConfig.showHero)
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:setScale(0.8)
		heroSprite:addTo(heroPanel)
		heroSprite:setPosition(cc.p(210, 160))
	end

	local desc = self._descPanel:getChildByName("desc")

	desc:setString(Strings:get(self._activity:getDesc()))
	desc:enableOutline(cc.c4b(3, 1, 4, 255), 1)

	local title = self._descPanel:getChildByName("title")

	title:setString(Strings:get(self._activity:getTitle()))
end

function TaskActivityMediator:setupTaskList()
	local taskList = self._activity:getSortActivityList()

	for i, value in pairs(taskList) do
		local widget = ccui.Widget:create()
		local node = ActivityTaskCellWidget:createWidgetNode()
		local taskCellWidget = ActivityTaskCellWidget:new(node)

		self:getInjector():injectInto(taskCellWidget)
		taskCellWidget:setupView(value, {
			mediator = self,
			parentMediator = self._parentMediator,
			activityId = self._activity:getId()
		})
		taskCellWidget:getView():addTo(widget):offset(0, -1)
		widget:setContentSize(cc.size(800, 96))
		self._listView:pushBackCustomItem(widget)
	end
end

function TaskActivityMediator:refreshView()
	self._listView:removeAllChildren(true)
	self:setupTaskList()
end
