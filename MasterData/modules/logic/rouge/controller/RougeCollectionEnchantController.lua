-- chunkname: @modules/logic/rouge/controller/RougeCollectionEnchantController.lua

module("modules.logic.rouge.controller.RougeCollectionEnchantController", package.seeall)

local RougeCollectionEnchantController = class("RougeCollectionEnchantController", BaseController)
local defaultSelectHoleIndex = 1

function RougeCollectionEnchantController:onOpenView(selectCollectionId, collectionIds, selectHoleIndex)
	self:onInit(selectCollectionId, collectionIds, selectHoleIndex, true)
end

function RougeCollectionEnchantController:onCloseView()
	RougeCollectionUnEnchantListModel.instance:reInit()
	RougeCollectionEnchantListModel.instance:reInit()
end

function RougeCollectionEnchantController:onInit(selectCollectionId, collectionIds, holeIndex, isExcuteEnchantSort)
	RougeCollectionUnEnchantListModel.instance:onInitData(collectionIds)
	RougeCollectionEnchantListModel.instance:onInitData(isExcuteEnchantSort)

	local collectionMO = RougeCollectionUnEnchantListModel.instance:getById(selectCollectionId)

	if collectionMO then
		::label_3_0::

		local collectionSelectIndex = RougeCollectionUnEnchantListModel.instance:getIndex(collectionMO)

		self:onSelectBagItem(collectionSelectIndex, holeIndex)
	end
end

function RougeCollectionEnchantController:onSelectBagItem(selectCell, holeIndex)
	local enchantId
	local collectionMO = RougeCollectionUnEnchantListModel.instance:getByIndex(selectCell)

	if not collectionMO then
		return
	end

	holeIndex = holeIndex or defaultSelectHoleIndex

	RougeCollectionUnEnchantListModel.instance:markCurSelectHoleIndex(holeIndex)
	RougeCollectionUnEnchantListModel.instance:switchSelectCollection(collectionMO.id)
	self:onSelectEnchantItem(collectionMO.id, collectionMO:getEnchantIdAndCfgId(holeIndex), holeIndex)
end

function RougeCollectionEnchantController:onSelectEnchantItem(collectionId, enchantId, holeIndex)
	enchantId = enchantId or 0
	holeIndex = holeIndex or 0

	if not collectionId or enchantId <= 0 or holeIndex <= 0 then
		RougeCollectionEnchantListModel.instance:selectCell(nil, false)
		RougeCollectionEnchantController.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, collectionId)

		return
	end

	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)
	local originEnchantId = collectionMO and collectionMO:getEnchantIdAndCfgId(holeIndex)

	if originEnchantId ~= enchantId then
		self:trySendRogueCollectionEnchantRequest(collectionId, enchantId, holeIndex)
	else
		local lastSelectEnchantId = RougeCollectionEnchantListModel.instance:getCurSelectEnchantId()

		if lastSelectEnchantId ~= enchantId then
			RougeCollectionEnchantListModel.instance:selectCell(enchantId, true)
			RougeCollectionEnchantController.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, collectionId)
		end
	end
end

function RougeCollectionEnchantController:trySendRogueCollectionEnchantRequest(collectionId, enchantId, holeIndex)
	if not collectionId or not enchantId or not holeIndex then
		return
	end

	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该造物,造物uid = " .. tostring(collectionMO.id))

		return
	end

	if enchantId ~= RougeEnum.EmptyEnchantId then
		local enchantMO = RougeCollectionModel.instance:getCollectionByUid(enchantId)

		enchantMO = enchantMO or RougeCollectionEnchantListModel.instance:getById(enchantId)

		if not enchantMO then
			logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该附魔软盘,软盘uid = " .. tostring(enchantId))

			return
		end
	end

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionMO.cfgId)

	if not collectionCfg.holeNum then
		if collectionCfg.holeNum <= 0 then
			return
		end

		if collectionCfg.holeNum < holeIndex then
			logError(string.format("尝试将新的造物附魔数据发送给后端失败,失败原因:准备对序号为%s的孔位进行附魔操作,但是配置表中配置的孔位数量小于该序号,软盘uid = %s, 配置id = %s,孔位数量 = %s", holeIndex, collectionMO.id, collectionMO.cfgId, collectionCfg.holeNum))

			return
		end

		RougeRpc.instance:sendRougeInlayRequest(collectionId, enchantId, holeIndex)
	end
