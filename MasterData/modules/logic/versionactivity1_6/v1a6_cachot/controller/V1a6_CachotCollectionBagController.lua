-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotCollectionBagController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionBagController", package.seeall)

local V1a6_CachotCollectionBagController = class("V1a6_CachotCollectionBagController", BaseController)
local defaultSelectCollectionIndex = 1

function V1a6_CachotCollectionBagController:onOpenView()
	V1a6_CachotCollectionEnchantController.instance:registerCallback(V1a6_CachotEvent.OnSelectEnchantCollection, self.onEnchantViewSelectCollection, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, self.onCollectionDataUpdate, self)
	V1a6_CachotCollectionBagListModel.instance:onInitData()
	self:onSelectBagItemByIndex(defaultSelectCollectionIndex)
end

function V1a6_CachotCollectionBagController:onCloseView()
	V1a6_CachotCollectionEnchantController.instance:unregisterCallback(V1a6_CachotEvent.OnSelectEnchantCollection, self.onEnchantViewSelectCollection, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, self.onCollectionDataUpdate, self)
end

function V1a6_CachotCollectionBagController:onCollectionDataUpdate()
	V1a6_CachotCollectionBagListModel.instance:onCollectionDataUpdate()
	self:notifyViewUpdate()
end

function V1a6_CachotCollectionBagController:onSelectBagItemByIndex(selectCellIndex)
	V1a6_CachotCollectionBagListModel.instance:selectCell(selectCellIndex, true)

	local selectCellMO = V1a6_CachotCollectionBagListModel.instance:getByIndex(selectCellIndex)
	local selectCellId = selectCellMO and selectCellMO.id

	self:notifyViewUpdate(selectCellId)
end

function V1a6_CachotCollectionBagController:onSelectBagItemById(selectCellId)
	local selectCellMO = V1a6_CachotCollectionBagListModel.instance:getById(selectCellId)
	local selectCellIndex = V1a6_CachotCollectionBagListModel.instance:getIndex(selectCellMO)

	V1a6_CachotCollectionBagListModel.instance:selectCell(selectCellIndex, true)
	self:notifyViewUpdate(selectCellId)
end

function V1a6_CachotCollectionBagController:onEnchantViewSelectCollection(selectCellId)
	self:onSelectBagItemById(selectCellId)
end

function V1a6_CachotCollectionBagController:notifyViewUpdate(selectCellId)
	self:dispatchEvent(V1a6_CachotEvent.OnSelectBagCollection, selectCellId)
end

function V1a6_CachotCollectionBagController:moveCollectionWithHole2TopAndSelect()
	local isMoveSucc = V1a6_CachotCollectionBagListModel.instance:moveCollectionWithHole2Top()

	if isMoveSucc then
		self:onSelectBagItemByIndex(defaultSelectCollectionIndex)
	end

	return isMoveSucc
end

V1a6_CachotCollectionBagController.instance = V1a6_CachotCollectionBagController.New()

LuaEventSystem.addEventMechanism(V1a6_CachotCollectionBagController.instance)

return V1a6_CachotCollectionBagController
