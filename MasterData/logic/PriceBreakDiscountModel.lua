-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/model/PriceBreakDiscountModel.lua

module("logic.extensions.pricebreakdiscount.model.PriceBreakDiscountModel", package.seeall)

local PriceBreakDiscountModel = class("PriceBreakDiscountModel", BaseModel)

function PriceBreakDiscountModel:onInit()
	self:onReset()
end

function PriceBreakDiscountModel:onReset()
	self._activityId = nil
	self._trolley = {}
	self._buyRecord = {}
end

function PriceBreakDiscountModel:setData(msg)
	local data = GameUtil.pbToTable(msg)

	self._buyRecord = {}

	if data.buyRecord then
		for i, v in ipairs(data.buyRecord) do
			self._buyRecord[v.itemId] = v.itemNum
		end
	end

	self._trolley = {}

	if data.cartItem then
		for i, v in ipairs(data.cartItem) do
			self._trolley[v.itemId] = v.itemNum
		end
	end
end

function PriceBreakDiscountModel:setDataAfterData(msg)
	local data = GameUtil.pbToTable(msg)

	self._trolley = {}
	self._buyRecord = {}

	if data.buyRecord then
		for i, v in ipairs(data.buyRecord) do
			self._buyRecord[v.itemId] = v.itemNum
		end
	end
end

function PriceBreakDiscountModel:getTrolley()
	return self._trolley
end

function PriceBreakDiscountModel:clearTrolley()
	self._trolley = {}
end

function PriceBreakDiscountModel:getBuyRecord()
	return self._buyRecord
end

function PriceBreakDiscountModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.PriceBreakDiscount)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.PriceBreakDiscount)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PriceBreakDiscount, v.activityId) then
			local cfg = PriceBreakDiscountConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_price_break_discount_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

PriceBreakDiscountModel.instance = PriceBreakDiscountModel.New()

return PriceBreakDiscountModel
