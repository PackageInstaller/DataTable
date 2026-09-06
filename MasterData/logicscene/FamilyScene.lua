-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/FamilyScene.lua

module("logicscene.scene.impl.FamilyScene", package.seeall)

local FamilyScene = class("FamilyScene", CityScene)

FamilyScene.SceneStageRootPos = Vector3.New(0, 0, -50)
FamilyScene.PlayerBornLimitStartPos = {
	z = -105,
	x = -70,
	y = 0
}
FamilyScene.PlayerBornLimitEndPos = {
	z = -70,
	x = 50,
	y = 0
}
FamilyScene.PlayerLimitStartPos = {
	z = -130,
	x = -140,
	y = 0
}
FamilyScene.PlayerLimitEndPos = {
	z = -50,
	x = 90,
	y = 0
}
FamilyScene.PlayerSpeed = FamilySceneMainPlayer.localScale * 1.2
FamilyScene.CameraLimitStartPos = {
	z = -250,
	x = -105,
	y = 0
}
FamilyScene.CameraLimitEndPos = {
	z = -45,
	x = 60,
	y = 0
}
FamilyScene.playerToCamDir = Vector3.New(0, 45, -80)
FamilyScene.CameraEulerAngle = Vector3.New(16, 0, 0)
FamilyScene.CameraFov = 40

function FamilyScene:_initComponents()
	self:_addComponent("stage", FamilySceneStage)
	self:_addComponent("camera", FamilySceneCamera)
	self:_addComponent("unitFactory", FamilyUnitFactory)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("joystick", FamilySceneJoystickListenerEx)
	self:_addComponent("picker", FamilyScenePickerEx)
	self:_addComponent("otherPlayers", FamilySceneOtherPlayers)
	self:_addComponent("bgm", FamilySceneBgmMgr)
	self:_addComponent("walkEff", MainPlayerWalkDestEff)
end

function FamilyScene:getSceneType()
	return SceneType.Family
end

function FamilyScene:onEnter(sceneId, bornX, bornZ)
	UnityEngine.Physics.IgnoreLayerCollision(UnityEngine.LayerMask.NameToLayer("MainPlayer"), LayerMask.NameToLayer("AirWall"), false)
	FamilySceneMainPlayer.instance:createMainPlayer()
	FamilyScene.super.onEnter(self, sceneId, bornX, bornZ)
end

function FamilyScene:onEnterFinished()
	FamilySceneMainPlayer.instance:updatePlayerPosition(self)
	FamilyScene.super.onEnterFinished(self)

	self.mainPlayer = FamilySceneMainPlayer.instance

	FamilySceneMainPlayer.instance:onEnterSceneFinished(self)

	self.stageIns = self.stage:getStageIns()

	GameUtil.SetActive(self.stageIns, true)
	self:_initSceneObjectInfo()

	self._buildingList = self.unitFactory:createAllBuilding()

	for i, unit in ipairs(self._buildingList) do
		if unit and unit.onUnitCreated then
			unit:onUnitCreated(self.posGoList[unit.type])
			unit:onUnitVisible()
		end
	end

	self.walkEff:setLocalPos(0, 0, 0)
	self.walkEff:setLocalRotation(40, 0, 0)
	self.walkEff:SetLocalScale(5, 5, 5)
end

function FamilyScene:lateEnterFinished()
	FamilyScene.super.lateEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
		mainPlayer:setVisible(false)
	end

	self.joystick:setEnable(true)

	local familyMainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()

	if familyMainPlayer then
		familyMainPlayer:setVisible(true)
	end
end

function FamilyScene:onExit()
	FamilyScene.super.onExit(self)
	UnityEngine.Physics.IgnoreLayerCollision(UnityEngine.LayerMask.NameToLayer("MainPlayer"), LayerMask.NameToLayer("AirWall"), true)
	FamilySceneMainPlayer.instance:destroyMainPlayer()
end

function FamilyScene:_initSceneObjectInfo()
	self.posGoList = {}
	self.posGoList[FamilyBuildingType.Welfare] = goutil.findChild(self.stageIns, "welfare")
	self.posGoList[FamilyBuildingType.Activities] = goutil.findChild(self.stageIns, "activities")
	self.posGoList[FamilyBuildingType.Transaction] = goutil.findChild(self.stageIns, "transaction")
end

function FamilyScene:update(deltaTime)
	local units = self.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:update(deltaTime)
		end
	end

	if self.mainPlayer then
		local mainPlayer = self.mainPlayer:getMainPlayer()

		if mainPlayer then
			mainPlayer:update(deltaTime)
		end
	end

	self.walkEff:update(deltaTime)

	if not goutil.isNil(self.camera._mainCamera:getGO()) then
		if UGUIToolHelper.IsTouchDown() then
			self:_onTouchDown()
		elseif UGUIToolHelper.IsTouchUp() then
			self:_onTouchUp()
		end
	end
