-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomFurnitureHandler.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomFurnitureHandler", package.seeall)

local M = class("UnitCompRoomFurnitureHandler", UnitComponentBase)
local vec3Temp = Vector3.New()
local vec2Temp = Vector2.New()
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local WallType = HouseEnum.WallType
local FurnitureRotaType = HouseEnum.FurnitureRotaType
local kCameraDoDuration = 0.5
local kMaxCameraOffsetX = 7

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._selectedUnit = nil
	self._selectedOriginCoordX = nil
	self._selectedOriginCoordY = nil
	self._selectedOriginAngle = nil
	self._isSelectedNew = nil
	self._houseCameraUnit = nil
	self._blockOpera = nil
	self._isActive = false
end

function M:onInit()
	self._singleDragPos = Vector3.New()
	self._selectedUnit = false
	self._isSelectedNew = false
	self._blockOpera = false
	self._isActive = true
	self._houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	self._endBlockOperaTimer = SchedulerCtrl.New(self._endBlockOpera, self)

	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
end

function M:onReuse()
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)

	self._houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	self._isActive = true
end

function M:onReset()
	self._endBlockOperaTimer:stop()
	HouseFurnitureOpView.instance:hide()

	self._houseCameraUnit = false

	HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
	self:_setEditEvent(false)

	self._selectedUnit = false
	self._selectedOriginCoordX = false
	self._selectedOriginCoordY = false
	self._selectedOriginAngle = false
	self._isSelectedNew = false
	self._blockOpera = false
	self._isActive = false
end

function M:onDestroy()
	self:onReset()
	self._endBlockOperaTimer:clear()

	self._endBlockOperaTimer = nil
end

function M:refreshFurniturePos(furnitureUnit)
	if furnitureUnit then
		self._unit.furnitureMap:removeAllMapDataByUnit(furnitureUnit)
		self._unit.furnitureMap:addAllMapDataByUnit(furnitureUnit)

		local posX, posY, posZ = self._unit.furnitureMap:getWorldPosByUnit(furnitureUnit)

		Astral.TransformUtil.SetPos(furnitureUnit.go.transform, posX, posY, posZ)
		self._unit.furnitureMap:refreshGridState()
	end
end

function M:setSelectedFurniture(unit, isNew)
	if self:_isEdit() and unit then
		self._selectedUnit = unit
		self._selectedOriginCoordX = unit.model:getCoordX()
		self._selectedOriginCoordY = unit.model:getCoordY()
		self._selectedOriginAngle = unit.model:getAngle()

		local operaType = unit.model:getOperaType()

		self._isSelectedNew = isNew

		HouseFurnitureOpView.instance:show(unit)
		self:dispatchConflict()
		self:changeCameraBySelectedUnit()
		self._unit.furniturePaper:changeLayerByType(operaType)
	end
end

function M:getSelectedFurniture()
	if self:_isEdit() then
		return self._selectedUnit
	end
end

function M:clearSelectedFurniture()
	self._selectedUnit = false
	self._selectedOriginCoordX = false
	self._selectedOriginCoordY = false
	self._selectedOriginAngle = false
	self._isSelectedNew = false

	if self:_isEdit() then
		self:changeCameraByType(0)
	end
end

function M:getConflictData()
	local data = {}

	data.furnitureOverlap = false
	data.sealDoor = false
	data.forbidSingleBed = false
	data.forbidDoubleBed = false
	data.overSingleBed = false
	data.overDoubleBed = false
	data.noPath = not self:_hasPathInRoom()

	if self._selectedUnit then
		data.furnitureOverlap, data.sealDoor = self._unit.furnitureMap:checkFurnitureOverlapByUnit(self._selectedUnit)
		data.forbidSingleBed, data.forbidDoubleBed, data.overSingleBed, data.overDoubleBed = self._unit.furnitureMgr:getBedConflict()
	end

	return data
end

function M:dispatchConflict()
	if self._isActive then
		local data = self:getConflictData()

		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_CHECK_CONFLICT, data)
	end
end

function M:changeCameraBySelectedUnit()
	if self:_isEdit() and self._selectedUnit then
		local operaType = self._selectedUnit.model:getOperaType()
		local wallType = self._selectedUnit.model:getWallType()

		self:changeCameraByType(operaType, wallType)
	end
end

