-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotCollectionEnchantController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionEnchantController", package.seeall)

local V1a6_CachotCollectionEnchantController = class("V1a6_CachotCollectionEnchantController", BaseController)
local defaultSelectCollectionIndex = 1

function V1a6_CachotCollectionEnchantController:onOpenView(selectCollectionId)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, self.onUpdateBagCollectionInfo, self)
	self:onInit(selectCollectionId, V1a6_CachotEnum.CollectionHole.Left, true)
end

function V1a6_CachotCollectionEnchantController:onCloseView()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, self.onUpdateBagCollectionInfo, self)
	V1a6_CachotEnchantBagListModel.instance:reInit()
	V1a6_CachotCollectionEnchantListModel.instance:reInit()
end

function V1a6_CachotCollectionEnchantController:onInit(selectCollectionId, holeIndex, isExcuteEnchantSort)
	V1a6_CachotEnchantBagListModel.instance:onInitData()
	V1a6_CachotCollectionEnchantListModel.instance:onInitData(isExcuteEnchantSort)

	local collectionMO = V1a6_CachotEnchantBagListModel.instance:getById(selectCollectionId)

	if collectionMO then
		::label_3_0::

		local collectionSelectIndex = V1a6_CachotEnchantBagListModel.instance:getIndex(collectionMO)

		self:onSelectBagItem(collectionSelectIndex, holeIndex)
	end
end

function V1a6_CachotCollectionEnchantController:onUpdateBagCollectionInfo()
	local curSelectCollectionId = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()
	local curSelectHoleIndex = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()

	self:onInit(curSelectCollectionId, curSelectHoleIndex, false)
end

function V1a6_CachotCollectionEnchantController:onSelectBagItem(selectCell, holeType)
	local enchantId
	local collectionMO = V1a6_CachotEnchantBagListModel.instance:getByIndex(selectCell)

	if collectionMO then
		local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionMO.cfgId)

		if not collectionCfg or collectionCfg.type == V1a6_CachotEnum.CollectionType.Enchant or collectionCfg.holeNum <= 0 then
			ToastController.instance:showToast(ToastEnum.V1a6Cachot_Unable2Enchant)

			return
		end
	else
		return
	end

	holeType = holeType or V1a6_CachotEnum.CollectionHole.Left

	V1a6_CachotEnchantBagListModel.instance:selectCell(collectionMO.id, true)
	V1a6_CachotEnchantBagListModel.instance:markCurSelectHoleIndex(holeType)
	self:onSelectEnchantItem((collectionMO:getEnchantId(holeType)))
	self:notifyViewUpdate()
end

function V1a6_CachotCollectionEnchantController:onSelectEnchantItem(selectEnchantId, isForceEnchant)
	V1a6_CachotCollectionEnchantListModel.instance:selectCell(selectEnchantId, true)

	if isForceEnchant then
		local curSelectCollectionId = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()
		local curSelectHoleIndex = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()
		local curSelectCollectionMO = V1a6_CachotEnchantBagListModel.instance:getById(curSelectCollectionId)
		local curHoleEnchantId = curSelectCollectionMO and curSelectCollectionMO:getEnchantId(curSelectHoleIndex)
		local targetEnchantId = curHoleEnchantId ~= selectEnchantId and selectEnchantId or V1a6_CachotEnum.EmptyEnchantId

		self:trySendRogueCollectionEnchantRequest(curSelectCollectionId, targetEnchantId, curSelectHoleIndex)
	end
end

function V1a6_CachotCollectionEnchantController:trySendRogueCollectionEnchantRequest(curSelectCollectionId, curSelectEnchantId, curSelectHoleIndex)
	if curSelectCollectionId == nil then
		return
	end

	curSelectEnchantId = curSelectEnchantId or V1a6_CachotEnum.EmptyEnchantId

	local originCollectionId = self:tryRemoveEnchant(curSelectEnchantId)
	local isEnchantSucc = self:tryEnchant2EmptyHole(curSelectCollectionId, curSelectEnchantId, curSelectHoleIndex)

	if isEnchantSucc and originCollectionId and originCollectionId ~= curSelectCollectionId then
		ToastController.instance:showToast(ToastEnum.V1a6Cachot_HasEnchant)
	end
