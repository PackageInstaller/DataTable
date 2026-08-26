-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/VersionActivity1_6DungeonMapSceneElements.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapSceneElements", package.seeall)

local VersionActivity1_6DungeonMapSceneElements = class("VersionActivity1_6DungeonMapSceneElements", BaseView)

function VersionActivity1_6DungeonMapSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6DungeonMapSceneElements:addEvents()
	return
end

function VersionActivity1_6DungeonMapSceneElements:removeEvents()
	return
end

function VersionActivity1_6DungeonMapSceneElements:_editableInitView()
	self._elementCompDict = {}
	self._elementCompPoolDict = {}
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self._click:AddClickDownListener(self.onClickDown, self)
	self._click:AddClickUpListener(self.onClickUp, self)
	self:customAddEvent()
end

function VersionActivity1_6DungeonMapSceneElements:onOpen()
	return
end

function VersionActivity1_6DungeonMapSceneElements:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_6DungeonMapSceneElements:onDestroyView()
	self:clearElements()
	self._click:RemoveClickDownListener()
	self._click:RemoveClickUpListener()
end

function VersionActivity1_6DungeonMapSceneElements:customAddEvent()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideClickElement, self.manualClickElement, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonEvent.OnBeginDragMap, self.onBeginDragMap, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, self.onCreateMapRootGoDone, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.addEventCb(self, VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self.onChangeMap, self)
end

function VersionActivity1_6DungeonMapSceneElements:onGamepadKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
		local maxIndex = allRaycastHit.Length - 1

		for i = 0, maxIndex do
			local hitInfo = allRaycastHit[i]
			local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, VersionActivity1_6DungeonMapElement)

			if comp then
				comp:_onClickDown()

				return
			end
		end
	end
end

function VersionActivity1_6DungeonMapSceneElements:setMouseElementDown(elementComp)
	self.mouseDownElement = elementComp
end

function VersionActivity1_6DungeonMapSceneElements:onBeginDragMap()
	self._clickDown = false
end

function VersionActivity1_6DungeonMapSceneElements:onClickDown()
	self._clickDown = true
end

function VersionActivity1_6DungeonMapSceneElements:onClickUp()
	local element = self.mouseDownElement

	self.mouseDownElement = nil

	if not self._clickDown then
		return
	end

	if not element then
		return
	end

	local id = element:getElementId()

	if DungeonMapModel.instance:elementIsFinished(id) then
		return
	end

	if not element:isValid() then
		return
	end

	element:onClick()
end

function VersionActivity1_6DungeonMapSceneElements:manualClickElement(id)
	local mapElement = self:getElementComp(tonumber(id))

	if not mapElement then
		return
	end

	if not mapElement:isValid() then
		return
	end

	mapElement:onClick()
end

function VersionActivity1_6DungeonMapSceneElements:onClickElement(elementComp)
	self:hideTimeContainer()
	self:hideAllElements()
end

function VersionActivity1_6DungeonMapSceneElements:onHideInteractUI()
	self:showTimeContainer()
	self:showAllElements()
end

function VersionActivity1_6DungeonMapSceneElements:onCreateMapRootGoDone(sceneRoot)
	if self.elementPoolRoot then
		return
	end

	self.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(sceneRoot, self.elementPoolRoot)
	gohelper.setActive(self.elementPoolRoot, false)
	transformhelper.setLocalPos(self.elementPoolRoot.transform, 0, 0, 0)
end

function VersionActivity1_6DungeonMapSceneElements:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._sceneGo = param.mapSceneGo
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)
end

function VersionActivity1_6DungeonMapSceneElements:onDisposeScene()
	self:clearElements()
end

function VersionActivity1_6DungeonMapSceneElements:onDisposeOldMap(viewName)
	self:recycleAllElements()

	self._elementRoot = nil
end

function VersionActivity1_6DungeonMapSceneElements:hideAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:hideElement()
	end
end

function VersionActivity1_6DungeonMapSceneElements:showAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:showElement()
	end
end

function VersionActivity1_6DungeonMapSceneElements:clearElements()
	if self._elementCompDict then
		for _, v in pairs(self._elementCompDict) do
			v:onDestroy()
		end
	end

	if self._elementCompPoolDict then
		for _, v in pairs(self._elementCompPoolDict) do
			v:onDestroy()
		end
	end

	self._elementRoot = nil

	tabletool.clear(self._elementCompDict)
	tabletool.clear(self._elementCompPoolDict)
end

function VersionActivity1_6DungeonMapSceneElements:recycleAllElements()
	if self._elementCompDict then
		for _, elementComp in pairs(self._elementCompDict) do
			self._elementCompPoolDict[elementComp:getElementId()] = elementComp

			gohelper.addChild(self.elementPoolRoot, elementComp._go)
		end

		tabletool.clear(self._elementCompDict)
	end

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnRecycleAllElement)
end

function VersionActivity1_6DungeonMapSceneElements:showElements()
	if self.activityDungeonMo:isHardMode() then
		self:recycleAllElements()

		return
	end

	local isBossUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	if self._mapCfg and isBossUnlock then
		local bossMapElement = Activity149Config.instance:getAct149BossMapElementByMapId(self._mapCfg.id)

		if bossMapElement then
			local hideObjPaths = VersionActivity1_6DungeonEnum.DungeonBossElementHideObjPaths

			for i, path in ipairs(hideObjPaths) do
				local hideGo = gohelper.findChild(self._sceneGo, path)

				gohelper.setActive(hideGo, false)
			end

			self:_addElement(bossMapElement)
		end
	end
end

function VersionActivity1_6DungeonMapSceneElements:_addElement(elementConfig)
	if self._elementCompDict[elementConfig.id] then
		return
	end

	local elementComp = self._elementCompPoolDict[elementConfig.id]

	if elementComp then
		self._elementCompPoolDict[elementConfig.id] = nil

		gohelper.addChild(self._elementRoot, elementComp._go)
		elementComp:updatePos()
	else
		local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

		gohelper.addChild(self._elementRoot, go)

		elementComp = MonoHelper.addLuaComOnceToGo(go, VersionActivity1_6DungeonMapElement, {
			elementConfig,
			self
		})
	end

	self._elementCompDict[elementConfig.id] = elementComp

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnAddOneElement, elementComp)
end

function VersionActivity1_6DungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementCompDict[id]

	elementComp:setFinish()

	self._elementCompDict[id] = nil
	self._elementCompPoolDict[id] = elementComp

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnRemoveElement, elementComp)
end

function VersionActivity1_6DungeonMapSceneElements:_addElementById(id)
	local config = lua_chapter_map_element.configDict[id]

	self:_addElement(config)
end

function VersionActivity1_6DungeonMapSceneElements:onRemoveElement(id)
	if not self._showRewardView then
		self:_removeElement(id)
	else
		self._needRemoveElementId = id
	end
end

function VersionActivity1_6DungeonMapSceneElements:getElementComp(elementId)
	return self._elementCompDict[elementId]
end

function VersionActivity1_6DungeonMapSceneElements:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity1_6DungeonMapSceneElements:endShowRewardView()
	self._showRewardView = false

	if self._needRemoveElementId then
		self:_removeElement(self._needRemoveElementId)

		self._needRemoveElementId = nil
	end
end

function VersionActivity1_6DungeonMapSceneElements:onChangeMap()
	return
end

return VersionActivity1_6DungeonMapSceneElements