function M:changeCameraByType(operaType, wallType)
	local param
	local paramCfg = self._unit.model:getSizeType() == HouseEnum.RoomSize.Big and HouseEnum.FurnitureOperaType2CameraParamBig or HouseEnum.FurnitureOperaType2CameraParam

	if operaType == FurnitureOperaType.Wall then
		param = paramCfg[operaType][wallType]
	else
		param = paramCfg[operaType]
	end

	self:houseCameraDOKill()
	self._houseCameraUnit:setFieldOfView(HouseSceneUtil.getCamFOV(param.fov))

	local camGO = self._houseCameraUnit:getMainGO()
	local posX, posY, posZ = self._unit:getWorldPosByOffset(param.posX, param.posY, param.posZ)

	vec3Temp:Set(posX, posY, posZ)
	camGO.transform:DOMove(vec3Temp, kCameraDoDuration)

	local rotation = self._unit:getRotationByOffset(param.rotaX, param.rotaY, param.rotaZ)

	camGO.transform:DORotateQuaternion(rotation, kCameraDoDuration)

	self._blockOpera = true

	self._endBlockOperaTimer:restart(kCameraDoDuration, false)

	if operaType == 0 then
		self._unit.furnitureMap:recycleAllGrid()
	else
		self._unit.furnitureMap:showMapGrid(operaType, wallType)
	end
end

function M:_offsetCamera(offsetX)
	local operaType, wallType = 0, 0

	if self._selectedUnit then
		operaType = self._selectedUnit.model:getOperaType()
		wallType = self._selectedUnit.model:getWallType()
	end

	if self._unit.model:getSizeType() == HouseEnum.RoomSize.Big and (operaType == FurnitureOperaType.Floor or operaType == FurnitureOperaType.Carpet or operaType == FurnitureOperaType.Ceiling or wallType == WallType.Middle) then
		local param
		local paramCfg = HouseEnum.FurnitureOperaType2CameraParamBig

		if operaType == FurnitureOperaType.Wall then
			param = paramCfg[operaType][wallType]
		else
			param = paramCfg[operaType]
		end

		local minCamX = param.posX - kMaxCameraOffsetX
		local maxCamX = param.posX + kMaxCameraOffsetX
		local camGO = self._houseCameraUnit:getMainGO()
		local posX, posY, posZ = Astral.TransformUtil.GetPos(camGO.transform, 0, 0, 0)
		local camX, camY, camZ = self._unit:getOffsetByWorldPos(posX, posY, posZ)

		camX = math.max(math.min(camX + offsetX, maxCamX), minCamX)
		posX, posY, posZ = self._unit:getWorldPosByOffset(camX, camY, camZ)

		Astral.TransformUtil.SetPos(camGO.transform, posX, posY, posZ)
	end
end

function M:_hasPathInRoom()
	local maxX = self._unit.furnitureMap:getRoomLength()
	local endX, endY = maxX - 1, 6
	local hasPath = self._unit.furnitureMap:hasPathToCoord(endX, endY)

	return hasPath
end

function M:_endBlockOpera()
	self._blockOpera = false
end

function M:houseCameraDOKill()
	local camGO = self._houseCameraUnit:getMainGO()

	if camGO then
		DG.Tweening.DOTween.Kill(camGO.transform)
	end
end

function M:_isEdit()
	return HouseFacade.instance:isEditingFurniture() and self._unit.model:getRoomId() == HouseFurnitureModel.instance:getEditRoomId()
end

function M:_setEditEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_MULTI_DRAG, self._onMultiDrag, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OPERA_DRAG_MOVE, self._onOperaFurnitureDragMove, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OPERA_CONFIRM, self._onOperaFurnitureConfirm, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OPERA_CANCEL, self._onOperaFurnitureCancel, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OPERA_RECYCLE, self._onOperaFurnitureRecycle, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_OPERA_ROTATION, self._onOperaFurnitureRotation, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_MULTI_DRAG, self._onMultiDrag, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_OPERA_DRAG_MOVE, self._onOperaFurnitureDragMove, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_OPERA_CONFIRM, self._onOperaFurnitureConfirm, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_OPERA_CANCEL, self._onOperaFurnitureCancel, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_OPERA_RECYCLE, self._onOperaFurnitureRecycle, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_OPERA_ROTATION, self._onOperaFurnitureRotation, self)
	end
end

