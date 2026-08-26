-- chunkname: @modules/logic/sceneuipackage/model/SceneUIPackageModel.lua

module("modules.logic.sceneuipackage.model.SceneUIPackageModel", package.seeall)

local SceneUIPackageModel = class("SceneUIPackageModel", BaseModel)

function SceneUIPackageModel:onInit()
	self:reInit()
end

function SceneUIPackageModel:reInit()
	self._itemInfos = {}
end

function SceneUIPackageModel:getActId()
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.SceneUIPackageAct, ActivityEnum.Activity.S02SceneUIPackageAct)
end

function SceneUIPackageModel:_getGoodsInfo(actId)
	local itemInfo = self._itemInfos[actId]

	itemInfo = itemInfo or {}

	return itemInfo
end

function SceneUIPackageModel:getGoodsId(actId)
	actId = actId or self:getActId()

	local itemInfo = self:_getGoodsInfo(actId)

	if not itemInfo.goodsId then
		local actCo = ActivityConfig.instance:getActivityCo(actId)

		itemInfo.goodsId = actCo and not string.nilorempty(actCo.patFaceParam) and tonumber(actCo.patFaceParam)
	end

	return itemInfo.goodsId
end

function SceneUIPackageModel:getGoodsCo(actId)
	local goodsId = self:getGoodsId(actId)
	local co = StoreConfig.instance:getChargeGoodsConfig(goodsId)

	if co then
		return co
	end
end

function SceneUIPackageModel:getGoodsItems(actId)
	local itemInfo = self:_getGoodsInfo(actId)

	if not itemInfo.items then
		itemInfo.items = {}

		local goodsCo = self:getGoodsCo(actId)

		if goodsCo and not string.nilorempty(goodsCo.product) then
			local product = GameUtil.splitString2(goodsCo.product, true)

			for _, v in ipairs(product) do
				local itemCo = ItemModel.instance:getItemConfig(v[1], v[2])

				itemInfo.items[itemCo.subType] = v
			end
		end
	end

	return itemInfo.items
end

function SceneUIPackageModel:getItemBySubType(actId, subType)
	local items = self:getGoodsItems(actId)

	return items and items[subType]
end

function SceneUIPackageModel:getRestItem(actId)
	local items = self:getGoodsItems(actId)

	for subType, v in pairs(items) do
		if subType ~= ItemEnum.SubType.MainSceneSkin and subType ~= ItemEnum.SubType.MainUISkin then
			return v
		end
	end
end

function SceneUIPackageModel:getSceneCo(actId)
	local item = self:getItemBySubType(actId, ItemEnum.SubType.MainSceneSkin)

	if not item then
		return
	end

	return MainSceneSwitchConfig.instance:getConfigByItemId(item[2])
end

function SceneUIPackageModel:getUICo(actId)
	local item = self:getItemBySubType(actId, ItemEnum.SubType.MainUISkin)

	if not item then
		return
	end

	return MainUISwitchConfig.instance:getUISwitchCoByItemId(item[2])
end

function SceneUIPackageModel:hasScene(actId)
	local item = self:getItemBySubType(actId, ItemEnum.SubType.MainSceneSkin)

	if not item then
		return
	end

	local num = ItemModel.instance:getItemQuantity(item[1], item[2])

	return num > 0
end

function SceneUIPackageModel:hasUI(actId)
	local item = self:getItemBySubType(actId, ItemEnum.SubType.MainUISkin)

	if not item then
		return
	end

	local num = ItemModel.instance:getItemQuantity(item[1], item[2])

	return num > 0
end

function SceneUIPackageModel:canBuy(actId)
	local goodsId = self:getGoodsId(actId)
	local goodsMo = StoreModel.instance:getGoodsMO(goodsId)
	local isSoldOut = not goodsMo or goodsMo:isSoldOut()

	if isSoldOut then
		return false
	end

	local hasScene = self:hasScene(actId)
	local hasUI = self:hasUI(actId)

	if hasScene and hasUI then
		return false
	end

	return true
end

function SceneUIPackageModel:getPackageCo(actId)
	return lua_activity_decoration.configDict[actId]
end

function SceneUIPackageModel:isInSceneUIPackage(itemId)
	if not self._scemeUIPackages then
		self:_initSceneUIPackage()
	end

	for id, package in pairs(self._scemeUIPackages) do
		for _, v in ipairs(package) do
			if v[2] == itemId then
				return true
			end
		end
	end
end

function SceneUIPackageModel:isPackage(goodsId)
	if not self._scemeUIPackages then
		self:_initSceneUIPackage()
	end

	return self._scemeUIPackages[goodsId] ~= nil
end

function SceneUIPackageModel:_initSceneUIPackage()
	self._scemeUIPackages = {}

	for _, co in ipairs(lua_store_decorate.configList) do
		if co.subType == ItemEnum.SubType.SceneUIPackage then
			local storeCo = StoreConfig.instance:getGoodsConfig(co.id)

			if storeCo then
				self._scemeUIPackages[co.id] = GameUtil.splitString2(storeCo.product, true, "|", "#")
			end
		end
	end
end

SceneUIPackageModel.instance = SceneUIPackageModel.New()

return SceneUIPackageModel
