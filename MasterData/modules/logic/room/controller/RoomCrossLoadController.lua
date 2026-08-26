-- chunkname: @modules/logic/room/controller/RoomCrossLoadController.lua

module("modules.logic.room.controller.RoomCrossLoadController", package.seeall)

local RoomCrossLoadController = class("RoomCrossLoadController", BaseController)

function RoomCrossLoadController:onInit()
	self._lastUpdatePathGraphicTimeDic = {}

	self:clear()
end

function RoomCrossLoadController:reInit()
	self:clear()
end

function RoomCrossLoadController:clear()
	return
end

function RoomCrossLoadController:findDirectionPathList(enterDire, exitDire)
	self._directionPathDic = self._directionPathDic or {}
	self._directionPathDic[enterDire] = self._directionPathDic[enterDire] or {}

	if not self._directionPathDic[enterDire][exitDire] then
		local tempList = {
			enterDire
		}

		self._directionPathDic[enterDire][exitDire] = tempList

		if enterDire ~= exitDire then
			table.insert(tempList, exitDire)
		end

		if math.abs(enterDire - exitDire) > 1 and not tabletool.indexOf(tempList, 0) then
			table.insert(tempList, 0)
		end
	end

	return self._directionPathDic[enterDire][exitDire]
end

function RoomCrossLoadController:isEnterBuilingCrossLoad(x, y, enterDire, exitDire)
	local param = RoomMapBuildingModel.instance:getBuildingParam(x, y)

	if param and param.isCrossload and param.replacResPoins then
		local replacResPoins = param.replacResPoins
		local directionList = self:findDirectionPathList(enterDire, exitDire)

		for _resid, replaceBlockRes in pairs(replacResPoins) do
			for _, dire in ipairs(directionList) do
				local dirIndex = RoomRotateHelper.rotateDirection(dire, -param.blockRotate)

				if replaceBlockRes[dirIndex] then
					return true, param.buildingUid
				end
			end
		end
	end

	return false
end

function RoomCrossLoadController:crossload(buildingUid, resId)
	local scene = GameSceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local entity = scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if entity and entity.crossloadComp then
		entity.crossloadComp:playAnim(resId)

		return entity.crossloadComp:getCurResId(), entity.crossloadComp:getCanMove()
	end

	return resId
end

function RoomCrossLoadController:getUpateGraphicTime(buildingUid)
	return self._lastUpdatePathGraphicTimeDic[buildingUid] or 0
end

function RoomCrossLoadController:updatePathGraphic(buildingUid)
	local scene = GameSceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local entity = scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if not entity then
		return
	end

	local buildingMO = entity:getMO()

	if not buildingMO then
		return
	end

	self._lastUpdatePathGraphicTimeDic[buildingUid] = Time.time

	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate, buildingMO.buildingUid)

	for x, dict in pairs(occupyDict) do
		for y, param in pairs(dict) do
			local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)
			local blockEntity = scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

			if blockEntity then
				scene.path:updatePathGraphic(blockEntity.go)
			end
		end
	end

	scene.path:updatePathGraphic(entity:getBuildingGO())
end

function RoomCrossLoadController:_closeGraphic(go)
	if not gohelper.isNil(go) then
		local colliders = ZProj.AStarPathBridge.FindChildrenByName(go, "#collider")
		local list = {}

		ZProj.AStarPathBridge.ArrayToLuaTable(colliders, list)

		for _, goColliderRoot in ipairs(list) do
			gohelper.setActive(goColliderRoot, false)
		end
	end
end

function RoomCrossLoadController:isLock()
	return ViewMgr.instance:hasOpenFullView()
end

RoomCrossLoadController.instance = RoomCrossLoadController.New()

return RoomCrossLoadController
