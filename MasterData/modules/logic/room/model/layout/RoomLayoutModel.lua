-- chunkname: @modules/logic/room/model/layout/RoomLayoutModel.lua

module("modules.logic.room.model.layout.RoomLayoutModel", package.seeall)

local RoomLayoutModel = class("RoomLayoutModel", BaseModel)

function RoomLayoutModel:onInit()
	self:_clearData()
end

function RoomLayoutModel:reInit()
	self:_clearData()
end

function RoomLayoutModel:clear()
	RoomLayoutModel.super.clear(self)
	self:_clearData()
end

function RoomLayoutModel:_clearData()
	self._needRpcGetInfo = true
	self._visitCopyName = nil
	self._isPlayUnLock = nil
	self._canUseShareCount = 0
	self._canShareCount = 0
	self._useCount = 0
end

function RoomLayoutModel:isNeedRpcGet()
	return self._needRpcGetInfo
end

function RoomLayoutModel:clearNeedRpcGet()
	self._needRpcGetInfo = true
end

function RoomLayoutModel:rpcGetFinish()
	self._needRpcGetInfo = false
end

function RoomLayoutModel:setRoomPlanInfoReply(msg)
	local listMO = {}
	local useMO = self:getById(RoomEnum.LayoutUsedPlanId)
	local planInfos = msg.infos

	if planInfos then
		for i = 1, #planInfos do
			local info = planInfos[i]
			local mo = RoomLayoutMO.New()

			mo:init(info.id)

			if useMO and info.id == RoomEnum.LayoutUsedPlanId then
				mo:updateInfo(useMO)
			end

			mo:updateInfo(info)
			mo:setEmpty(false)
			table.insert(listMO, mo)
		end
	end

	self._useCount = msg.totalUseCount or 0

	self:setList(listMO)
	self:setCanUseShareCount(msg.canUseShareCount)
	self:setCanShareCount(msg.canShareCount)
end

function RoomLayoutModel:getUseCount()
	local listMO = self:getList()
	local count = 0

	for i, layoutMO in ipairs(listMO) do
		count = count + layoutMO:getUseCount()
	end

	return math.max(self._useCount, count)
end

function RoomLayoutModel:setCanShareCount(canShareCount)
	self._canShareCount = canShareCount or 0
end

function RoomLayoutModel:getCanShareCount()
	return self._canShareCount
end

function RoomLayoutModel:setCanUseShareCount(canUseShareCount)
	self._canUseShareCount = canUseShareCount or 0
end

function RoomLayoutModel:getCanUseShareCount()
	return self._canUseShareCount
end

function RoomLayoutModel:updateRoomPlanInfoReply(planInfo)
	local mo = self:getById(planInfo.id)

	if not mo then
		mo = RoomLayoutMO.New()

		mo:init(planInfo.id)
		self:addAtLast(mo)
	end

	mo:updateInfo(planInfo)
	mo:setEmpty(false)
end

function RoomLayoutModel:setVisitCopyName(name)
	self._visitCopyName = name
end

function RoomLayoutModel:getVisitCopyName()
	return self._visitCopyName
end

function RoomLayoutModel:getMaxPlanCount()
	return CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanMax)
end

local LuaLang_defaultname_Key = "room_layoutplan_default_name"

function RoomLayoutModel:findDefaultName()
	local defaultNames = RoomEnum.LayoutPlanDefaultNames
	local defaultKey = LuaLang_defaultname_Key
	local name = ""

	for _, str in ipairs(defaultNames) do
		name = formatLuaLang(defaultKey, str)

		if not self:isSameName(name) then
			return name
		end
	end

	return name .. math.random(1, 10)
end

function RoomLayoutModel:isSameName(name)
	local listMO = self:getList()

	for _, layoutMO in ipairs(listMO) do
		if layoutMO.name == name then
			return true
		end
	end

	return false
end

function RoomLayoutModel:_getPlayUnLockKey()
	local userId = PlayerModel.instance:getPlayinfo().userId

	return string.format("RoomLayoutModel_PLAY_UNLOCK_KEY_%s", userId)
end

function RoomLayoutModel:setPlayUnLock(isOn)
	self._isPlayUnLock = isOn and 1 or 0

	PlayerPrefsHelper.setNumber(self:_getPlayUnLockKey(), self._isPlayUnLock)
end

function RoomLayoutModel:getPlayUnLock()
	if self._isPlayUnLock == nil then
		self._isPlayUnLock = PlayerPrefsHelper.getNumber(self:_getPlayUnLockKey(), 0)
	end

	return self._isPlayUnLock == 1
end

function RoomLayoutModel:getLayoutCount()
	local count = 0
	local list = self:getList()

	if not list then
		return count
	end

	for _, mo in ipairs(list) do
		if not mo:isEmpty() then
			count = count + 1
		end
	end

	return count
end

function RoomLayoutModel:getCurrentUsePlanName()
	local list = self:getList()

	if not list then
		return ""
	end

	for _, mo in ipairs(list) do
		if mo:isUse() then
			return mo.name
		end
	end

	return ""
end

function RoomLayoutModel:getCurrentPlotBagData()
	local list = self:getList()

	if not list then
		return {}
	end

	for _, mo in ipairs(list) do
		if mo:isUse() then
			return self:getPlotBagData(mo)
		end
	end

	return {}
end

function RoomLayoutModel:getPlotBagData(mo)
	local plotList = {}
	local packageDict, roleBirthdayList = RoomLayoutHelper.findBlockInfos(mo.infos)

	for packageId, blockNum in pairs(packageDict) do
		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.BlockPackage, packageId)

		table.insert(plotList, {
			plot_name = config.name,
			plot_num = blockNum
		})
	end

	for i, blockId in ipairs(roleBirthdayList) do
		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.SpecialBlock, blockId)

		table.insert(plotList, {
			plot_num = 1,
			plot_name = config.name
		})
	end

	return plotList
end

function RoomLayoutModel:getSharePlanCount()
	local count = 0
	local list = self:getList()

	if not list then
		return count
	end

	for _, mo in ipairs(list) do
		if mo:isSharing() then
			count = count + 1
		end
	end

	return count
end

RoomLayoutModel.instance = RoomLayoutModel.New()

return RoomLayoutModel
