-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\RechargeMixin.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local ResPrivilege = require("ClientData/ResPrivilege")
local ResRechargeGiftDraw = require("ClientData/ResRechargeGiftDraw")
local ResRecharge = require("ClientData/ResRecharge")
local EventConst = require("EventConst")
local RechargeMixin = {}

function RechargeMixin:initRechargeMixin(roleData, syncData)
	self:initRechargeData(syncData)
	RechargeManager.refreshGameProducts()
	self:initPrivilegeBuffs(syncData.other.privilege)

	self.cacheRechargeDeliverMap = {}
	self._slothandleRechargeDelivers = Slot(self.handleRechargeDelivers, self)
end

function RechargeMixin:postinitRechargeMixin(roleData)
	return
end

function RechargeMixin:destroyRechargeMixin()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slothandleRechargeDelivers)
	RechargeManager.destroy()
end

function RechargeMixin:initRechargeData(syncData)
	self.rechargeLeftCount = {}

	local rechargeData = syncData.other.recharge

	for _, mulityItem in ipairs(rechargeData.mulity) do
		self.rechargeLeftCount[mulityItem.recharge_id] = mulityItem.left_count
	end
end

function RechargeMixin:handleRechargeDelivers(...)
	for k, data in ipairs(self.cacheRechargeDeliverMap) do
		if k == 1 then
			local recharge_id = data.recharge_id

			if recharge_id then
				local product = RechargeManager.getProductByRechargeId(recharge_id)

				if product then
					EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slothandleRechargeDelivers)
				else
					return
				end
			end
		end

		RechargeManager.onRechargeDeliverNotify(data.recharge_id, data.order_id, data.deliver_num, data.deliver_online, data.item_id, data.normal_item, data.expect_item, data.deliver_free_num, data.pay_currency, data.use_refund)
	end

	self.cacheRechargeDeliverMap = {}
end

function RechargeMixin:cacheRechargeDeliver(recharge_id, order_id, deliver_num, deliver_online, item_id, normal_item, expect_item, deliver_free_num, pay_currency, use_refund)
	if not self.cacheRechargeDeliverMap then
		self.cacheRechargeDeliverMap = {}
	end

	if #self.cacheRechargeDeliverMap == 0 then
		EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slothandleRechargeDelivers)
	end

	local data = {}

	data.recharge_id = recharge_id
	data.order_id = order_id
	data.deliver_num = deliver_num
	data.deliver_online = deliver_online
	data.item_id = item_id
	data.normal_item = normal_item
	data.expect_item = expect_item
	data.deliver_free_num = deliver_free_num
	data.pay_currency = pay_currency
	data.use_refund = use_refund

	table.insert(self.cacheRechargeDeliverMap, data)
end

function RechargeMixin:getRechargeLeftGetCount(rechargeId)
	if rechargeId then
		return self.rechargeLeftCount[rechargeId] or 0
	else
		return 0
	end
end

function RechargeMixin:onRechargeMulityNotify(mulityItem)
	self.rechargeLeftCount[mulityItem.recharge_id] = mulityItem.left_count

	RechargeManager._checkProductsLoaded()
	self:checkToGetaward()
end

function RechargeMixin:onRechargeCanBuyCountNotify(item)
	RechargeManager.updateGameProductCanBuyCount(item)
end

function RechargeMixin:onRechargeListGetResp(rechargeList)
	RechargeManager._onGameProductsLoaded(true, rechargeList)
end

function RechargeMixin:onRechargeListNotify(rechargeList)
	RechargeManager._onGameProductsLoaded(true, rechargeList)
end

function RechargeMixin:onRechargeGenerateOrderIDResp(resp_code, svr_nodeid, channel_account, recharge_id, product_id, orderid, extend_info, opensvr_code, anti_data, gift_type)
	RechargeManager.onRechargeGenerateOrderIDResp(resp_code, svr_nodeid, channel_account, recharge_id, product_id, orderid, extend_info, opensvr_code, anti_data, gift_type)
end

