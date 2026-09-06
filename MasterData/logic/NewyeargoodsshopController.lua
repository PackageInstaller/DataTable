-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/controller/NewyeargoodsshopController.lua

module("logic.extensions.newyeargoodsshop.controller.NewyeargoodsshopController", package.seeall)

local NewyeargoodsshopController = class("NewyeargoodsshopController", BaseController)

function NewyeargoodsshopController:ctor()
	return
end

function NewyeargoodsshopController:onInit()
	self:onReset()
end

function NewyeargoodsshopController:onReset()
	return
end

function NewyeargoodsshopController:isCanUseCoupon(goodsCfg, couponId)
	local ccfg = ActivityshopConfig.instance:getCouponCfg(couponId)
	local matType, matId, num = MaterialMgr.getMatParams(goodsCfg.sellPrice)

	if matType == ccfg.deductMaterialType and MaterialMgr.getMatEnough(ccfg.discountCost) and (ccfg.minCost ~= -1 or num > ccfg.deductCount) then
		return true
	end

	return false
end

NewyeargoodsshopController.instance = NewyeargoodsshopController.New()

return NewyeargoodsshopController
