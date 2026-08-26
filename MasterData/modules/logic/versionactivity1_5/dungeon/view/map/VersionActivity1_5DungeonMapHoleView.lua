-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapHoleView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapHoleView", package.seeall)

local VersionActivity1_5DungeonMapHoleView = class("VersionActivity1_5DungeonMapHoleView", BaseView)

function VersionActivity1_5DungeonMapHoleView:onInitView()
	self._godispatcharea = gohelper.findChild(self.viewGO, "#go_dispatcharea")
	self._goareaitem = gohelper.findChild(self.viewGO, "#go_dispatcharea/#go_areaitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapHoleView:addEvents()
	return
end

function VersionActivity1_5DungeonMapHoleView:removeEvents()
	return
end

function VersionActivity1_5DungeonMapHoleView:_editableInitView()
	gohelper.setActive(self._godispatcharea, true)
	gohelper.setActive(self._goareaitem, false)

	self.loadSceneDone = false
	self.transform = self._godispatcharea:GetComponent(gohelper.Type_RectTransform)
	self.tempVector = Vector3.zero
	self.tempVector4 = Vector4.zero
	self.areaItemDict = {}
	self.areaItemPool = {}
	self.exploreElementIdList = {}
	self.subHeroElementIdList = {}
	self.validElementIdList = {}
	self.validExploreIdList = {}
	self.elementPosDict = {}
	self.shaderParamList = self:getUserDataTb_()

	for i = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		table.insert(self.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. i))
	end

	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, self.hideAreaUI, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, self.showAreaUI, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.TweenMapPosDone, self.tweenMapPosDone, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, self.onDispatchFinish, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.FocusElement, self.onFocusElement, self)
end

function VersionActivity1_5DungeonMapHoleView:loadSceneFinish(param)
	if gohelper.isNil(param.mapSceneGo) then
		return
	end

	self.loadSceneDone = true
	self.sceneGo = param.mapSceneGo
	self.sceneTrans = self.sceneGo.transform

	local shaderGo = gohelper.findChild(self.sceneGo, "Obj-Plant/FogOfWar/m_s14_hddt_mask")

	if not shaderGo then
		logError("not found shader mask go, " .. self.sceneGo.name)

		return
	end

	local meshRender = shaderGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	self.shader = meshRender.sharedMaterial

	self:initCameraParam()
	self:refreshHoles()
end

function VersionActivity1_5DungeonMapHoleView:initCameraParam()
	local canvasGo = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local scale = GameUtil.getAdapterScale()
	local worldcorners = canvasGo.transform:GetWorldCorners()

	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.mainCameraPosX, self.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	local uiCameraSize = self.mainCamera.orthographicSize
	local cameraSizeRate = VersionActivity1_5DungeonEnum.DungeonMapCameraSize / uiCameraSize
	local posTL = worldcorners[1] * scale * cameraSizeRate
	local posBR = worldcorners[3] * scale * cameraSizeRate
	local mapHalfWidth = math.abs(posBR.x - posTL.x) / 2
	local mapHalfHeight = math.abs(posBR.y - posTL.y) / 2

	self.validMinDistanceX = mapHalfWidth + VersionActivity1_5DungeonEnum.HoleHalfWidth
	self.validMinDistanceY = mapHalfHeight + VersionActivity1_5DungeonEnum.HoleHalfHeight
end

function VersionActivity1_5DungeonMapHoleView:onMapPosChanged()
	self.sceneWorldPosX, self.sceneWorldPosY = transformhelper.getPos(self.sceneTrans)

	tabletool.clear(self.validElementIdList)
	tabletool.clear(self.validExploreIdList)

	for _, elementId in ipairs(self.exploreElementIdList) do
		self:refreshAreaItem(elementId)
	end

	for _, elementId in ipairs(self.subHeroElementIdList) do
		if self:subHeroTaskElementIsValid(elementId) then
			table.insert(self.validElementIdList, elementId)
		end
	end

	self:refreshHoles()
end

function VersionActivity1_5DungeonMapHoleView:onAddOneElement(elementComp)
	local elementId = elementComp:getElementId()
	local exploreCo = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(elementId)

	if exploreCo then
		self:addExploreHole(exploreCo, elementId)

		return
	end

	local subHeroTaskCo = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(elementId)

	if subHeroTaskCo then
		self:addSubHeroTaskHole(subHeroTaskCo, elementId)

		return
	end
end

function VersionActivity1_5DungeonMapHoleView:addExploreHole(exploreCo, elementId)
	local status = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(exploreCo)

	if status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward then
		return
	end

	table.insert(self.exploreElementIdList, elementId)
	self:refreshAreaItem(elementId)
	self:refreshHoles()
end