function RechargeMixin:onRechargeDeliverNotify(recharge_id, order_id, deliver_num, deliver_online, item_id, normal_item, expect_item, deliver_free_num, pay_currency, use_refund)
	local product = RechargeManager.getProductByRechargeId(recharge_id)

	if product then
		RechargeManager.onRechargeDeliverNotify(recharge_id, order_id, deliver_num, deliver_online, item_id, normal_item, expect_item, deliver_free_num, pay_currency, use_refund)
	else
		self:cacheRechargeDeliver(recharge_id, order_id, deliver_num, deliver_online, item_id, normal_item, expect_item, deliver_free_num, pay_currency, use_refund)
	end
end

function RechargeMixin:initPrivilegeBuffs(privilege)
	self.privilege = {}
	self.privilegeEnhanceValue = {}
	self.privilegeTypeIdListDic = {}

	for _, buff in ipairs(privilege.buff) do
		for _, item in ipairs(buff.item) do
			local priId = item.id

			self.privilege[priId] = item.end_time or 0
		end
	end

	for priId, endTime in pairs(self.privilege) do
		local priData = ResPrivilege[priId]

		if priData then
			local enhanceType = priData.type

			if utils.getIndexByValue(self.privilegeTypeIdListDic[enhanceType], priId) == -1 then
				if not self.privilegeTypeIdListDic[enhanceType] then
					self.privilegeTypeIdListDic[enhanceType] = {}
				end

				table.insert(self.privilegeTypeIdListDic[enhanceType], priId)

				if not self.privilegeEnhanceValue[enhanceType] then
					self.privilegeEnhanceValue[enhanceType] = {
						0,
						0
					}
				end

				self.privilegeEnhanceValue[enhanceType][1] = self.privilegeEnhanceValue[enhanceType][1] + (priData.abs_add or 0)
				self.privilegeEnhanceValue[enhanceType][2] = self.privilegeEnhanceValue[enhanceType][2] + (priData.percent_add or 0)
			end
		end
	end

	self:refreshPrivilegeDeposit()
end

function RechargeMixin:onPrivilegeItemChangeNotify(priId, end_time, reason)
	local showFlag = true

	if self.privilege[priId] then
		self.privilege[priId] = end_time or 0
		showFlag = false
	end

	self.privilege[priId] = end_time or 0

	local priData = ResPrivilege[priId]

	if priData then
		local enhanceType = priData.type

		if utils.getIndexByValue(self.privilegeTypeIdListDic[enhanceType], priId) ~= -1 then
			return
		end

		if not self.privilegeTypeIdListDic[enhanceType] then
			self.privilegeTypeIdListDic[enhanceType] = {}
		end

		table.insert(self.privilegeTypeIdListDic[enhanceType], priId)

		if not self.privilegeEnhanceValue[enhanceType] then
			self.privilegeEnhanceValue[enhanceType] = {
				0,
				0
			}
		end

		self.privilegeEnhanceValue[enhanceType][1] = self.privilegeEnhanceValue[enhanceType][1] + (priData.abs_add or 0)
		self.privilegeEnhanceValue[enhanceType][2] = self.privilegeEnhanceValue[enhanceType][2] + (priData.percent_add or 0)

		self:onPrivilegeChanged(enhanceType)
	end

	if reason and reason == Const.PRIVILEGE_UPDATE_REASON_ITEM_USE and showFlag then
		local showAwardPrivilegeDlg = UIManager.getUI("showAwardPrivilegeDlg", true)

		showAwardPrivilegeDlg:setPrivilegeInfo(priId, self.privilege[priId])
	end
end

function RechargeMixin:onPrivilegeChanged(privilegeType)
	if privilegeType == Const.PRIVITY_KEY_DEPOSIT_TIME_LIMIT then
		self:refreshPrivilegeDeposit()
	elseif privilegeType == Const.PRIVITY_KEY_POWER_RECOVERY then
		self:initPowerData(self.powerResumeTime)
	elseif privilegeType == Const.PRIVITY_KEY_POWER_LIMIT then
		self:initPowerData(self.powerResumeTime)
	end
end

local CALC_CEIL_PRIVILEGE = {
	[Const.PRIVITY_KEY_EBONUS_WORLD_BOSS] = 1,
	[Const.PRIVITY_KEY_EBONUS_MAZE] = 1,
	[Const.PRIVITY_KEY_EBONUS_DAILY_TASK] = 1
}
local PRIVILEGE_ACT_RELATE = {
	[Const.PRIVITY_KEY_EQUIP_TOWER_SWEEP] = Const.ACT_PRIVILEGE_TYPE_EQUIP_SWEEP,
	[Const.PRIVITY_KEY_EXPAND_BOSS] = Const.ACT_PRIVILEGE_TYPE_NEW_BOSS_SWEEP
}