function M:_onSceneHit(e, isHit, hitGO, hitPoint, clickCount)
	if hitGO then
		local hitParent = hitGO.transform.parent

		if hitParent then
			local furnitureUnit = Astral.LuaComponentContainer.Get(hitParent.gameObject, HouseFurnitureUnit)

			if furnitureUnit then
				self:_onClickFurniture(furnitureUnit)
			end
		end
	end
end

function M:_onBeginDrag(e, position, pointerId)
	if self._singleDragId >= 0 then
		return
	end

	self._singleDragId = pointerId

	self._singleDragPos:Set(position:Get())
end

function M:_onDrag(e, position, pointerId)
	if self._singleDragId == pointerId then
		local dragSpeed = 0.02
		local offsetX = (self._singleDragPos.x - position.x) * dragSpeed

		self:_offsetCamera(offsetX)
		self._singleDragPos:Set(position:Get())
	end
end

function M:_onEndDrag(e, position, pointerId)
	if self._singleDragId == pointerId then
		self._singleDragId = -999
	end
end

function M:_onMultiDrag(e, centerX, centerY, scale, distance, isFirstMultiDrag)
	return
end

function M:_onClickFurniture(furnitureUnit)
	local conflictData = self:getConflictData()

	if conflictData.furnitureOverlap then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_2"))
	elseif conflictData.sealDoor then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_3"))
	elseif conflictData.forbidSingleBed then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_4"))
	elseif conflictData.forbidDoubleBed then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_5"))
	elseif conflictData.overSingleBed then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_6"))
	elseif conflictData.overDoubleBed then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_7"))
	elseif conflictData.noPath then
		FloatWordMgr.instance:show(lang("tip_edit_furniture_lang_8"))
	else
		self:setSelectedFurniture(furnitureUnit, false)
	end
end

function M:_onFurnitureEditStart()
	if self:_isEdit() then
		self:_setEditEvent(true)
		self:changeCameraByType(0)

		self._singleDragId = -999
	end
end

function M:_onFurnitureEditEnd()
	self:_setEditEvent(false)
	self._unit.furnitureMap:clearAllGridGO()
end

function M:_onOperaFurnitureDragMove(e, screenPos)
	if self._selectedUnit and not self._blockOpera then
		local layerMask = Astral.LayerUtil.GetLayerMask(SceneLayer.Stone_Value)
		local worldPos = ScenePickerViewFacade.instance:getHitPosByScreenPointWithMask(screenPos.x, screenPos.y, layerMask)

		if worldPos and (worldPos.x ~= 0 or worldPos.y ~= 0 or worldPos.z ~= 0) then
			local operaType = self._selectedUnit.model:getOperaType()
			local oldCoordX = self._selectedUnit.model:getCoordX()
			local oldCoordY = self._selectedUnit.model:getCoordY()
			local wallType = self._selectedUnit.model:getWallType()
			local coordXLen = self._selectedUnit.model:getCoordXLen()
			local coordYLen = self._selectedUnit.model:getCoordYLen()
			local furnitureId = self._selectedUnit.model:getFurnitureId()
			local newCoordX, newCoordY = self._unit.furnitureMap:getFurnitureCoordPosByWorldPos(worldPos, operaType, wallType, coordXLen, coordYLen)

			newCoordX, newCoordY = HouseSceneUtil.adjustCoordWithFix(furnitureId, newCoordX, newCoordY)

			self._selectedUnit.model:setCoordX(newCoordX)
			self._selectedUnit.model:setCoordY(newCoordY)
			self:refreshFurniturePos(self._selectedUnit)

			if oldCoordX ~= newCoordX or oldCoordY ~= newCoordY then
				HouseFurnitureModel.instance:setCanSaveFurniture(true)
			end

			self:dispatchConflict()
		end
	end
end

function M:_onOperaFurnitureConfirm()
	if self._selectedUnit then
		local conflictData = self:getConflictData()

		if conflictData.furnitureOverlap then
			FloatWordMgr.instance:show(lang("tip_furniture_conflict"))
		elseif conflictData.sealDoor then
			FloatWordMgr.instance:show(lang("tip_furniture_intercept_out"))
		elseif conflictData.forbidSingleBed then
			FloatWordMgr.instance:show(lang("tip_no_single_bed"))
		elseif conflictData.forbidDoubleBed then
			FloatWordMgr.instance:show(lang("tip_no_double_bed"))
		elseif conflictData.overSingleBed then
			FloatWordMgr.instance:show(lang("tip_single_bed_max"))
		elseif conflictData.overDoubleBed then
			FloatWordMgr.instance:show(lang("tip_double_bed_max"))
		elseif conflictData.noPath then
			FloatWordMgr.instance:show(lang("tip_room_no_path"))
		else
			self:clearSelectedFurniture()
			HouseFurnitureOpView.instance:hide()
			FloatWordMgr.instance:show(lang("tip_furniture_put_success"))
		end
	end
