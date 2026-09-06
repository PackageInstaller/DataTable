-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/CutePetScene.lua

module("logicscene.scene.impl.CutePetScene", package.seeall)

local CutePetScene = class("CutePetScene", CityScene)

function CutePetScene:_initComponents()
	self:_addComponent("stage", CutePetSceneStage)
	self:_addComponent("camera", CutePetSceneCamera)
	self:_addComponent("unitFactory", CutePetUnitFactory)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("petMgr", SceneCompCutePetMgr)
	self:_addComponent("joystick", SceneCompDisableJoystickListener)
end

function CutePetScene:getSceneType()
	return SceneType.CutePet
end

function CutePetScene:onEnter(sceneId, bornX, bornZ)
	CutePetScene.super.onEnter(self, sceneId, bornX, bornZ)
end

function CutePetScene:onEnterFinished()
	CutePetScene.super.onEnterFinished(self)

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
end

function CutePetScene:lateEnterFinished()
	CutePetScene.super.lateEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
		mainPlayer:setVisible(false)
	end

	self.joystick:setEnable(false)
	CutePetEnterSceneSequenceController.instance:completeEnterScene()
end

function CutePetScene:_initSceneObjectInfo()
	self.posGoList = {}
	self.posGoList[CutePetBuildingType.Management] = goutil.findChild(self.stageIns, "management")
	self.posGoList[CutePetBuildingType.Travel] = goutil.findChild(self.stageIns, "travel")
	self.posGoList[CutePetBuildingType.Adventure] = goutil.findChild(self.stageIns, "adventure")
	self.posGoList[CutePetBuildingType.Shop] = goutil.findChild(self.stageIns, "shop")
	self.posGoList[CutePetBuildingType.Guest] = goutil.findChild(self.stageIns, "guest")
	self.travelGoList = {}

	local pathRoot = goutil.findChild(self.stageIns, "travelPath/pathList")

	for i = 1, pathRoot.transform.childCount do
		local pathGo = pathRoot.transform:GetChild(i - 1)
		local pathPoint = {}

		for j = 1, pathGo.transform.childCount do
			local pointGo = pathGo.transform:GetChild(j - 1)

			table.insert(pathPoint, pointGo)
		end

		table.insert(self.travelGoList, pathPoint)
	end

	self._travelFaZhen = goutil.findChild(self.stageIns, "fx_scene_fazhen")

	GameUtil.SetActive(self._travelFaZhen, false)
end

function CutePetScene:update(deltaTime)
	local units = self.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:update(deltaTime)
		end
	end

	self.camera:update(deltaTime)

	if not goutil.isNil(self.camera._mainCamera:getGO()) then
		if UGUIToolHelper.IsTouchDown() then
			self:_onTouchDown()
		elseif UGUIToolHelper.IsTouchUp() then
			self:_onTouchUp()
		end
	end
end

function CutePetScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end
end