end

function FamilyScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end

	local familyMainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()

	if familyMainPlayer then
		familyMainPlayer:setVisible(visible)
	end
end

function FamilyScene:visibleOthersObjects(visible)
	local units = self.unitFactory:getAllUnit()
	local mainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if v2:getTag() ~= UnitTag.Pet or v2:getOwner() ~= mainPlayer then
				v2:setVisible(visible)
			end
		end
	end

	self._otherPlayerVisible = visible
end

function FamilyScene:visibleObjects(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end

	if self.walkEff then
		self.walkEff:setVisible(visible)
	end

	self._otherPlayerVisible = visible

	local familyMainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()

	if familyMainPlayer then
		familyMainPlayer:setVisible(visible)
	end

	printInfo("test FamilyScene:visibleObjects", visible)
	self.unitFactory:showUnits(visible)
end

function FamilyScene:_onNpcModel(npcId)
	return
end

function FamilyScene:_onNpcVisible(npcId, go, visible)
	return
end

function FamilyScene:_onNpcCreate(npcId, pos, ofs, paths, moveSpeed, reverse, nameOfs, scale)
	return
end

function FamilyScene:_onNpcDestroy(npcId, quality)
	return
end

function FamilyScene:getDefaultView()
	return ViewName.FamilySceneMainView
end

function FamilyScene:_onTouchDown()
	if not UGUIToolHelper.IsOverUI() then
		if not self._isTouchedDown then
			self._isTouchedDown = true
			self._touchDonwPos = UGUIToolHelper.GetTouchPosition()
			self._timeOnTouchDown = UnityEngine.Time.unscaledTime
			self._ratCastHitObj = self:_getRaycastHitObject()
		end
	else
		self._isTouchedDown = nil
		self._ratCastHitObj = nil
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil
	end
end

function FamilyScene:_onTouchUp()
	if not self._isTouchedDown then
		return
	end

	local mousePos = UGUIToolHelper.GetTouchPosition()

	if GameUtil.getVector2Distance(mousePos, self._touchDonwPos) >= UGUIToolHelper.touchDragThreshold then
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil
		self._isTouchedDown = nil
		self._ratCastHitObj = nil

		return
	end

	if UnityEngine.Time.unscaledTime - self._timeOnTouchDown >= 0.2 then
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil
		self._isTouchedDown = nil
		self._ratCastHitObj = nil

		return
	end

	self._touchDonwPos = nil
	self._timeOnTouchDown = nil

	if self._travelShow == true then
		GlobalDispatcher:dispatch(GlobalNotify.CutePetSkipTravelAnim)

		return
	end

	if UGUIToolHelper.IsOverUI() then
		self._isTouchedDown = nil
		self._ratCastHitObj = nil

		return
	end

	local hitGo = self:_getRaycastHitObject()

	if hitGo and hitGo == self._ratCastHitObj then
		local name = hitGo.name
		local hitInfo = string.split(name, "_")

		if #hitInfo > 1 and hitInfo[1] == "Building" then
			if checknumber(hitInfo[2]) == FamilyBuildingType.Welfare then
				GlobalDispatcher:dispatch(GlobalNotify.FamilySceneClickWelfare)
			elseif checknumber(hitInfo[2]) == FamilyBuildingType.Activities then
				GlobalDispatcher:dispatch(GlobalNotify.FamilySceneClickActivities)
			elseif checknumber(hitInfo[2]) == FamilyBuildingType.Transaction then
				GlobalDispatcher:dispatch(GlobalNotify.FamilySceneClickTransaction)
			end
		end
	end

	self._isTouchedDown = nil
	self._ratCastHitObj = nil
end

function FamilyScene:_openViewOnEnter(...)
	ViewMgr.instance:open(ViewName.VirtualJoystick)
	UIJumper.instance:resumeStack()
	ViewMgr.instance:open(ViewName.HorseLanternView)
	ViewMgr.instance:open(ViewName.ItemFly)
	ViewMgr.instance:setPermanent(ViewName.HorseLanternView, true)
	ViewMgr.instance:setPermanent(ViewName.ItemFly, true)
	ViewMgr.instance:setPermanent(ViewName.VirtualJoystick, true)
	GMController.instance:showGM(true)
end

function FamilyScene:_getRaycastHitObject()
	local mousePos = UGUIToolHelper.GetTouchPosition()
	local ray = self.camera._mainCamera:getCamera():ScreenPointToRay(mousePos)
	local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)

	if isHit then
		return hitResult.collider.gameObject
	end
end

function FamilyScene:hideAllBuildingHud(bool)
	for i, unit in ipairs(self._buildingList) do
		if unit and unit.hud and unit.hud.setHudHide then
			unit.hud:setHudHide(bool)
		end
	end
end

return FamilyScene
