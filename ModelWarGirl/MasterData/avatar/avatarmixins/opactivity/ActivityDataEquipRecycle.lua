-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataEquipRecycle.lua

local ResEquipRecycleMisc = require("ClientData/ResEquipRecycleMisc")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ActivityDataEquipRecycle = Class("ActivityDataEquipRecycle", ActivityDataBase)

function ActivityDataEquipRecycle:ctor(...)
	return
end

function ActivityDataEquipRecycle:updateRoleData(roleData)
	if roleData and roleData.equip_recycle and roleData.equip_recycle.close_time then
		local svrTime = ClientUtils.getServerTime()

		if svrTime >= roleData.equip_recycle.close_time then
			return
		end
	end

	if roleData and roleData.equip_recycle then
		self.mainWorkShopData = self:initWorkShopData(roleData.equip_recycle.main_workshop)
		self.rentWorkShopData = self:initRentWorkShopData(roleData.equip_recycle.rent_workshop)
	end

	self:refreshUI()
end

local relateUIs = {
	"activityEquipRecycleInitialDlg",
	"activityEquipRecycleDlg",
	"activityEquipRecycleEditDlg",
	"activityBraceletExchangeDlg",
	"activityEquipRecycleRewardDlg"
}

function ActivityDataEquipRecycle:refreshUI(...)
	self:checkNew()

	for index, ui in ipairs(relateUIs) do
		local UI = UIManager.tryGetUI(ui)

		if UI and UI.setData then
			UI:setData()
		end
	end

	local ui = UIManager.tryGetUI("mainBagDlg")

	if ui then
		ui:refreshMode()
	end
end

function ActivityDataEquipRecycle:updateMgrData(mgrData)
	return
end

function ActivityDataEquipRecycle:initRentWorkShopData(workshop)
	if not workshop then
		return nil
	end

	local data = self:initWorkShopData(workshop) or {}

	data.beginTime = workshop.begin_time
	data.unLock = data.beginTime and data.beginTime ~= 0
	data.finishAtOnce = workshop.finish_at_once == 1
	data.isRent = true

	return data
end

function ActivityDataEquipRecycle:getExchangeItemData()
	local actId = self.actObject.actId or 9060
	local itemId = ResEquipRecycleMisc[actId].exchange_item_id

	return itemId, CurAvatar:getItemNumById(itemId)
end

function ActivityDataEquipRecycle:getUnlockItemResData(...)
	local actId = self.actObject.actId or 9060
	local itemId = ResEquipRecycleMisc[actId].unlock_item_id or 0
	local itemNum = ResEquipRecycleMisc[actId].unlock_item_num or 0

	return itemId, itemNum
end

function ActivityDataEquipRecycle:initWorkShopData(workshop)
	if not workshop then
		return nil
	end

	local data = {}

	data.equipList = {}

	if workshop.equip_list and workshop.equip_list.equip then
		for index, item in ipairs(workshop.equip_list.equip or {}) do
			local newEquip = CurAvatar.bagEquips[item.equip_id]

			if newEquip then
				data.equipList[item.pos] = newEquip
			end
		end
	end

	data.startTime = 0

	if workshop.equip_list and workshop.equip_list.start_time then
		data.startTime = workshop.equip_list.start_time
	end

	local finish_list = workshop.finish_list or {}

	data.finishList = {}

	for index, item in ipairs(finish_list.finish_item or {}) do
		local newEquip = CurAvatar.bagEquips[item.equip_id]

		newEquip.recycleType = item.recycle_type

		if newEquip then
			table.insert(data.finishList, newEquip)
		end
	end

	return data
end

function ActivityDataEquipRecycle:getAllCanRecycleEquipList(listIndex)
	local equipList = CurAvatar:getAllCanRecycleEquipList()
	local finishList = {}
	local normalMap = {}
	local rentMap = {}

	if self.mainWorkShopData then
		for index, equip in ipairs(self.mainWorkShopData.equipList or {}) do
			normalMap[equip.gid] = index
		end

		for index, equip in ipairs(self.mainWorkShopData.finishList or {}) do
			finishList[equip.gid] = true
		end
	end

	if self.rentWorkShopData then
		for index, equip in ipairs(self.rentWorkShopData.equipList or {}) do
			rentMap[equip.gid] = index
		end

		for index, equip in ipairs(self.rentWorkShopData.finishList or {}) do
			finishList[equip.gid] = true
		end
	end

	local data = {}

	for index, equip in ipairs(equipList) do
		if not finishList[equip.gid] then
			local newEquip = BaseObject.CopyObject(equip)

			if normalMap[newEquip.gid] then
				newEquip.recycleListIndex = Const.EQUIP_RECYCLE_LIST_NORMAL
				newEquip.recycleIndex = normalMap[newEquip.gid]
				newEquip.inOtherList = listIndex == Const.EQUIP_RECYCLE_LIST_RENT
				newEquip.listStarted = self.mainWorkShopData and self.mainWorkShopData.startTime ~= 0
			end

			if rentMap[newEquip.gid] then
				newEquip.recycleListIndex = Const.EQUIP_RECYCLE_LIST_RENT
				newEquip.recycleIndex = rentMap[newEquip.gid]
				newEquip.inOtherList = listIndex == Const.EQUIP_RECYCLE_LIST_NORMAL
				newEquip.listStarted = self.rentWorkShopData and self.rentWorkShopData.startTime ~= 0
			end

			table.insert(data, newEquip)
		end
	end

	return data
end

