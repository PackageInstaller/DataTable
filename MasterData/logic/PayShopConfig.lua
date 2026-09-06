-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/config/PayShopConfig.lua

module("logic.extensions.payshop.config.PayShopConfig", package.seeall)

local PayShopConfig = class("PayShopConfig", BaseConfig)

function PayShopConfig:onInit()
	PayShopConfig.super.onInit(self)

	self.pay_shop_define = nil
	self._shopGoodsShoptypeKey = {}
	self.firstChargeCfgs = nil
	self._easyJumpParams = {}
	self._tabConfigFinishCount = 0
end

function PayShopConfig:getNames()
	return {
		"pay_shop_define",
		"acc_consume_gift_define",
		"annuity_activity",
		"pay_consume_gift_define",
		"level_time_machine",
		"level_time_machine_buy_plan",
		"scope_consume_gift",
		"pay_shop_group",
		"pay_shop_reset",
		"pay_shop_level1tab_define",
		"pay_shop_level2tab_define",
		"pay_shop_level3tab_define",
		"pay_shop_jumpto_page",
		"pay_shop_sell_detail",
		"pay_shop_discount_plan",
		"pay_shop_discount_gift",
		"pay_shop_deduce_plan",
		"pay_shop_sort_skin_cfg",
		"pay_shop_update_tip"
	}
end

function PayShopConfig:handleConfig(name, content)
	if name == "pay_shop_define" then
		self.pay_shop_define = content

		for k, v in pairs(content.dataList) do
			self._shopGoodsShoptypeKey[v.shopType] = self._shopGoodsShoptypeKey[v.shopType] or {}
			self._shopGoodsShoptypeKey[v.shopType][v.showType] = self._shopGoodsShoptypeKey[v.shopType][v.showType] or {}

			local list = self._shopGoodsShoptypeKey[v.shopType][v.showType]

			table.insert(list, v)
		end

		self:_handleFreeGoodsInShowType(content.dataList)
	elseif name == "acc_consume_gift_define" then
		self.acc_consume_gift_define = content
	elseif name == "pay_consume_gift_define" then
		self.pay_consume_gift_define = content
	elseif name == "annuity_activity" then
		self.annuity_activity = content
	elseif name == "pay_shop_tab_define" then
		self.pay_shop_tab_define = content
	elseif name == "pay_shop_level1tab_define" then
		self._pay_shop_level1tab_define = content

		self:_tabConfigLoaded(1, content.dataList)
	elseif name == "pay_shop_level2tab_define" then
		self._pay_shop_level2tab_define = content

		self:_tabConfigLoaded(2, content.dataList)
	elseif name == "pay_shop_level3tab_define" then
		self._pay_shop_level3tab_define = content

		self:_tabConfigLoaded(3, content.dataList)
	elseif name == "level_time_machine" then
		self.level_time_machine = content
	elseif name == "level_time_machine_buy_plan" then
		self.level_time_machine_buy_plan = content
	elseif name == "scope_consume_gift" then
		self.firstChargeCfgs = content
	elseif name == "pay_shop_group" then
		self._pay_shop_groupCfg = content
	elseif name == "pay_shop_reset" then
		self._pay_shop_reset = {}

		for i, v in ipairs(content.dataList) do
			self._pay_shop_reset[v.id] = self._pay_shop_reset[v.id] or {}

			table.insert(self._pay_shop_reset[v.id], v)
		end

		local function sort_func(a, b)
			return a.order < b.order
		end

		for k, v in pairs(self._pay_shop_reset) do
			table.sort(v, sort_func)
		end
	elseif name == "pay_shop_jumpto_page" then
		self._pay_shop_jumpto_page = content
	elseif name == "pay_shop_sell_detail" then
		self._pay_shop_sell_detail = content
	elseif name == "pay_shop_discount_plan" then
		self._pay_shop_discount_plan = content
	elseif name == "pay_shop_discount_gift" then
		self._pay_shop_discount_gift = content
	elseif name == "pay_shop_deduce_plan" then
		self._pay_shop_deduce_plan = content
	elseif name == "pay_shop_sort_skin_cfg" then
		self._pay_shop_sort_skin_cfg = content
	elseif name == "pay_shop_update_tip" then
		self._pay_shop_update_tip_cfg = content
	end