function VersionActivity1_5DungeonMapHoleView:addSubHeroTaskHole(subHeroTaskCo, elementId)
	local status = VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(subHeroTaskCo)

	if status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.GainedReward then
		return
	end

	table.insert(self.subHeroElementIdList, elementId)

	if self:subHeroTaskElementIsValid(elementId) then
		table.insert(self.validElementIdList, elementId)
	end

	self:refreshHoles()
end

function VersionActivity1_5DungeonMapHoleView:onRemoveElement(elementComp)
	local elementId = elementComp:getElementId()
	local exploreCo = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(elementId)

	if exploreCo then
		self:removeExploreElement(exploreCo, elementId)

		return
	end

	local subHeroTaskCo = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(elementId)

	if subHeroTaskCo then
		self:removeSubHeroTaskElement(subHeroTaskCo, elementId)

		return
	end
end

function VersionActivity1_5DungeonMapHoleView:removeExploreElement(exploreCo, elementId)
	tabletool.removeValue(self.exploreElementIdList, elementId)
	table.remove(self.validExploreIdList, exploreCo.id)

	local index = tabletool.indexOf(self.validElementIdList, elementId)

	if index then
		table.remove(self.validElementIdList, index)
		self:playHoleCloseAnimByElementId(elementId)
		self:playAreaItemCloseAnim(exploreCo.id)
	else
		self:recycleAreaItemById(exploreCo.id)
	end
end

function VersionActivity1_5DungeonMapHoleView:removeSubHeroTaskElement(subHeroTaskCo, elementId)
	tabletool.removeValue(self.subHeroElementIdList, elementId)

	local index = tabletool.indexOf(self.validElementIdList, elementId)

	if index then
		table.remove(self.validElementIdList, index)
		self:playHoleCloseAnimByElementId(elementId)
	end
end

function VersionActivity1_5DungeonMapHoleView:onRecycleAllElement()
	for _, areaItem in pairs(self.areaItemDict) do
		self:recycleAreaItem(areaItem)
	end

	tabletool.clear(self.exploreElementIdList)
	tabletool.clear(self.subHeroElementIdList)
	tabletool.clear(self.areaItemDict)
	tabletool.clear(self.validElementIdList)
	tabletool.clear(self.validExploreIdList)
	self:refreshHoles()
end

function VersionActivity1_5DungeonMapHoleView:refreshAreaItem(elementId)
	local exploreCo = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(elementId)
	local areaItem = self.areaItemDict[exploreCo.id]

	if not areaItem then
		areaItem = self:createAreaItem(exploreCo)
		self.areaItemDict[exploreCo.id] = areaItem
	end

	if not self:checkPosIsValid(exploreCo.areaPosX, exploreCo.areaPosY) then
		gohelper.setActive(areaItem.go, false)

		return
	end

	table.insert(self.validExploreIdList, exploreCo.id)
	table.insert(self.validElementIdList, elementId)

	self.elementPosDict[elementId] = self.elementPosDict[elementId] or {
		exploreCo.areaPosX,
		exploreCo.areaPosY
	}

	gohelper.setActive(areaItem.go, true)
	gohelper.setActive(areaItem.goFight, exploreCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight)
	gohelper.setActive(areaItem.goDispatch, exploreCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch)
	self:refreshExplorePoint(areaItem, exploreCo)
	self.tempVector:Set(exploreCo.areaPosX + self.sceneWorldPosX, exploreCo.areaPosY + self.sceneWorldPosY)

	local anchorPos = recthelper.worldPosToAnchorPos(self.tempVector, self.transform)

	recthelper.setAnchor(areaItem.rectTr, anchorPos.x, anchorPos.y + VersionActivity1_5DungeonEnum.AreaItemOffsetY)
end

function VersionActivity1_5DungeonMapHoleView:refreshExplorePoint(areaItem, exploreCo)
	local isDispatchTask = exploreCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch

	gohelper.setActive(areaItem.goPoint, isDispatchTask)

	if isDispatchTask then
		local elementIdList = exploreCo.elementList
		local elementCount = #elementIdList
		local elementId = elementIdList[1]
		local pointItem = self:getPointItem(areaItem, 1)
		local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)

		if not dispatchMo then
			gohelper.setActive(pointItem.goRunning, false)
			gohelper.setActive(pointItem.goFinish, false)
		elseif dispatchMo:isRunning() then
			gohelper.setActive(pointItem.goRunning, true)
			gohelper.setActive(pointItem.goFinish, false)
		elseif dispatchMo:isFinish() then
			gohelper.setActive(pointItem.goRunning, false)
			gohelper.setActive(pointItem.goFinish, true)
		end

		for i = 2, elementCount do
			elementId = elementIdList[i]
			pointItem = self:getPointItem(areaItem, i)

			if DungeonMapModel.instance:elementIsFinished(elementIdList[i]) then
				gohelper.setActive(pointItem.goRunning, false)
				gohelper.setActive(pointItem.goFinish, true)
			else
				gohelper.setActive(pointItem.goRunning, false)
				gohelper.setActive(pointItem.goFinish, false)
			end
		end

		for i = elementCount + 1, #areaItem.pointList do
			gohelper.setActive(areaItem.pointList[i].go, false)
		end
	end