end

function M:_onOperaFurnitureCancel()
	if self._selectedUnit then
		if self._isSelectedNew then
			self:_onOperaFurnitureRecycle()
		else
			self._selectedUnit.model:setCoordX(self._selectedOriginCoordX)
			self._selectedUnit.model:setCoordY(self._selectedOriginCoordY)
			self._selectedUnit.model:setAngle(self._selectedOriginAngle)
			self:refreshFurniturePos(self._selectedUnit)
			self._selectedUnit.resLoader:refreshByAngle()
			self:clearSelectedFurniture()
			HouseFurnitureOpView.instance:hide()
			self:dispatchConflict()
		end
	end
end

function M:_onOperaFurnitureRecycle()
	if self._selectedUnit then
		local recycleFurnitureId = self._selectedUnit.model:getFurnitureId()
		local uuid = self._selectedUnit.model:getUUId()

		self._unit.furnitureMgr:removeFurnitureUnit(self._selectedUnit)
		self:clearSelectedFurniture()
		HouseFurnitureOpView.instance:hide()
		HouseFurnitureModel.instance:setCanSaveFurniture(true)
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_HAVE_RECYCLE, recycleFurnitureId, uuid)
		self:dispatchConflict()
	end
end

function M:_onOperaFurnitureRotation()
	if self._selectedUnit then
		local operaType = self._selectedUnit.model:getOperaType()
		local coordX = self._selectedUnit.model:getCoordX()
		local coordY = self._selectedUnit.model:getCoordY()
		local wallType = self._selectedUnit.model:getWallType()
		local coordXLen = self._selectedUnit.model:getCoordXLen()
		local coordYLen = self._selectedUnit.model:getCoordYLen()
		local furnitureId = self._selectedUnit.model:getFurnitureId()
		local newCoordX, newCoordY = coordX, coordY

		if operaType == FurnitureOperaType.Floor or operaType == FurnitureOperaType.Carpet or operaType == FurnitureOperaType.Ceiling then
			local lastAngle = self._selectedUnit.model:getAngle()
			local rotaType = self._selectedUnit.model:getRotaType()

			if rotaType == FurnitureRotaType.Null then
				return
			elseif rotaType == FurnitureRotaType.Around then
				if self._unit.furnitureMap:canRota90Deg(coordXLen, coordYLen) then
					self._selectedUnit.model:setAngle(lastAngle + 90)
				else
					self._selectedUnit.model:setAngle(lastAngle + 180)
				end

				HouseFurnitureModel.instance:setCanSaveFurniture(true)
			end

			local newCoordXLen = self._selectedUnit.model:getCoordXLen()
			local newCoordYLen = self._selectedUnit.model:getCoordYLen()

			newCoordX, newCoordY = self._unit.furnitureMap:adjustCoord(coordX, coordY, newCoordXLen, newCoordYLen, operaType, wallType)
		elseif operaType == FurnitureOperaType.Wall then
			local x = math.fmod(coordX, 100)
			local baseX = 100

			if wallType == WallType.Middle then
				baseX = 200
			elseif wallType == WallType.Left then
				baseX = 300
			end

			newCoordX = baseX + x

			local newWallType = HouseSceneUtil.CoordXMapToWallType(newCoordX)

			newCoordX, newCoordY = self._unit.furnitureMap:adjustCoord(newCoordX, coordY, coordXLen, coordYLen, operaType, newWallType)

			HouseFurnitureModel.instance:setCanSaveFurniture(true)
		end

		newCoordX, newCoordY = HouseSceneUtil.adjustCoordWithFix(furnitureId, newCoordX, newCoordY)

		self._selectedUnit.model:setCoordX(newCoordX)
		self._selectedUnit.model:setCoordY(newCoordY)
		self:refreshFurniturePos(self._selectedUnit)
		self._selectedUnit.resLoader:refreshByAngle()
		self:changeCameraBySelectedUnit()
		self:dispatchConflict()
	end
end

return M