function CutePetScene:visibleObjects(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end

	if self.walkEff then
		self.walkEff:setVisible(false)
	end

	self._otherPlayerVisible = visible
end

function CutePetScene:_onNpcModel(npcId)
	return
end

function CutePetScene:_onNpcVisible(npcId, go, visible)
	return
end

function CutePetScene:_onNpcCreate(npcId, pos, ofs, paths, moveSpeed, reverse, nameOfs, scale)
	return
end

function CutePetScene:_onNpcDestroy(npcId, quality)
	return
end

function CutePetScene:getDefaultView()
	return ViewName.CutePetMainView
end

function CutePetScene:_onTouchDown()
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

function CutePetScene:_onTouchUp()
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

		if #hitInfo > 1 then
			if hitInfo[1] == "Building" then
				if checknumber(hitInfo[2]) == CutePetBuildingType.Management then
					GlobalDispatcher:dispatch(GlobalNotify.CutePetClickManagement)
				elseif checknumber(hitInfo[2]) == CutePetBuildingType.Travel then
					GlobalDispatcher:dispatch(GlobalNotify.CutePetClickTravel)
				elseif checknumber(hitInfo[2]) == CutePetBuildingType.Adventure then
					GlobalDispatcher:dispatch(GlobalNotify.CutePetClickAdventure)
				elseif checknumber(hitInfo[2]) == CutePetBuildingType.Shop then
					GlobalDispatcher:dispatch(GlobalNotify.CutePetClickShop)
				elseif checknumber(hitInfo[2]) == CutePetBuildingType.Guest then
					GlobalDispatcher:dispatch(GlobalNotify.CutePetClickGuest)
				end
			elseif hitInfo[1] == "UnitCutePet" then
				GlobalDispatcher:dispatch(GlobalNotify.CutePetClickPet, checknumber(hitInfo[2]))
			end
		end
	end

	self._isTouchedDown = nil
	self._ratCastHitObj = nil
end

function CutePetScene:_openViewOnEnter(...)
	ViewMgr.instance:open(ViewName.VirtualJoystick)

	local root = UIStateManager.instance:getRoot()

	if not UIStateManager.instance:isInStack(root) and not UIJumper.instance:isInStack(root) then
		UIStateManager.instance:push(root)
	else
		UIJumper.instance:resumeStack()
	end

	ViewMgr.instance:open(ViewName.HorseLanternView)
	ViewMgr.instance:open(ViewName.ItemFly)
	ViewMgr.instance:setPermanent(ViewName.HorseLanternView, true)
	ViewMgr.instance:setPermanent(ViewName.ItemFly, true)
	ViewMgr.instance:setPermanent(ViewName.VirtualJoystick, true)
	GMController.instance:showGM(true)
end

function CutePetScene:_getRaycastHitObject()
	local mousePos = UGUIToolHelper.GetTouchPosition()
	local ray = self.camera._mainCamera:getCamera():ScreenPointToRay(mousePos)
	local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)

	if isHit then
		return hitResult.collider.gameObject
	end
end

function CutePetScene:createTravelCutePet(...)
	local raceList = {
		...
	}

	self._travelPetIds = self._travelPetIds or {}

	for i, v in pairs(self._travelPetIds) do
		if v == true then
			self.petMgr:removeTravelCutePet(i)

			self._travelPetIds[i] = false
		end
	end

	local tempUnit, tempId

	for i, v in ipairs(raceList) do
		if self.travelGoList[i] then
			local paths = {}

			for i, v in ipairs(self.travelGoList[i]) do
				local pos = GameUtil.getLocalPos(v)

				table.insert(paths, {
					stayMin = 0.1,
					stayMax = 0.2,
					x = pos.x,
					y = pos.z
				})
			end

			tempUnit, tempId = self.petMgr:createTravelCutePet(v, paths, GameUtil.getLocalPos(self.travelGoList[i][1]))
			self._travelPetIds[tempId] = true
		end
	end

	GameUtil.SetActive(self._travelFaZhen, true)

	self._travelShow = true

	return self._travelPetIds
end

function CutePetScene:removeAllTravelCutePet()
	for i, v in pairs(self._travelPetIds) do
		if v == true then
			self.petMgr:removeTravelCutePet(i)

			self._travelPetIds[i] = false
		end
	end

	GameUtil.SetActive(self._travelFaZhen, false)

	self._travelShow = false
end

function CutePetScene:removeTravelCutePet(index)
	if self._travelPetIds[index] == true then
		self.petMgr:removeTravelCutePet(index)

		self._travelPetIds[index] = false
	end
end

function CutePetScene:startMoveTravelCutePet()
	for i, v in pairs(self._travelPetIds) do
		if v == true then
			self.petMgr:travelPetRun(i)
		end
	end
end

function CutePetScene:hideAllBuildingHud(bool)
	for i, unit in ipairs(self._buildingList) do
		if unit and unit.hud and unit.hud.setHudHide then
			unit.hud:setHudHide(bool)
		end
	end
end

return CutePetScene
