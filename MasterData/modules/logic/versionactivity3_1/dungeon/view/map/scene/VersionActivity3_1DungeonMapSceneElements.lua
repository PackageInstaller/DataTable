-- chunkname: @modules/logic/versionactivity3_1/dungeon/view/map/scene/VersionActivity3_1DungeonMapSceneElements.lua

module("modules.logic.versionactivity3_1.dungeon.view.map.scene.VersionActivity3_1DungeonMapSceneElements", package.seeall)

local VersionActivity3_1DungeonMapSceneElements = class("VersionActivity3_1DungeonMapSceneElements", VersionActivityFixedDungeonMapSceneElements)

function VersionActivity3_1DungeonMapSceneElements:addEvents()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnBeginDragMap, self.onBeginDragMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, self.onCreateMapRootGoDone, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideClickElement, self.manualClickElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, self._updateElementArrow, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneLoadSceneFinish, self.onDisposeOldMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self.onChangeMap, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self._click:AddClickUpListener(self.onClickUp, self)
	self._click:AddClickDownListener(self.onClickDown, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.showNewElements, self)
end

function VersionActivity3_1DungeonMapSceneElements:removeEvents()
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnBeginDragMap, self.onBeginDragMap, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, self.onCreateMapRootGoDone, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.GuideClickElement, self.manualClickElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, self._updateElementArrow, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneLoadSceneFinish, self.onDisposeOldMap, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self.onChangeMap, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self._click:RemoveClickUpListener()
	self._click:RemoveClickDownListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.showNewElements, self)
end

function VersionActivity3_1DungeonMapSceneElements:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._sceneGo = param.mapSceneGo
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	local root = gohelper.findChild(self._sceneGo, "root")

	gohelper.addChild(root, self._elementRoot)
end

function VersionActivity3_1DungeonMapSceneElements:recycleAllElements()
	if self._elementCompDict then
		for _, elementComp in pairs(self._elementCompDict) do
			local elementId = elementComp:getElementId()

			self._elementCompPoolDict[elementId] = elementComp

			gohelper.addChild(self.elementPoolRoot, elementComp._go)
			gohelper.setActive(elementComp._go, false)
		end

		tabletool.clear(self._elementCompDict)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnRecycleAllElement)
end

function VersionActivity3_1DungeonMapSceneElements:_addElement(elementConfig)
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

		local _comp = VersionActivityFixedHelper.getVersionActivityDungeonMapElement(self._bigVersion, self._smallVersion)

		elementComp = MonoHelper.addLuaComOnceToGo(go, _comp, {
			elementConfig,
			self
		})
	end

	self._elementCompDict[elementConfig.id] = elementComp

	gohelper.setActive(elementComp._go, true)

	local hasArrow = elementComp:isConfigShowArrow()

	if hasArrow then
		local itemPath = self.viewContainer:getSetting().otherRes[3]
		local itemGo = self:getResInst(itemPath, self._goarrow)
		local rotationGo = gohelper.findChild(itemGo, "mesh")
		local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
		local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

		arrowClick:AddClickListener(self._arrowClick, self, elementConfig.id)

		local arrowItem = self:getUserDataTb_()

		arrowItem.go = itemGo
		arrowItem.rotationTrans = rotationGo.transform
		arrowItem.initRotation = {
			rx,
			ry,
			rz
		}
		arrowItem.arrowClick = arrowClick
		self._arrowList[elementConfig.id] = arrowItem

		self:_updateArrow(elementComp)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnAddOneElement, elementComp)
end

return VersionActivity3_1DungeonMapSceneElements