end

function PayShopConfig:getPayShopMibaoCfgs()
	return self.pay_shop_define
end

function PayShopConfig:getPayShopMibaoGoodsCfgsByTabId(id)
	return self._shopGoodsShoptypeKey[GameEnum.PayShopShopType.Payshop][id] or {}
end

function PayShopConfig:getPayShopGoodsCfgById(id)
	return self.pay_shop_define[id]
end

function PayShopConfig:getAccConsumeCfgById(id)
	return self.acc_consume_gift_define[id]
end

function PayShopConfig:getAccConsumeCfg()
	return self.acc_consume_gift_define.dataList
end

function PayShopConfig:getConsumeCfgById(id)
	return self.pay_consume_gift_define[id]
end

function PayShopConfig:getConsumeCfg()
	return self.pay_consume_gift_define.dataList
end

function PayShopConfig:getAnnuityCfg()
	return self.annuity_activity
end

function PayShopConfig:getAnnuityCfgById(annuityId)
	return self.annuity_activity[annuityId]
end

function PayShopConfig:getLevel1TabCfgs()
	if not self._bottomTabCfgs then
		self._bottomTabCfgs = {}

		for k, v in ipairs(self._pay_shop_level1tab_define.dataList) do
			table.insert(self._bottomTabCfgs, v)
		end

		table.sort(self._bottomTabCfgs, function(a, b)
			return a.rank < b.rank
		end)
	end

	return self._bottomTabCfgs
end

function PayShopConfig:getLevel1TabCfg(typeId)
	return self._pay_shop_level1tab_define[typeId]
end

function PayShopConfig:getLevel2TabCfgs(typeId)
	return self._pay_shop_level2tab_define[typeId]
end

function PayShopConfig:getLevel2TabCfg(typeId, id)
	return self._pay_shop_level2tab_define[typeId][id]
end

function PayShopConfig:getLevel3TabCfgs(typeId, id)
	if self._pay_shop_level3tab_define[typeId] then
		return self._pay_shop_level3tab_define[typeId][id]
	else
		return nil
	end
end

function PayShopConfig:getLevel3TabCfg(typeId, level2Id, id)
	return self._pay_shop_level3tab_define[typeId][level2Id][id]
end

function PayShopConfig:getMibaoViewTopTabCfgs()
	return self:getLevel3TabCfgs(GameEnum.PayShopFirstTab.Mibao, GameEnum.PayShopMibaoSecTab.Gift)
end

function PayShopConfig:getTimeMachineCfg(id)
	return self.level_time_machine[id]
end

function PayShopConfig:getTimeMachineCfgList()
	if self.level_time_machine then
		return self.level_time_machine.dataList
	end
end

function PayShopConfig:getTimeMachinePlanCfg(planId, times)
	if self.level_time_machine_buy_plan[planId] then
		return self.level_time_machine_buy_plan[planId][times]
	end

	return nil
end

function PayShopConfig:GetFirstChargeCfg(activityId, consumeId)
	if self.firstChargeCfgs == nil or checknumber(activityId) <= 0 then
		return nil
	end

	local list = self.firstChargeCfgs[activityId]

	if list == nil or checknumber(consumeId) <= 0 then
		return list
	end

	return list[consumeId]
end

function PayShopConfig:getGoodsCfgsByShopType(shopType)
	return self._shopGoodsShoptypeKey[shopType]
end

function PayShopConfig:getGoodsCfgsByShopTypeAndShowType(shopType, showType)
	if self._shopGoodsShoptypeKey[shopType] and self._shopGoodsShoptypeKey[shopType][showType] then
		return self._shopGoodsShoptypeKey[shopType][showType]
	end

	return {}
end

function PayShopConfig:getGroupCfg(id)
	return self._pay_shop_groupCfg[id]
end

function PayShopConfig:getPayshopResetCfgs()
	return self._pay_shop_reset
end

