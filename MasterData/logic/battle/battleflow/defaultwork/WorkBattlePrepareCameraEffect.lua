-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattlePrepareCameraEffect.lua

module("logic.battle.battleflow.defaultwork.WorkBattlePrepareCameraEffect", package.seeall)

local M = class("WorkBattlePrepareCameraEffect", WorkBase)
local kCameraCode = BattleConst.START_CAMERA_CODE

function M:onEnter(context)
	local settingModel = context.settingModel
	local walkUnionIndexList = settingModel:getCameraWalkUnionIndexList()
	local bornUnionIndexList = settingModel:getBornUnionIndexList()
	local boardMgr = context.boardMgr

	VirtualCameraMgr.instance:setBlendDuration(0)
	VirtualCameraMgr.instance:setTemporaryCameraActive(kCameraCode, true)

	local bestFocusBornUnionIndex = self:_findBestBornUnionIndex(bornUnionIndexList)
	local firstFocusIndex = walkUnionIndexList[1] or bestFocusBornUnionIndex
	local lastFocusIndex = bestFocusBornUnionIndex or walkUnionIndexList[1]

	if not firstFocusIndex then
		firstFocusIndex = self:_getDefaultFocusUnitUnionIndex()
		lastFocusIndex = firstFocusIndex
	end

	BattleCampAdjustmentModel.instance:setDefaultFocusUnionIndex(lastFocusIndex)

	local position = boardMgr:getCellPosition(firstFocusIndex)

	VirtualCameraMgr.instance:setFollowPosition(position.x, position.y, position.z)
	self:_initCameraRotation(context)
	self:onDone(WorkResult.Succeed)
end

function M:_initCameraRotation(context)
	local flow = BattleMgr.instance:getActiveBattleFlow()
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local rotation = virtualCamera:getRotation()

	if OOPUtil.isInstanceOf(flow, LevelBattleFlowBase) then
		local levelCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(flow:getBattleLevelCode())
		local levelCO = levelCOWrapper:getDungeonBattleInfoCO()

		rotation.y = rotation.y - levelCO.initRotationOffSet

		context.model:recordCameraRotation(rotation.y)
		virtualCamera:setRotation(rotation.x, rotation.y, rotation.z)

		virtualCamera = VirtualCameraMgr.instance:getTemporaryCamera(kCameraCode)
		rotation = virtualCamera:getRotation()
		rotation.y = rotation.y - levelCO.initRotationOffSet

		virtualCamera:setRotation(rotation.x, rotation.y, rotation.z)
	else
		context.model:recordCameraRotation(rotation.y)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_CAMERA_ROTATION_UPDATE, 0)
end

function M:onExit(isInterrupt)
	return
end

function M:_findBestBornUnionIndex(bornUnionIndexList)
	if #bornUnionIndexList <= 0 then
		return
	end

	local bordModel = self.context.boardModel

	for _, unionIndex in ipairs(bornUnionIndexList) do
		local cellMO = bordModel:getBoardCellMO(unionIndex)

		if cellMO:hasOwner() then
			return unionIndex
		end
	end

	return bornUnionIndexList[1]
end

function M:_getDefaultFocusUnitUnionIndex()
	local unitMgr = self.context.unitMgr
	local model = self.context.model
	local units = unitMgr:getUnitsByCampId(model:getOperateCampId())

	for _, unit in pairs(units) do
		return BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	end

	return false
end

return M