end

function RougeCollectionEnchantController:trySendRemoveCollectionEnchantRequest(collectionId, holeIndex)
	if not collectionId or not holeIndex then
		return
	end

	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该造物,造物uid = " .. tostring(collectionId))

		return
	end

	local enchantId = collectionMO:getEnchantIdAndCfgId(holeIndex)

	if not enchantId or enchantId <= 0 then
		return
	end

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionMO.cfgId)

	if not collectionCfg.holeNum then
		if collectionCfg.holeNum < holeIndex then
			logError(string.format("尝试将新的造物附魔数据发送给后端失败,失败原因:准备对序号为%s的孔位进行附魔操作,但是配置表中配置的孔位数量小于该序号,软盘uid = %s, 配置id = %s,孔位数量 = %s", holeIndex, collectionMO.id, collectionMO.cfgId, collectionCfg.holeNum))

			return
		end

		RougeRpc.instance:sendRougeDemountRequest(collectionId, holeIndex)
	end
end

function RougeCollectionEnchantController:onSelectHoleGrid(newSelectHoleIndex)
	RougeCollectionUnEnchantListModel.instance:markCurSelectHoleIndex(newSelectHoleIndex)

	local curSelectCollectionId = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	if curSelectCollectionId then
		local collectionMO = RougeCollectionUnEnchantListModel.instance:getById(curSelectCollectionId)
		local enchantId = collectionMO and collectionMO:getEnchantIdAndCfgId(newSelectHoleIndex)

		self:onSelectEnchantItem(curSelectCollectionId, enchantId, newSelectHoleIndex)
	end
end

function RougeCollectionEnchantController:switchCollection(isNext)
	local curSelectCollectionIndex = RougeCollectionUnEnchantListModel.instance:getCurSelectIndex()
	local totalCollectionCount = RougeCollectionUnEnchantListModel.instance:getCount()
	local nextSelectIndex = isNext and Mathf.Clamp(curSelectCollectionIndex + 1, 1, totalCollectionCount) or Mathf.Clamp(curSelectCollectionIndex - 1, 1, totalCollectionCount)

	if nextSelectIndex ~= curSelectCollectionIndex then
		local nextSelectCollectionMO = RougeCollectionUnEnchantListModel.instance:getByIndex(nextSelectIndex)

		if nextSelectCollectionMO then
			RougeCollectionEnchantListModel.instance:executeSortFunc()
			self:onSelectBagItem(nextSelectIndex, defaultSelectHoleIndex)
		end
	end
end

function RougeCollectionEnchantController:removeEnchant(collectionId, holeIndex)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)
	local originEnchantId = collectionMO and collectionMO:getEnchantIdAndCfgId(holeIndex)

	if originEnchantId and originEnchantId > 0 then
		RougeCollectionEnchantListModel.instance:selectCell(originEnchantId, false)
	end

	self:trySendRemoveCollectionEnchantRequest(collectionId, holeIndex)
end

function RougeCollectionEnchantController:onRougeInlayInfoUpdate(collectionId, preCollectionId)
	local curSelectCollection = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	if curSelectCollection == collectionId then
		local curSelectHoleIndex = RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()
		local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)
		local enchantId = collectionMO:getEnchantIdAndCfgId(curSelectHoleIndex)

		RougeCollectionEnchantListModel.instance:selectCell(enchantId, true)
	end

	if preCollectionId and preCollectionId > 0 then
		RougeCollectionEnchantController.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, preCollectionId)
	end

	RougeCollectionEnchantController.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, collectionId)
end

RougeCollectionEnchantController.instance = RougeCollectionEnchantController.New()

LuaEventSystem.addEventMechanism(RougeCollectionEnchantController.instance)

return RougeCollectionEnchantController