end

function VersionActivity1_5DungeonMapHoleView:subHeroTaskElementIsValid(elementId)
	local pos = self.elementPosDict[elementId]

	if not pos then
		local elementCo = lua_chapter_map_element.configDict[elementId]

		pos = string.splitToNumber(elementCo.pos, "#")
		self.elementPosDict[elementId] = pos
	end

	return self:checkPosIsValid(pos[1], pos[2])
end

function VersionActivity1_5DungeonMapHoleView:checkPosIsValid(conifgPosX, conifgPosY)
	local centerPosX = conifgPosX + self.sceneWorldPosX
	local centerPosY = conifgPosY + self.sceneWorldPosY
	local xDistance = math.sqrt((self.mainCameraPosX - centerPosX)^2)
	local yDistance = math.sqrt((self.mainCameraPosY - centerPosY)^2)

	if xDistance <= self.validMinDistanceX and yDistance <= self.validMinDistanceY then
		return true
	end

	return false
end

function VersionActivity1_5DungeonMapHoleView:checkViewPortPosIsValid(viewPortPos)
	if viewPortPos.x < 0 or viewPortPos.x > 1 or viewPortPos.y < 0 or viewPortPos.y > 1 then
		return false
	end

	return true
end

function VersionActivity1_5DungeonMapHoleView:refreshHoles()
	if not self.loadSceneDone then
		return
	end

	if gohelper.isNil(self.shader) then
		return
	end

	for index = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		local elementId = self.validElementIdList[index]

		if elementId then
			local pos = self.elementPosDict[elementId]

			self.tempVector4:Set(pos[1] + self.sceneWorldPosX, pos[2] + self.sceneWorldPosY)
		else
			self.tempVector4:Set(VersionActivity1_5DungeonEnum.OutSideAreaPos.X, VersionActivity1_5DungeonEnum.OutSideAreaPos.Y)
		end

		self.shader:SetVector(self.shaderParamList[index], self.tempVector4)
	end

	if SLFramework.FrameworkSettings.IsEditor and #self.validElementIdList > VersionActivity1_5DungeonEnum.MaxHoleNum then
		logError("同时挖洞个数大于5个了，多余直接丢弃, " .. table.concat(self.validElementIdList, ";"))
	end
end

function VersionActivity1_5DungeonMapHoleView:createAreaItem()
	if #self.areaItemPool > 0 then
		return table.remove(self.areaItemPool)
	end

	local areaItem = self:getUserDataTb_()

	areaItem.go = gohelper.cloneInPlace(self._goareaitem)
	areaItem.rectTr = areaItem.go:GetComponent(gohelper.Type_RectTransform)
	areaItem.goFight = gohelper.findChild(areaItem.go, "#go_tip/fight")
	areaItem.goDispatch = gohelper.findChild(areaItem.go, "#go_tip/dispatch")
	areaItem.goPoint = gohelper.findChild(areaItem.go, "#go_tip/progresspoint")
	areaItem.goPointItem = gohelper.findChild(areaItem.go, "#go_tip/progresspoint/staritem")
	areaItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(areaItem.go)

	gohelper.setActive(areaItem.goPointItem, false)

	areaItem.pointList = {}

	return areaItem
end

function VersionActivity1_5DungeonMapHoleView:getPointItem(areaItem, index)
	local pointItem = areaItem.pointList[index]

	if pointItem then
		gohelper.setActive(pointItem.go, true)

		return pointItem
	end

	pointItem = self:getUserDataTb_()
	pointItem.go = gohelper.cloneInPlace(areaItem.goPointItem, index)
	pointItem.goRunning = gohelper.findChild(pointItem.go, "running")
	pointItem.goFinish = gohelper.findChild(pointItem.go, "finish")
	areaItem.pointList[index] = pointItem

	gohelper.setActive(pointItem.go, true)

	return pointItem
end

function VersionActivity1_5DungeonMapHoleView:recycleAreaItem(areaItem)
	gohelper.setActive(areaItem.go, false)
	table.insert(self.areaItemPool, areaItem)
end

function VersionActivity1_5DungeonMapHoleView:recycleAreaItemById(exploreId)
	local areaItem = self.areaItemDict[exploreId]

	if areaItem then
		self:recycleAreaItem(areaItem)

		self.areaItemDict[exploreId] = nil
	end
