-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/scene/VersionActivity1_8DungeonMapHoleView.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapHoleView", package.seeall)

local VersionActivity1_8DungeonMapHoleView = class("VersionActivity1_8DungeonMapHoleView", BaseView)

function VersionActivity1_8DungeonMapHoleView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DungeonMapHoleView:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.refreshHoles, self)
end

function VersionActivity1_8DungeonMapHoleView:removeEvents()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.refreshHoles, self)
end

function VersionActivity1_8DungeonMapHoleView:_onScreenResize()
	self:initCameraParam()
end

function VersionActivity1_8DungeonMapHoleView:loadSceneFinish(param)
	if gohelper.isNil(param.mapSceneGo) then
		return
	end

	self.loadSceneDone = true
	self.sceneGo = param.mapSceneGo
	self.sceneTrans = self.sceneGo.transform

	local shaderGo = gohelper.findChild(self.sceneGo, "Obj-Plant/FogOfWar/mask")

	if not shaderGo then
		logError("not found shader mask go, " .. self.sceneGo.name)

		return
	end

	local meshRender = shaderGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	self.shader = meshRender.sharedMaterial

	self:initCameraParam()
	self:refreshHoles()
end

function VersionActivity1_8DungeonMapHoleView:initCameraParam()
	local canvasGo = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local scale = GameUtil.getAdapterScale()
	local worldcorners = canvasGo.transform:GetWorldCorners()

	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.mainCameraPosX, self.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	local uiCameraSize = self.mainCamera.orthographicSize
	local cameraSizeRate = VersionActivity1_8DungeonEnum.DungeonMapCameraSize / uiCameraSize
	local posTL = worldcorners[1] * scale * cameraSizeRate
	local posBR = worldcorners[3] * scale * cameraSizeRate
	local mapHalfWidth = math.abs(posBR.x - posTL.x) / 2
	local mapHalfHeight = math.abs(posBR.y - posTL.y) / 2

	self.validMinDistanceX = mapHalfWidth + VersionActivity1_8DungeonEnum.HoleHalfWidth
	self.validMinDistanceY = mapHalfHeight + VersionActivity1_8DungeonEnum.HoleHalfHeight
end

function VersionActivity1_8DungeonMapHoleView:onMapPosChanged()
	self.sceneWorldPosX, self.sceneWorldPosY = transformhelper.getPos(self.sceneTrans)

	tabletool.clear(self.validElementIdList)

	for _, elementId in ipairs(self.beVerifyElementIdList) do
		local isValid = self:isElementValid(elementId)

		if isValid then
			table.insert(self.validElementIdList, elementId)
		end
	end

	self:refreshHoles()
end

function VersionActivity1_8DungeonMapHoleView:onAddOneElement(elementComp)
	local elementId = elementComp:getElementId()
	local actId = Activity157Model.instance:getActId()
	local act157MissionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

	self:addElementHole(act157MissionId, elementId)
end

function VersionActivity1_8DungeonMapHoleView:addElementHole(act157MissionId, elementId)
	local isFinish = false

	if act157MissionId then
		local actId = Activity157Model.instance:getActId()
		local act157MissionGroupId = Activity157Config.instance:getMissionGroup(actId, act157MissionId)

		isFinish = Activity157Model.instance:isFinishMission(act157MissionGroupId, act157MissionId)
	else
		isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
	end

	if isFinish then
		return
	end

	table.insert(self.beVerifyElementIdList, elementId)

	local isValid = self:isElementValid(elementId)

	if isValid then
		table.insert(self.validElementIdList, elementId)
	end

	self:refreshHoles()
end

function VersionActivity1_8DungeonMapHoleView:onRemoveElement(elementComp)
	if not elementComp then
		return
	end

	local elementId = elementComp:getElementId()

	self:removeElementHole(elementId)
end

function VersionActivity1_8DungeonMapHoleView:removeElementHole(elementId)
	tabletool.removeValue(self.beVerifyElementIdList, elementId)

	local index = tabletool.indexOf(self.validElementIdList, elementId)

	if index then
		table.remove(self.validElementIdList, index)
		self:playHoleCloseAnimByElementId(elementId)
	end
end

