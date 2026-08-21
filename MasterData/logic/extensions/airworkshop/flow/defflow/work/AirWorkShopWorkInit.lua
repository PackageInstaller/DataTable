-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkInit.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkInit", package.seeall)

local M = class("AirWorkShopWorkInit", WorkBase)

function M:onEnter(context)
	local mapMO = context.model:getModiedMapMO()

	AirWorkShopDefSceneUtil.placeAllHeroAndBuildings(mapMO)
	AirWorkShopDefSceneUtil.placeAllBornPos(mapMO)
	AirWorkShopDefSceneUtil.placeAllLeavePos(mapMO)

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local rotation = virtualCamera:getRotation()
	local levelCO = BattleConfig.instance:getBattleLevelCO(context.model:getLevelCode())

	rotation.y = rotation.y - levelCO.initRotationOffSet

	context.model:recordCameraRotation(rotation.y)
	virtualCamera:setRotation(rotation.x, rotation.y, rotation.z)

	local cameraUnionIndex = 0
	local bornMOs = mapMO:getBorns()

	if #bornMOs > 0 then
		local bornCellNO = bornMOs[1]:getBornCell()

		cameraUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(bornCellNO.cell.x, bornCellNO.cell.z)
	end

	local position = context.boardMgr:getCellPosition(cameraUnionIndex)

	VirtualCameraMgr.instance:setFollowPosition(position.x, position.y, position.z)
	AirWorkShopDefOperateUtil.updateUnitVisible()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
