-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingDeviceUpgradeView.lua

module("logic.extensions.trading.view.TradingDeviceUpgradeView", package.seeall)

local UpgradeConsumeItem = class("UpgradeConsumeItem")

function UpgradeConsumeItem:ctor(compContainer)
	self._go = compContainer.gameObject
	self._txtCount = goutil.findChildTextComponent(self._go, "txtNum")
end

function UpgradeConsumeItem:updateData(data)
	self._txtCount.text = data.count
end

local M = class("TradingDeviceUpgradeView", ViewComponent)
local kCostNum = 3

function M:ctor()
	M.super.ctor(self)

	self._arrayUnlockCell = {}
end

function M:buildUI()
	local dynIcon = Astral.ImageDynIcon.Get(self:getGo("facility_yield_upgrade_tips_-1510312179"))

	dynIcon:SetImage("ui/bigbg/room/room_yield/zzc_mb_02.png")

	self._txtDeviceName = self:getText("facility_yield_upgrade_tips_-1138924223")
	self._txtLevelOrigin = self:getText("facility_yield_upgrade_tips_-693663454")
	self._txtLevelNext = self:getText("facility_yield_upgrade_tips_-1438160327")
	self._btnUpgrade = self:getBtn("facility_yield_upgrade_tips_-100353727")
	self._btnClose = self:getBtn("small_tips_common_bg_1276053964")
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
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:updateData()
end

function M:onExit()
	return
end

function M:onExitFinished()
	self:setEvent(false)
end

function M:updateData()
	local mo = TradingModel.instance:getTradePostMo()

	self:clearUnlockCells()
	self:_createDescUnlockCell(mo:getUpgradeDesc())

	self._txtLevelOrigin.text = string.format("Lv.%d", mo:getLevel())
	self._txtLevelNext.text = string.format("Lv.%d", mo:getLevel() + 1)

	local co = TradingConfig.instance:getHouseCoByLevel(mo:getLevel())
	local nextCo = TradingConfig.instance:getHouseCoByLevel(mo:getLevel() + 1)

	if nextCo == nil then
		self._txtLevelNext.text = lang("tip_level_full")
	else
		local curUnlockOrder = co.unlockOrder
		local nextUnlockOrder = nextCo.unlockOrder

		if curUnlockOrder ~= nextUnlockOrder then
			-- block empty
		end

		local curJobCount = co.jobCount
		local nextJobCount = nextCo.jobCount

		if curJobCount ~= nextJobCount then
			self:_createJobUnlockCell(nextJobCount)
		end
	end

	self._isMaxLevel = nextCo == nil
	self._txtDeviceName.text = co.name

	local costList = co.cost or {}

	for i, costItem in ipairs(self._arrayCostItem) do
		local costInfo = costList[i]

		if costInfo then
			goutil.setActive(costItem.goRoot, true)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(costInfo.id)

			IconLoader.setSprite(costItem.imgIcon, IconType.ItemIcon, itemCo.icon)

			costItem.txtNum.text = costInfo.num
		else
			goutil.setActive(costItem.goRoot, false)
		end
	end
end

function M:clearUnlockCells()
	for _, cell in ipairs(self._arrayUnlockCell) do
		goutil.destroy(cell:getMainGO())
	end

	self._arrayUnlockCell = {}
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

	unlockCell:setTitle(lang("tip_up_result"))
	unlockCell:setDescription(true, descStr)
	unlockCell:setOrders(false)
end

function M:_createJobUnlockCell(jobIndex)
	local unlockCell = self:_createUnlockCell()

	unlockCell:setTitle(lang("tip_unlock_team"))
	unlockCell:setDescription(false)

	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Trading]
	local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCodeList[jobIndex])
	local data = {}

	data.nameStr = cfg.jobName

	unlockCell:setOrders(true, {
		data
	})
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickUpgrade()
	if self._isMaxLevel then
		FloatWordMgr.instance:show(lang("tip_current_level_full"))

		return
	end

	if TradingModel.instance:canUpgradeLv(true) then
		self:close()
		TradingAgent.instance:sendTradePostLevelUpRequest()
	end
end

function M:_onClickClose()
	self:close()
end

return M
