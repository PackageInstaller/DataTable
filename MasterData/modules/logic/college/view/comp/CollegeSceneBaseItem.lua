-- chunkname: @modules/logic/college/view/comp/CollegeSceneBaseItem.lua

module("modules.logic.college.view.comp.CollegeSceneBaseItem", package.seeall)

local CollegeSceneBaseItem = class("CollegeSceneBaseItem", LuaCompBase)

function CollegeSceneBaseItem:init(go)
	self.go = go
end

function CollegeSceneBaseItem:addEventListeners()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnMapSceneSizeChange, self._onSceneSizeChange, self)
	CollegeController.instance:registerCallback(CollegeEvent.MainViewVisibleChange, self._onSceneSizeChange, self)

	if self.data then
		self:updateData(self.data)
	end
end

function CollegeSceneBaseItem:removeEventListeners()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnMapSceneSizeChange, self._onSceneSizeChange, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.MainViewVisibleChange, self._onSceneSizeChange, self)
end

function CollegeSceneBaseItem:updateData(data)
	self.data = data
end

function CollegeSceneBaseItem:setUI(ui, arrowRoot)
	self.ui = ui
	self.root = gohelper.findChild(self.ui, "root")
	self.arrow = gohelper.findChild(self.ui, "arrow")
	self.btnArrow = gohelper.findChildButtonWithAudio(self.ui, "arrow/#btn_click")

	self:onInitView()

	if self.arrow and arrowRoot then
		gohelper.setParent(self.arrow, arrowRoot)
	end

	self:initFollow()

	if self.btnArrow then
		self.addClickCb(self, self.btnArrow, self._onArrowClick, self)
	end
end

function CollegeSceneBaseItem:onInitView()
	return
end

function CollegeSceneBaseItem:initFollow()
	if not self._uiFollower and self.arrow then
		self._uiFollower = gohelper.onceAddComponent(self.arrow, typeof(ZProj.UIFollowerInRange))

		self._uiFollower:SetRotateArrow(self.btnArrow.gameObject)
		self:_onScreenResize()
		self._uiFollower:SetEnable(true)

		local mainCamera = CameraMgr.instance:getMainCamera()
		local uiCamera = CameraMgr.instance:getUICamera()
		local plane = ViewMgr.instance:getUIRoot().transform

		self._uiFollower:Set(mainCamera, uiCamera, plane, self.go.transform, 0, 0, 0, 0, 0)
	end

	if not self._uiFollower2 and self.root then
		self._uiFollower2 = gohelper.onceAddComponent(self.root, typeof(ZProj.UIFollower))

		self._uiFollower2:SetEnable(true)

		local mainCamera = CameraMgr.instance:getMainCamera()
		local uiCamera = CameraMgr.instance:getUICamera()
		local plane = ViewMgr.instance:getUIRoot().transform

		self._uiFollower2:Set(mainCamera, uiCamera, plane, self.go.transform, 0, 0, 0, 0, 0)
	end
end

function CollegeSceneBaseItem:_onArrowClick()
	CollegeController.instance:dispatchEvent(CollegeEvent.TweenCameraPos, -self.data.pos)
end

function CollegeSceneBaseItem:_onScreenResize()
	if not self._uiFollower then
		return
	end

	local root = ViewMgr.instance:getUIRoot().transform
	local screenRightX = recthelper.getWidth(root)
	local screenTopY = recthelper.getHeight(root)

	screenTopY = screenRightX / screenTopY < 1.7777777777777777 and 1080 or screenTopY

	local halfScreenWidth = screenRightX / 2
	local halfScreenHeight = screenTopY / 2

	self._uiFollower:SetRange(-halfScreenWidth, halfScreenWidth, -halfScreenHeight, halfScreenHeight)
end

function CollegeSceneBaseItem:_onSceneSizeChange()
	if self._uiFollower then
		self._uiFollower:ForceUpdate()
	end

	if self._uiFollower2 then
		self._uiFollower2:ForceUpdate()
	end
end

function CollegeSceneBaseItem:destroy()
	if self.ui then
		gohelper.destroy(self.ui)
	end

	gohelper.destroy(self.go)
	self:__onDispose()
end

return CollegeSceneBaseItem