end

function V1a6_CachotCollectionEnchantController:tryRemoveEnchant(enchantId)
	local enchantMO = V1a6_CachotCollectionEnchantListModel.instance:getById(enchantId)
	local collectionId = enchantMO and enchantMO.enchantUid
	local collectionMO = V1a6_CachotEnchantBagListModel.instance:getById(collectionId)

	if collectionMO then
		local leftEnchantId = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
		local rightEnchantId = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)

		if enchantId == leftEnchantId then
			if not V1a6_CachotEnum.EmptyEnchantId then
				local targetLeftEnchantId = leftEnchantId

				if enchantId == rightEnchantId then
					if not V1a6_CachotEnum.EmptyEnchantId then
						local targetRightEnchantId = rightEnchantId

						RogueRpc.instance:sendRogueCollectionEnchantRequest(V1a6_CachotEnum.ActivityId, collectionId, targetLeftEnchantId, targetRightEnchantId)

						return collectionId
					end
				end
			end
		end
	end
end

function V1a6_CachotCollectionEnchantController:tryEnchant2EmptyHole(curSelectCollectionId, curSelectEnchantId, curSelectHoleIndex)
	local collectionMO = V1a6_CachotEnchantBagListModel.instance:getById(curSelectCollectionId)

	if collectionMO then
		local leftEnchantId = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
		local rightEnchantId = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)
		local nextLeftEnchantId = curSelectHoleIndex == V1a6_CachotEnum.CollectionHole.Left and curSelectEnchantId or leftEnchantId
		local nextRightEnchantId = curSelectHoleIndex == V1a6_CachotEnum.CollectionHole.Right and curSelectEnchantId or rightEnchantId

		if nextLeftEnchantId == nextRightEnchantId then
			nextLeftEnchantId = curSelectHoleIndex == V1a6_CachotEnum.CollectionHole.Left and nextLeftEnchantId or V1a6_CachotEnum.EmptyEnchantId
			nextRightEnchantId = curSelectHoleIndex == V1a6_CachotEnum.CollectionHole.Right and nextRightEnchantId or V1a6_CachotEnum.EmptyEnchantId
		end

		RogueRpc.instance:sendRogueCollectionEnchantRequest(V1a6_CachotEnum.ActivityId, curSelectCollectionId, nextLeftEnchantId, nextRightEnchantId)

		return true
	end
end

function V1a6_CachotCollectionEnchantController:onSelectHoleGrid(curSelectHoleIndex, isCouldRemoveEnchant)
	V1a6_CachotEnchantBagListModel.instance:markCurSelectHoleIndex(curSelectHoleIndex)

	if not isCouldRemoveEnchant then
		return
	end

	local curSelectCollectionId = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()
	local collectionMO = V1a6_CachotEnchantBagListModel.instance:getById(curSelectCollectionId)
	local enchantId = collectionMO and collectionMO:getEnchantId(curSelectHoleIndex)

	if enchantId and enchantId ~= V1a6_CachotEnum.EmptyEnchantId then
		self:trySendRogueCollectionEnchantRequest(curSelectCollectionId, V1a6_CachotEnum.EmptyEnchantId, curSelectHoleIndex)
	end
end

function V1a6_CachotCollectionEnchantController:switchCategory(category)
	local curSelectCategory = V1a6_CachotEnchantBagListModel.instance:getCurSelectCategory()

	if category ~= curSelectCategory then
		V1a6_CachotEnchantBagListModel.instance:switchCategory(category)
		self:onSelectBagItem(defaultSelectCollectionIndex)
	end
end

function V1a6_CachotCollectionEnchantController:notifyViewUpdate()
	local curSelectCollectionId = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()

	V1a6_CachotCollectionEnchantController.instance:dispatchEvent(V1a6_CachotEvent.OnSelectEnchantCollection, curSelectCollectionId)
end

V1a6_CachotCollectionEnchantController.instance = V1a6_CachotCollectionEnchantController.New()

LuaEventSystem.addEventMechanism(V1a6_CachotCollectionEnchantController.instance)

return V1a6_CachotCollectionEnchantController