function PayShopConfig:_setEaseJumpParam(tabType, jumpInTag, errorKey, level1Id, level2Id, level3Id)
	if not string.nilorempty(jumpInTag) then
		if self._easyJumpParams[jumpInTag] then
			local sheet1 = string.format("秘宝商城tab规划%s级", tabType)
			local sheet2 = string.format("秘宝商城tab规划%s级", self._easyJumpParams[jumpInTag].tabType)
			local content = string.format("jumpInTag重复了：%s 表：%s 当前id：%s ,冲突表：%s 冲突id：%s", jumpInTag, sheet1, errorKey, sheet2, self._easyJumpParams[jumpInTag].errorKey)

			printError(content)
		else
			self._easyJumpParams[jumpInTag] = {
				tabType = tabType,
				errorKey = errorKey,
				jumpParam = {
					level1Id,
					level2Id,
					level3Id
				}
			}
		end
	end
end

function PayShopConfig:_tabConfigLoaded(tabType, dataList)
	self._tabConfigFinishCount = self._tabConfigFinishCount + 1

	if self._tabConfigFinishCount == 3 then
		local lv1cfgs = self:getLevel1TabCfgs()

		for _, lv1 in pairs(lv1cfgs) do
			self:_setEaseJumpParam(1, lv1.jumpInTag, lv1.type, false, false)

			local lv2cfgs = self:getLevel2TabCfgs(lv1.type)

			if lv2cfgs then
				for _, lv2 in pairs(lv2cfgs) do
					self:_setEaseJumpParam(2, lv2.jumpInTag, lv1.type .. "@" .. lv2.id, lv1.type, lv2.id, false)

					local lv3cfgs = self:getLevel3TabCfgs(lv1.type, lv2.id)

					if lv3cfgs then
						for _, lv3 in pairs(lv3cfgs) do
							self:_setEaseJumpParam(3, lv3.jumpInTag, lv1.type .. "@" .. lv2.id .. "@" .. lv3.id, lv1.type, lv2.id, lv3.id)
						end
					end
				end
			end
		end
	end
end

function PayShopConfig:getJumpInParam(jumpInTag)
	return (self._easyJumpParams[jumpInTag] or nil) and (self._easyJumpParams[jumpInTag].jumpParam or {
		GameEnum.PayShopFirstTab.Mibao,
		GameEnum.PayShopMibaoSecTab.Gift
	})
end

function PayShopConfig:getJumpPageCfgs()
	return self._pay_shop_jumpto_page.dataList
end

function PayShopConfig:getJumpPageCfg(id)
	return self._pay_shop_jumpto_page[id]
end

function PayShopConfig:getSellDetailCfgCfg(id)
	return self._pay_shop_sell_detail[id]
end

function PayShopConfig:getDiscountPlanCfg(planId)
	return self._pay_shop_discount_plan[planId]
end

function PayShopConfig:getDiscountGiftCfgs(activityId)
	return self._pay_shop_discount_gift[activityId]
end

function PayShopConfig:getDeduceCfg(planId)
	return self._pay_shop_deduce_plan[planId]
end

function PayShopConfig:getSkinSortCfgs()
	return self._pay_shop_sort_skin_cfg
end

function PayShopConfig:getSkinSortCfg(id)
	return self._pay_shop_sort_skin_cfg[id]
end

function PayShopConfig:_handleFreeGoodsInShowType(dataList)
	self._freeGoodsInShowType = {}

	for i, v in ipairs(dataList) do
		if v.shopType == GameEnum.PayShopShopType.Payshop and v.payType == GameEnum.PayShopPayType.GAMEGOODS and v.originalGoodsId == "" then
			self._freeGoodsInShowType[v.showType] = self._freeGoodsInShowType[v.showType] or {}

			table.insert(self._freeGoodsInShowType[v.showType], v)
		end
	end
end

function PayShopConfig:getFreeGoodsByShowType(showType)
	return self._freeGoodsInShowType[showType] or {}
end

function PayShopConfig:getUpdateTipCfg()
	for id, cfg in ipairs(self._pay_shop_update_tip_cfg.dataList) do
		local openStr = string.split(cfg.openTime, "|")
		local timeStr = string.split(openStr[2], ",")
		local isInTime = GameUtil.checkIsInTimePeriod(timeStr[1], timeStr[2])

		if isInTime then
			return cfg.desc
		end
	end

	return ""
end

PayShopConfig.instance = PayShopConfig.New()

return PayShopConfig
