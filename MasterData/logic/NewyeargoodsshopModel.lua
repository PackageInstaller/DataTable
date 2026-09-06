-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/model/NewyeargoodsshopModel.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopModel", package.seeall)

local NewyeargoodsshopModel = class("NewyeargoodsshopModel", BaseModel)

function NewyeargoodsshopModel:ctor()
	return
end

function NewyeargoodsshopModel:onInit()
	self:onReset()
end

function NewyeargoodsshopModel:onReset()
	return
end

function NewyeargoodsshopModel:getBestDiscountPlanIdByGoodsDefineId(activityType, activityId, shopItemId)
	local bestId = 0
	local goodsCfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(activityType, activityId, shopItemId)

	if not goodsCfg then
		return bestId
	end

	if not goodsCfg.couponIds or #goodsCfg.couponIds <= 0 then
		return 0
	end

	local deductCount = 0
	local matType, matId, num = MaterialMgr.getMatParams(goodsCfg.sellPrice)

	for i, couponId in ipairs(goodsCfg.couponIds) do
		local ccfg = ActivityshopConfig.instance:getCouponCfg(couponId)

		if matType == ccfg.deductMaterialType and MaterialMgr.getMatEnough(ccfg.discountCost) and deductCount < ccfg.deductCount and NewyeargoodsshopController.instance:isCanUseCoupon(goodsCfg, couponId) then
			deductCount = ccfg.deductCount
			bestId = ccfg.couponId
		end
	end

	return bestId
end

NewyeargoodsshopModel.instance = NewyeargoodsshopModel.New()

return NewyeargoodsshopModel
