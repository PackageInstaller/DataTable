-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorUpgradeView.lua

module("logic.extensions.supervisor.view.SupervisorUpgradeView", package.seeall)

local M = class("SupervisorUpgradeView", ViewComponent)
local kCostNum = 3

function M:ctor()
	M.super.ctor(self)

	self._arrayUnlockCell = {}
end

function M:buildUI()
	local dynIcon = Astral.ImageDynIcon.Get(self:getGo("facility_yield_upgrade_tips_-1510312179"))

	dynIcon:SetImage("ui/bigbg/room/room_yield/zzc_mb_01.png")

	self._txtTitle = self:getText("facility_yield_upgrade_tips_-1138924223")
	self._txtCurrLv = self:getText("facility_yield_upgrade_tips_-693663454")
	self._txtNextLv = self:getText("facility_yield_upgrade_tips_-1438160327")
	self._btnUpgrade = self:getBtn("facility_yield_upgrade_tips_-100353727")
	self._btnClose = self:getBtn("small_tips_common_bg_1276053964")
	self._goCanUpgrade = self:getGo("facility_yield_upgrade_tips_-1835321372")
	self._goNotUpgrade = self:getGo("facility_yield_upgrade_tips_-1356393230")
	self._goUnlockContent = self:getGo("facility_yield_upgrade_tips_1150977453")

	local costContentGO = self:getGo("facility_yield_upgrade_tips_83933318")

	self._arrayCostItem = {}

	for i = 1, kCostNum do
		local costItem = {}

		costItem.goRoot = goutil.findChild(costContentGO, string.format("expend%s", i))
		costItem.imgIcon = goutil.findChildImageComponent(costItem.goRoot, "imgIcon")
		costItem.txtNum = goutil.findChildTextComponent(costItem.goRoot, "txtValue")

		table.insert(self._arrayCostItem, costItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnUpgrade:AddClickListener(self._onClickBtnUpgrade, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
	end
end

function M:onEnter()
	self:initViews()
	self:refreshViews()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
	self:clearUnlockCells()
end

function M:initViews()
	self._txtTitle.text = lang("tip_supervisor_lang_1")
end

function M:refreshViews()
	local maxLv = SupervisorConfig.instance:getMaxLv()
	local currLv = SupervisorModel.instance:getSupervisorLv()

	self._txtCurrLv.text = string.format("Lv.%s", currLv)
	self._txtNextLv.text = string.format("Lv.%s", currLv + 1)

	local canUpgrade = SupervisorModel.instance:canUpgradeLv(false)

	goutil.setActive(self._goCanUpgrade, canUpgrade)
	goutil.setActive(self._goNotUpgrade, not canUpgrade)

	local cfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, currLv)
	local costList = cfg.cost or {}

	for i, costItem in ipairs(self._arrayCostItem) do
		local costInfo = costList[i]

		if costInfo then
			goutil.setActive(costItem.goRoot, true)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(costInfo.id)

			IconLoader.setSprite(costItem.imgIcon, IconType.ItemIcon, itemCo.icon)

			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)
			local numColor = ownCount >= costInfo.num and "#B3B3B3" or "#FF3E48"

			costItem.txtNum.text = costInfo.num
			costItem.txtNum.color = parsecolor(numColor)
		else
			goutil.setActive(costItem.goRoot, false)
		end
	end

	self:refreshUnlockCells()
end

function M:refreshUnlockCells()
	self:clearUnlockCells()

	local maxLv = SupervisorConfig.instance:getMaxLv()
	local currLv = SupervisorModel.instance:getSupervisorLv()

	if currLv < maxLv then
		local currLvCfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, currLv)
		local nextLvCfg = SupervisorConfig.instance:getConfigByKey(ConfigName.HouseManager, currLv + 1)

		if not string.nilorempty(currLvCfg.upgradeDesc) then
			self:_createDescUnlockCell(currLvCfg.upgradeDesc)
		end

		if nextLvCfg.jobCount > currLvCfg.jobCount then
			self:_createJobUnlockCell(nextLvCfg.jobCount)
		end

		local shelterRoomUnlockAdd = nextLvCfg.holdRoomCount - currLvCfg.holdRoomCount
		local smallRoomUnlockAdd = nextLvCfg.smallZoneCount - currLvCfg.smallZoneCount
		local bigRoomUnlockAdd = nextLvCfg.bigZoneCount - currLvCfg.bigZoneCount

		self:_createRoomUnlockCell(shelterRoomUnlockAdd, smallRoomUnlockAdd, bigRoomUnlockAdd)
	end
end

function M:_createUnlockCell()
	local cellGO = self:getResInstance(ResName.Room_facility_yield_unlock_cell)
	local unlockCell = Astral.LuaComponentContainer.Add(cellGO, RoomUnlockCell)

	goutil.addChildToParent(cellGO, self._goUnlockContent)
	table.insert(self._arrayUnlockCell, unlockCell)

	return unlockCell
end

function M:_createDescUnlockCell(descStr)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_supervisor_lang_7"))
	unlockCell:setDescription(true, descStr)
	unlockCell:setOrders(false)
end

function M:_createJobUnlockCell(jobIndex)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_supervisor_lang_8"))
	unlockCell:setDescription(false)

	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Supervisor]
	local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCodeList[jobIndex])
	local data = {}

	data.nameStr = cfg.jobName
	data.iconType = IconType.HouseCompile
	data.iconName = cfg.icon

	unlockCell:setOrders(true, {
		data
	})
end

function M:_createRoomUnlockCell(shelterRoomUnlockAdd, smallRoomUnlockAdd, bigRoomUnlockAdd)
	local dataList = {}

	if shelterRoomUnlockAdd > 0 then
		local data = {}

		data.nameStr = string.format(lang("tip_supervisor_lang_9"), shelterRoomUnlockAdd)
		data.iconType = IconType.HouseWorkShop
		data.iconName = "room_workshop1"

		table.insert(dataList, data)
	end

	if smallRoomUnlockAdd > 0 then
		local data = {}

		data.nameStr = string.format(lang("tip_supervisor_lang_10"), smallRoomUnlockAdd)
		data.iconType = IconType.HouseWorkShop
		data.iconName = "room_workshop2"

		table.insert(dataList, data)
	end

	if bigRoomUnlockAdd > 0 then
		local data = {}

		data.nameStr = string.format(lang("tip_supervisor_lang_11"), bigRoomUnlockAdd)
		data.iconType = IconType.HouseWorkShop
		data.iconName = "room_workshop3"

		table.insert(dataList, data)
	end

	if #dataList > 0 then
		local unlockCell = self:_createUnlockCell()

		unlockCell:setTitle(lang("tip_supervisor_lang_12"))
		unlockCell:setDescription(false)
		unlockCell:setOrders(true, dataList)
	end
end

function M:clearUnlockCells()
	for _, cell in ipairs(self._arrayUnlockCell) do
		goutil.destroy(cell:getMainGO())
	end

	self._arrayUnlockCell = {}
end

function M:_onClickBtnUpgrade()
	if SupervisorModel.instance:canUpgradeLv(true) then
		SupervisorAgent.instance:sendManagerLevelUpRequest()
		self:close()
	end
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onSupervisorInfoReply()
	self:refreshViews()
end

function M:_onSupervisorInfoChange()
	self:refreshViews()
end

return M