function ActivityDataEquipRecycle:getNormarListUnitTime(...)
	local costTime = 14400
	local actId = self.actObject.actId or 9060

	if ResEquipRecycleMisc[actId] and ResEquipRecycleMisc[actId].main_cost_time then
		costTime = ResEquipRecycleMisc[actId].main_cost_time
	end

	return costTime
end

function ActivityDataEquipRecycle:getRentListUnitTime(...)
	local costTime = 10800
	local actId = self.actObject.actId or 9060

	if ResEquipRecycleMisc[actId] and ResEquipRecycleMisc[actId].rent_cost_time then
		costTime = ResEquipRecycleMisc[actId].rent_cost_time
	end

	return costTime
end

function ActivityDataEquipRecycle:getListRemainTime(listData)
	if not listData then
		return
	end

	local unitTime = 14400
	local firstTime = 14400

	if listData.isRent then
		unitTime = self:getRentListUnitTime()
		firstTime = unitTime

		if not listData.finishAtOnce then
			firstTime = 3
		end
	else
		unitTime = self:getNormarListUnitTime()
		firstTime = unitTime
	end

	local totalTime = 0
	local size = #listData.equipList

	if size >= 0 then
		local time = ClientUtils.getServerTime() - listData.startTime

		return firstTime - time, firstTime + (size - 1) * unitTime - time
	end

	return 0, 0
end

function ActivityDataEquipRecycle:getRentListRemainTime(...)
	if self.rentWorkShopData then
		return self:getListRemainTime(self.rentWorkShopData)
	end

	return 0, 0
end

function ActivityDataEquipRecycle:getNormarListRemainTime(...)
	if self.mainWorkShopData then
		return self:getListRemainTime(self.mainWorkShopData)
	end

	return 0, 0
end

function ActivityDataEquipRecycle:checkOpenRecycleSystem(...)
	local actId = self.actObject.actId or 9060

	if ResEquipRecycleMisc[actId] and ResEquipRecycleMisc[actId].condition_id then
		return ConditionLimitManager.inLimitState(ResEquipRecycleMisc[actId].condition_id)
	end

	return false
end

function ActivityDataEquipRecycle:getLimitDesc(...)
	local ResConditionLimit = require("ClientData/ResConditionLimit")
	local actId = self.actObject.actId or 9060

	if ResEquipRecycleMisc[actId] and ResEquipRecycleMisc[actId].condition_id and ResConditionLimit[ResEquipRecycleMisc[actId].condition_id] then
		return ResConditionLimit[ResEquipRecycleMisc[actId].condition_id].unlock_button_desc or ""
	end
end

function ActivityDataEquipRecycle:checkNormalListAward(...)
	local hasAward = false

	if self.mainWorkShopData and self.mainWorkShopData.finishList and #self.mainWorkShopData.finishList ~= 0 then
		hasAward = true
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL, hasAward)
end

function ActivityDataEquipRecycle:checkRentListAward(...)
	local hasAward = false

	if self.rentWorkShopData and self.rentWorkShopData.finishList and #self.rentWorkShopData.finishList ~= 0 then
		hasAward = true
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT, hasAward)
end

function ActivityDataEquipRecycle:checkHaveAward(...)
	self:checkRentListAward()
	self:checkNormalListAward()

	local hasAward = RedDotManager.getKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL) or RedDotManager.getKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT)

	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD, hasAward)
end

function ActivityDataEquipRecycle:checkNew(...)
	self:checkHaveAward()

	local result = RedDotManager.getKeyState(UIConst.RD_HINT_EQUIP_RECYCLE)

	if self.actObject.redDotId then
		RedDotManager.setKeyState(self.actObject.redDotId, result)
	end

	return result
end

function ActivityDataEquipRecycle:onStateChange(opActState)
	self.opactState = opActState

	if opActState == Const.OPACT_STATE_CLOSE then
		self.onStateClose()
	end
end

function ActivityDataEquipRecycle:checkOneListNeedStartTips(listData)
	local needShow = false

	if listData then
		needShow = listData.equipList and #listData.equipList ~= 0 and listData.startTime and listData.startTime == 0
	end

	return needShow
end

function ActivityDataEquipRecycle:checkNeedShowStartTips(...)
	if self.mainWorkShopData and self:checkOneListNeedStartTips(self.mainWorkShopData) then
		return true
	end

	if self.rentWorkShopData then
		return self:checkOneListNeedStartTips(self.rentWorkShopData)
	end
end

function ActivityDataEquipRecycle:onStateClose()
	local relateUIs = {
		"activityEquipRecycleInitialDlg",
		"activityEquipRecycleDlg",
		"activityEquipRecycleEditDlg",
		"activityEquipRecycleRewardDlg"
	}
	local isNeedTips = false

	for _, name in ipairs(relateUIs) do
		local ui = UIManager.tryGetUI(name)

		if ui and ui:getVisible() then
			isNeedTips = true

			break
		end
	end

	local function yesFunc(...)
		for _, name in ipairs(relateUIs) do
			local ui = UIManager.tryGetUI(name)

			if ui and ui:getVisible() then
				ui:setVisible(false)
			end
		end
	end

	local msgContent = ClientUtils.getClientNotice(778)

	if isNeedTips then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", msgContent, yesFunc, nil, nil)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL, false)
	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT, false)
	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE_AWARD, false)
	RedDotManager.setKeyState(UIConst.RD_HINT_EQUIP_RECYCLE, false)
end

return ActivityDataEquipRecycle
