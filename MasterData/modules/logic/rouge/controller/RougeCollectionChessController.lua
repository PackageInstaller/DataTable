-- chunkname: @modules/logic/rouge/controller/RougeCollectionChessController.lua

module("modules.logic.rouge.controller.RougeCollectionChessController", package.seeall)

local RougeCollectionChessController = class("RougeCollectionChessController", BaseController)

function RougeCollectionChessController:onInit()
	return
end

function RougeCollectionChessController:reInit()
	self:clear()
end

function RougeCollectionChessController:onOpen()
	RougeCollectionBagListModel.instance:onInitData()
end

function RougeCollectionChessController:placeCollection2SlotArea(collectionId, leftTopPos, rotation)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local originLeftTopPos = collectionMO:getLeftTopPos()

	if originLeftTopPos.x ~= leftTopPos.x or originLeftTopPos.y ~= leftTopPos.y then
		RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
	else
		local getRotation = collectionMO:getRotation()

		if rotation and rotation ~= getRotation then
			RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
		end
	end

	RougeRpc.instance:sendRougeAddToBarRequest(collectionId, leftTopPos, rotation)
end

function RougeCollectionChessController:removeCollectionFromSlotArea(collectionId)
	local isPlaceInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInBag(collectionId)

	if isPlaceInSlotArea then
		return
	end

	RougeRpc.instance:sendRougeRemoveFromBarRequest(collectionId)
end

function RougeCollectionChessController:rotateCollection(collectionMO, rotation)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO.id
	local collectionCfgId = collectionMO.cfgId
	local centerSlotPos = collectionMO:getCenterSlotPos()
	local topLeftPos = RougeCollectionHelper.getCollectionTopLeftSlotPos(collectionCfgId, centerSlotPos, rotation)

	RougeRpc.instance:sendRougeAddToBarRequest(collectionId, topLeftPos, rotation)
end

function RougeCollectionChessController:onKeyPlaceCollection2SlotArea()
	local season = RougeModel.instance:getSeason()
	local bagCollectionCount = RougeCollectionModel.instance:getBagAreaCollectionCount()

	if season and bagCollectionCount > 0 then
		RougeRpc.instance:sendRougeOneKeyAddToBarRequest(season)
	end
end

function RougeCollectionChessController:onKeyClearCollectionSlotArea()
	local season = RougeModel.instance:getSeason()
	local slotCollectionCount = RougeCollectionModel.instance:getSlotAreaCollectionCount()

	if season and slotCollectionCount > 0 then
		local slotCollections = RougeCollectionModel.instance:getSlotAreaCollection()
		local canRemoveCollections = {}
		local unRemoveCollectionCfgIds = {}

		for i = #slotCollections, 1, -1 do
			local collectionMo = slotCollections[i]
			local collectionCfgId = collectionMo and collectionMo.cfgId
			local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

			if collectionCfg and not collectionCfg.unremovable then
				table.insert(canRemoveCollections, collectionMo.id)
			else
				table.insert(unRemoveCollectionCfgIds, collectionMo.cfgId)
			end
		end

		if slotCollectionCount > #canRemoveCollections then
			for i = #canRemoveCollections, 1, -1 do
				RougeCollectionChessController.instance:removeCollectionFromSlotArea(canRemoveCollections[i])
			end

			for _, collectionCfgId in ipairs(unRemoveCollectionCfgIds) do
				local collectionName = RougeCollectionConfig.instance:getCollectionName(collectionCfgId)

				GameFacade.showToast(ToastEnum.RougeUnRemovableCollection, collectionName)
			end
		else
			RougeRpc.instance:sendRougeOneKeyRemoveFromBarRequest(season)
		end
	end
end

function RougeCollectionChessController:autoPlaceCollection2SlotArea(collectionId)
	local collection = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collection then
		return
	end

	local topLeftPos = Vector2(-1, -1)
	local rotation = 0

	RougeRpc.instance:sendRougeAddToBarRequest(collectionId, topLeftPos, rotation)
end

function RougeCollectionChessController:try2OpenCollectionTipView(collectionId, viewParam)
	if not collectionId or collectionId <= 0 then
		return
	end

	RougeController.instance:openRougeCollectionTipView(viewParam)
end

function RougeCollectionChessController:closeCollectionTipView()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function RougeCollectionChessController:selectCollection(collectionId)
	RougeCollectionBagListModel.instance:markCurSelectCollectionId(collectionId)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SelectCollection)

	if not collectionId or collectionId <= 0 then
		self:closeCollectionTipView()
	end
end

function RougeCollectionChessController:deselectCollection()
	self:selectCollection(nil)
end

RougeCollectionChessController.instance = RougeCollectionChessController.New()

LuaEventSystem.addEventMechanism(RougeCollectionChessController.instance)

return RougeCollectionChessController