end

function VersionActivity1_5DungeonMapHoleView:_onScreenResize()
	self:initCameraParam()
end

function VersionActivity1_5DungeonMapHoleView:hideAreaUI()
	self.needHideArea = true
end

function VersionActivity1_5DungeonMapHoleView:showAreaUI()
	self.needHideArea = false

	for _, exploreId in ipairs(self.validExploreIdList) do
		local areaItem = self.areaItemDict[exploreId]

		gohelper.setActive(areaItem.go, true)
	end
end

function VersionActivity1_5DungeonMapHoleView:checkNeedPlayShowAnimAudio()
	if self.needPlayShowAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

		self.needPlayShowAudio = false
	end
end

function VersionActivity1_5DungeonMapHoleView:tweenMapPosDone()
	if not self.needHideArea then
		self:checkNeedPlayShowAnimAudio()

		return
	end

	self.hideItemCount = 0

	for _, exploreId in ipairs(self.validExploreIdList) do
		local areaItem = self.areaItemDict[exploreId]

		areaItem.animatorPlayer:Play("hide", self.onHideAnimDone, self)

		self.hideItemCount = self.hideItemCount + 1
	end
end

function VersionActivity1_5DungeonMapHoleView:onHideAnimDone()
	self.hideItemCount = self.hideItemCount - 1

	if self.hideItemCount == 0 then
		for _, exploreId in ipairs(self.validExploreIdList) do
			local areaItem = self.areaItemDict[exploreId]

			gohelper.setActive(areaItem.go, false)
		end
	end
end

function VersionActivity1_5DungeonMapHoleView:playHoleCloseAnimByElementId(elementId)
	local index = tabletool.indexOf(self.validElementIdList, elementId)

	if not index then
		self:refreshHoles()

		return
	end

	if index > VersionActivity1_5DungeonEnum.MaxHoleNum then
		self:refreshHoles()

		return
	end

	self:playHoleCloseAnim(index)
end

function VersionActivity1_5DungeonMapHoleView:playHoleCloseAnim(pos)
	self.param = self.shaderParamList[pos]

	if not self.param then
		self:refreshHoles()

		return
	end

	UIBlockMgr.instance:startBlock("playHoleAnim")

	self.startVector4 = self.shader:GetVector(self.param)
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(VersionActivity1_5DungeonEnum.HoleAnimMinZ, VersionActivity1_5DungeonEnum.HoleAnimMaxZ, VersionActivity1_5DungeonEnum.HoleAnimDuration, self.frameCallback, self.doneCallback, self)
end

function VersionActivity1_5DungeonMapHoleView:frameCallback(value)
	self.tempVector4:Set(self.startVector4.x, self.startVector4.y, value)
	self.shader:SetVector(self.param, self.tempVector4)
end

function VersionActivity1_5DungeonMapHoleView:doneCallback()
	self.tempVector4:Set(self.startVector4.x, self.startVector4.y, VersionActivity1_5DungeonEnum.HoleAnimMaxZ)
	self.shader:SetVector(self.param, self.tempVector4)
	self:refreshHoles()
	UIBlockMgr.instance:endBlock("playHoleAnim")
end

function VersionActivity1_5DungeonMapHoleView:playAreaItemCloseAnim(exploreCoId)
	local areaItem = self.areaItemDict[exploreCoId]

	if areaItem then
		UIBlockMgr.instance:startBlock("playAreaAnim")

		self.playingExploreId = exploreCoId

		areaItem.animatorPlayer:Play("close", self.onCloseAnimDone, self)
	end
end

function VersionActivity1_5DungeonMapHoleView:onCloseAnimDone()
	self:recycleAreaItemById(self.playingExploreId)

	self.playingExploreId = nil

	self:onMapPosChanged()
	UIBlockMgr.instance:endBlock("playAreaAnim")
end

function VersionActivity1_5DungeonMapHoleView:onDispatchFinish()
	for _, exploreId in ipairs(self.validExploreIdList) do
		local exploreCo = VersionActivity1_5DungeonConfig.instance:getExploreTask(exploreId)
		local areaItem = self.areaItemDict[exploreId]

		self:refreshExplorePoint(areaItem, exploreCo)
	end
end

function VersionActivity1_5DungeonMapHoleView:onFocusElement(elementId)
	if tabletool.indexOf(self.validElementIdList, elementId) then
		self.needPlayShowAudio = false

		return
	end

	local exploreCo = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(elementId)

	self.needPlayShowAudio = exploreCo ~= nil
end

function VersionActivity1_5DungeonMapHoleView:onClose()
	return
end

return VersionActivity1_5DungeonMapHoleView