function RechargeMixin:getPrivilegeValue(key, value, returnExtra)
	value = value or 0

	local extraValue = 0

	if PRIVILEGE_ACT_RELATE[key] then
		extraValue = self:getActPrivilege(PRIVILEGE_ACT_RELATE[key], value, true)
	end

	local enhanceInfo = self.privilegeEnhanceValue[key]

	if enhanceInfo then
		local param1 = enhanceInfo[1]
		local param2 = enhanceInfo[2]
		local idList = self.privilegeTypeIdListDic[key]

		for _, id in ipairs(idList) do
			local priData = ResPrivilege[id]

			if priData and not self:privilegeIsValid(id) then
				param1 = param1 - (priData.abs_add or 0)
				param2 = param2 - (priData.percent_add or 0)
			end
		end

		if returnExtra then
			if CALC_CEIL_PRIVILEGE[key] then
				return math.ceil(value * param2 * 0.0001 + param1 + extraValue)
			else
				return value * param2 * 0.0001 + param1 + extraValue
			end
		elseif CALC_CEIL_PRIVILEGE[key] then
			return math.ceil(math.max(value + value * param2 * 0.0001 + param1 + extraValue, 0))
		else
			return math.max(value + value * param2 * 0.0001 + param1 + extraValue, 0)
		end
	end

	if returnExtra then
		return extraValue
	else
		return value + extraValue
	end
end

function RechargeMixin:hasPrivilegeType(key)
	local enhanceInfo = self.privilegeEnhanceValue[key]

	if enhanceInfo then
		local param1 = enhanceInfo[1]
		local param2 = enhanceInfo[2]
		local idList = self.privilegeTypeIdListDic[key]

		for _, id in ipairs(idList) do
			local priData = ResPrivilege[id]

			if priData and not self:privilegeIsValid(id) then
				param1 = param1 - (priData.abs_add or 0)
				param2 = param2 - (priData.percent_add or 0)
			end
		end

		return param1 ~= 0 or param2 ~= 0
	end

	return false
end

function RechargeMixin:privilegeIsValid(priId)
	local priData = ResPrivilege[priId]
	local privilegeType = priData.type

	if self.privilege[priId] ~= nil then
		if (not priData.is_forever or priData.is_forever ~= 1) and Const.PRIVITY_KEY_EFFECT_DIC[privilegeType] and Const.PRIVITY_KEY_EFFECT_DIC[privilegeType] == Const.PRIVITY_EFFECT_TYPE.CONTINUE then
			return false
		end

		if self.privilege[priId] and self.privilege[priId] ~= 0 and ClientUtils.getServerTime() >= self.privilege[priId] then
			return false
		end

		return true
	end

	return false
end

function RechargeMixin:getAllBuffPrivilege()
	local priBuffDataList = {}

	for priId, endTime in pairs(self.privilege) do
		local priData = ResPrivilege[priId]

		if priData and priData.show_buff_id and (not priData.is_forever or priData.is_forever ~= 1) and self:privilegeIsValid(priId) then
			local priBuffData = {}

			priBuffData.resData = priData
			priBuffData.endTime = endTime

			table.insert(priBuffDataList, priBuffData)
		end
	end

	return priBuffDataList
end

function RechargeMixin:refreshPrivilegeDeposit()
	local despositMaxTime = 86400

	Const.MAIN_STAGE_DEPOSIT_MAX_TIME = self:getPrivilegeValue(Const.PRIVITY_KEY_DEPOSIT_TIME_LIMIT, despositMaxTime)
end

function RechargeMixin:checkShowActGiftDrawIcon(productData)
	if productData.relateGiftDraw and productData.relateGiftDraw == 1 then
		local relatedActId = ResRechargeGiftDraw[1].relate_act
		local actObj = CurAvatar:getActivityObj(relatedActId)

		if actObj and actObj:isValid() and not actObj:inFreeze() then
			local iconInfo = {}

			iconInfo.gear_icon_path = actObj.actData.miscTableData.gear_icon_path
			iconInfo.gear_icon = actObj.actData.miscTableData.gear_icon

			return iconInfo
		end
	end

	return nil
end

return RechargeMixin