function VersionActivity1_8DungeonMapHoleView:onRecycleAllElement()
	tabletool.clear(self.beVerifyElementIdList)
	tabletool.clear(self.validElementIdList)
	self:refreshHoles()
end

function VersionActivity1_8DungeonMapHoleView:_editableInitView()
	self.loadSceneDone = false
	self.tempVector = Vector3.zero
	self.tempVector4 = Vector4.zero
	self.beVerifyElementIdList = {}
	self.validElementIdList = {}
	self.elementPosDict = {}
	self.shaderParamList = self:getUserDataTb_()

	for i = 1, VersionActivity1_8DungeonEnum.MaxHoleNum do
		table.insert(self.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. i))
	end
end

function VersionActivity1_8DungeonMapHoleView:isElementValid(elementId)
	local pos = self.elementPosDict[elementId]

	if not pos then
		local elementCo = lua_chapter_map_element.configDict[elementId]

		pos = string.splitToNumber(elementCo.pos, "#")
		self.elementPosDict[elementId] = pos
	end

	return (self:checkPosIsValid(pos[1], pos[2]))
end

function VersionActivity1_8DungeonMapHoleView:checkPosIsValid(conifgPosX, conifgPosY)
	local centerPosX = conifgPosX + self.sceneWorldPosX
	local centerPosY = conifgPosY + self.sceneWorldPosY
	local xDistance = math.sqrt((self.mainCameraPosX - centerPosX)^2)
	local yDistance = math.sqrt((self.mainCameraPosY - centerPosY)^2)

	if xDistance <= self.validMinDistanceX and yDistance <= self.validMinDistanceY then
		return true
	end

	return false
end

function VersionActivity1_8DungeonMapHoleView:refreshHoles()
	if not self.loadSceneDone or gohelper.isNil(self.shader) then
		return
	end

	for index = 1, VersionActivity1_8DungeonEnum.MaxHoleNum do
		local elementId = self.validElementIdList[index]
		local actId = Activity157Model.instance:getActId()
		local missionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

		if elementId and not (((missionId or nil) and Activity157Config.instance:isSideMission(actId, missionId) or nil) and Activity157Model.instance:isInProgressOtherMissionGroupByElementId(elementId)) then
			local pos = self.elementPosDict[elementId]

			self.tempVector4:Set(pos[1] + self.sceneWorldPosX, pos[2] + self.sceneWorldPosY)
		else
			self.tempVector4:Set(VersionActivity1_8DungeonEnum.OutSideAreaPos.X, VersionActivity1_8DungeonEnum.OutSideAreaPos.Y)
		end

		self.shader:SetVector(self.shaderParamList[index], self.tempVector4)
	end
end

function VersionActivity1_8DungeonMapHoleView:playHoleCloseAnimByElementId(elementId)
	local index = tabletool.indexOf(self.validElementIdList, elementId)

	if not index or index > VersionActivity1_8DungeonEnum.MaxHoleNum then
		self:refreshHoles()

		return
	end

	self:playHoleCloseAnim(index)
end

function VersionActivity1_8DungeonMapHoleView:playHoleCloseAnim(pos)
	self.param = self.shaderParamList[pos]

	if not self.param then
		self:refreshHoles()

		return
	end

	UIBlockMgr.instance:startBlock("playHoleAnim")

	self.startVector4 = self.shader:GetVector(self.param)
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(VersionActivity1_8DungeonEnum.HoleAnimMinZ, VersionActivity1_8DungeonEnum.HoleAnimMaxZ, VersionActivity1_8DungeonEnum.HoleAnimDuration, self.frameCallback, self.doneCallback, self)
end

function VersionActivity1_8DungeonMapHoleView:frameCallback(value)
	self.tempVector4:Set(self.startVector4.x, self.startVector4.y, value)
	self.shader:SetVector(self.param, self.tempVector4)
end

function VersionActivity1_8DungeonMapHoleView:doneCallback()
	self.tempVector4:Set(self.startVector4.x, self.startVector4.y, VersionActivity1_8DungeonEnum.HoleAnimMaxZ)
	self.shader:SetVector(self.param, self.tempVector4)
	self:refreshHoles()
	UIBlockMgr.instance:endBlock("playHoleAnim")
end

function VersionActivity1_8DungeonMapHoleView:onClose()
	return
end

return VersionActivity1_8DungeonMapHoleView
