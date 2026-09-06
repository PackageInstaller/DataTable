-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/controller/TRPopMenuController.lua

module("logic.extensions.treasureraider.controller.TRPopMenuController", package.seeall)

local TRPopMenuController = class("TRPopMenuController", BaseController)

TRPopMenuController.Op_View = 1
TRPopMenuController.Op_Construct = 2
TRPopMenuController.Op_Upgrade = 3
TRPopMenuController.Op_Reconstruct = 4
TRPopMenuController.Op_Attack = 5
TRPopMenuController.Op_GetResource = 6
TRPopMenuController.OpNames = {
	[TRPopMenuController.Op_View] = lang("查看"),
	[TRPopMenuController.Op_Construct] = lang("部署"),
	[TRPopMenuController.Op_Upgrade] = lang("升级"),
	[TRPopMenuController.Op_Reconstruct] = lang("改建"),
	[TRPopMenuController.Op_Attack] = lang("入侵"),
	[TRPopMenuController.Op_GetResource] = lang("收获")
}
TRPopMenuController.OpFuncs = {
	[TRPopMenuController.Op_View] = "_handleView",
	[TRPopMenuController.Op_Construct] = "_handleConstruct",
	[TRPopMenuController.Op_Upgrade] = "_handleUpgrade",
	[TRPopMenuController.Op_Reconstruct] = "_handleReconstruct",
	[TRPopMenuController.Op_Attack] = "_handleAttack",
	[TRPopMenuController.Op_GetResource] = "_handleRichManResourcePrize"
}

function TRPopMenuController:ctor()
	return
end

function TRPopMenuController:onInit()
	self:onReset()
end

function TRPopMenuController:onReset()
	self._lastOpGridX = nil
	self._lastOpGridY = nil
end

function TRPopMenuController:setOpViewShowing(gridX, gridY)
	self._lastOpGridX = gridX
	self._lastOpGridY = gridY
end

function TRPopMenuController:isOpViewShowing(gridX, gridY)
	return gridX == self._lastOpGridX and gridY == self._lastOpGridY
end

function TRPopMenuController:preOpHandler(posX, posY, gridX, gridY, id)
	local tool = TreasureRaiderSceneModel.instance

	if tool:isBuildingSlot(id) then
		local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
		local myPlayerMo = sceneMo.myPlayerMo

		if myPlayerMo:isClientServerSameGrid() then
			local bHasBuilding = sceneMo:isHasBuildingMo(id)

			if sceneMo:isMyScene() and bHasBuilding then
				local buildingMo = sceneMo:getBuildingMo(id)

				if buildingMo:getProduceCount() > 0 then
					self:handle(TRPopMenuController.Op_GetResource, posX, posY, gridX, gridY, id)

					return true
				end
			end
		end
	end

	return false
end

function TRPopMenuController:getOpGroups(posX, posY, gridX, gridY, id)
	local tool = TreasureRaiderSceneModel.instance
	local result = {}

	if tool:isBuildingSlot(id) then
		local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
		local myPlayerMo = sceneMo.myPlayerMo

		if myPlayerMo:isClientServerSameGrid() then
			local bClosest = tool:isClosestByGridId(id, myPlayerMo.serverGridId)
			local bHasBuilding = sceneMo:isHasBuildingMo(id)
			local actionDone = sceneMo.actionDone

			if sceneMo:isMyScene() then
				if not actionDone and bClosest then
					if bHasBuilding then
						local buildingMo = sceneMo:getBuildingMo(id)
						local buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(buildingMo.buildingId)
						local bCanUpgrade = tool:isBuildingCanUpgrade(buildingMo)
						local bCanReconstruct = TreasureRaiderConst.BuildingCanReconstructMap[buildingConfig.type]

						if bCanUpgrade then
							table.insert(result, TRPopMenuController.Op_Upgrade)
						end

						if bCanReconstruct then
							table.insert(result, TRPopMenuController.Op_Reconstruct)
						end

						if TreasureRaiderConst.BuildingClosestCanViewDescMap[buildingConfig.type] then
							table.insert(result, TRPopMenuController.Op_View)
						end
					else
						table.insert(result, TRPopMenuController.Op_Construct)
					end
				elseif bHasBuilding then
					table.insert(result, TRPopMenuController.Op_View)
				end
			elseif not actionDone and bClosest and bHasBuilding then
				local buildingMo = sceneMo:getBuildingMo(id)
				local buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(buildingMo.buildingId)

				if TreasureRaiderConst.BuildingCanBeAttackMap[buildingConfig.type] then
					table.insert(result, TRPopMenuController.Op_Attack)
				else
					table.insert(result, TRPopMenuController.Op_View)
				end
			else
				table.insert(result, TRPopMenuController.Op_View)
			end
		end
	end

	return result
end

function TRPopMenuController:handle(opType, posX, posY, gridX, gridY, id)
	local funcName = TRPopMenuController.OpFuncs[opType]
	local func = self[funcName]
	local activityId = TreasureRaiderConfig.instance:getActivityId()
	local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
	local buildingMo = sceneMo:getBuildingMo(id)
	local params = {
		posX = posX,
		posY = posY,
		gridX = gridX,
		gridY = gridY,
		id = id,
		activityId = activityId,
		buildingMo = buildingMo,
		sceneMo = sceneMo
	}

	func(self, opType, params)
end

function TRPopMenuController:_handleView(opType, params)
	if params.buildingMo then
		local config = TreasureRaiderConfig.instance:getBuildingConfig(params.buildingMo.buildingId)

		if config then
			local isMyScene = params.sceneMo:isMyScene()
			local viewName = TreasureRaiderConst.getBuildingViewName(config.type, isMyScene)

			params.isViewBuilding = true

			UIStateManager.instance:push(viewName, params)
		end
	end
end

function TRPopMenuController:_handleConstruct(opType, params)
	UIStateManager.instance:push(ViewName.TreasureraidecontructView, params)
end

function TRPopMenuController:_handleUpgrade(opType, params)
	UIStateManager.instance:push(ViewName.TreasureraideupgradeView, params)
end

function TRPopMenuController:_handleReconstruct(opType, params)
	UIStateManager.instance:push(ViewName.TreasureraidecontructView, params)
end

function TRPopMenuController:_handleAttack(opType, params)
	UIStateManager.instance:push(ViewName.TreasureraideattackView, params)
end

function TRPopMenuController:_handleRichManResourcePrize(opType, params)
	local activityId = TreasureRaiderConfig.instance:getActivityId()

	RichManAgent.instance:sendPM_RichManResourcePrizeReq(activityId)
end

TRPopMenuController.instance = TRPopMenuController.New()

return TRPopMenuController
