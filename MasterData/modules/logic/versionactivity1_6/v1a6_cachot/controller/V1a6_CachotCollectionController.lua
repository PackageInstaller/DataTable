-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotCollectionController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionController", package.seeall)

local V1a6_CachotCollectionController = class("V1a6_CachotCollectionController", BaseController)

function V1a6_CachotCollectionController:onOpenView(category, maxCollectionNumSingleLine)
	V1a6_CachotCollectionListModel.instance:onInitData(category, maxCollectionNumSingleLine)
	self:selectFirstCollection()
	V1a6_CachotCollectionController.instance:dispatchEvent(V1a6_CachotEvent.OnSwitchCategory)
end

function V1a6_CachotCollectionController:onCloseView()
	local newCollectionAndClickList = V1a6_CachotCollectionListModel.instance:getNewCollectionAndClickList()

	if newCollectionAndClickList and #newCollectionAndClickList > 0 then
		RogueRpc.instance:sendRogueCollectionNewRequest(V1a6_CachotEnum.ActivityId, newCollectionAndClickList)
	end

	V1a6_CachotCollectionListModel.instance:release()
end

function V1a6_CachotCollectionController:selectFirstCollection()
	local firstCollectionId = V1a6_CachotCollectionListModel.instance:getCurCategoryFirstCollection()

	self:onSelectCollection(firstCollectionId)
end

function V1a6_CachotCollectionController:onSelectCollection(collectionId)
	V1a6_CachotCollectionListModel.instance:markSelectCollecionId(collectionId)
	V1a6_CachotCollectionController.instance:dispatchEvent(V1a6_CachotEvent.OnSelectCollectionItem)
end

function V1a6_CachotCollectionController:onSwitchCategory(categoryType)
	local curCategory = V1a6_CachotCollectionListModel.instance:getCurCategory()

	if categoryType ~= curCategory then
		V1a6_CachotCollectionListModel.instance:resetCurPlayAnimCellIndex()
		V1a6_CachotCollectionListModel.instance:switchCategory(categoryType)
		self:selectFirstCollection()
		V1a6_CachotCollectionController.instance:dispatchEvent(V1a6_CachotEvent.OnSwitchCategory)
	end
end

V1a6_CachotCollectionController.instance = V1a6_CachotCollectionController.New()

LuaEventSystem.addEventMechanism(V1a6_CachotCollectionController.instance)

return V1a6_CachotCollectionController
