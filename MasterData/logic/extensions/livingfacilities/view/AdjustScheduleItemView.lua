-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/AdjustScheduleItemView.lua

module("logic.extensions.livingfacilities.view.AdjustScheduleItemView", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("AdjustScheduleItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._minuteTimer = SchedulerCtrl.New(self._refreshPerMinute, self)
end

function M:Awake()
	self:_initSheduleItems()

	local registry = self._viewElementsRegistry

	self._txtBedName = registry:findUIElement("adjust_schedule_item_-117688393", UIComponentType.Text)
	self._txtPosName = registry:findUIElement("adjust_schedule_item_242828288", UIComponentType.Text)

	goutil.setActive(self._txtPosName.gameObject, true)

	self._roleItemGo = registry:findUIElement("role_arrange_item1_-863836422")
	self._roleItemView = Astral.LuaComponentContainer.Add(self._roleItemGo, HouseWorkerRoleCell)
	self._btnHoliday = ButtonAdapter.Get(registry:findUIElement("adjust_schedule_item_1988052790"))

	goutil.setActive(self._btnHoliday.gameObject, false)

	self._scheduleTimeItemGo = registry:findUIElement("7&schedule_time_item_1192295968")
	self._scheduleTimeItemView = Astral.LuaComponentContainer.Add(self._scheduleTimeItemGo, LivingScheduleTimeItemView)
	self._btnAdjust = ButtonAdapter.Get(registry:findUIElement("7&schedule_time_item_1226094445"))

	local txtAdjust = goutil.findChildTextComponent(self._btnAdjust.gameObject, "Text")

	txtAdjust.text = lang("tip_adjust_schedule")
	self._normalGo = registry:findUIElement("adjust_schedule_item_638930260")
	self._noneGo = registry:findUIElement("adjust_schedule_item_-241035935")

	goutil.setActive(registry:findUIElement("1&role_arrange_item1_-863836422"), false)
	goutil.setActive(registry:findUIElement("2&role_arrange_item1_-863836422"), false)

	local scheduleGO = goutil.findChild(self._go, "normal/Content1/scheduleShow")

	goutil.setActive(scheduleGO, true)

	self._goPos = goutil.findChild(self._go, "normal/Content1/bunk")
	self._txtPos = goutil.findChildTextComponent(self._goPos, "txtBunk")
end

function M:_initSheduleItems()
	self._scheduleList = {}

	local workStatus = HouseEnum.WorkStatus

	self:_AddSheduleItem(workStatus.Sleep, "3&schedule_show_item_-1487730064")
	self:_AddSheduleItem(workStatus.Eat, "4&schedule_show_item_-1487730064")
	self:_AddSheduleItem(workStatus.Work, "5&schedule_show_item_-1487730064")
	self:_AddSheduleItem(workStatus.Rest, "6&schedule_show_item_-1487730064")
end

function M:_AddSheduleItem(workType, key)
	local sheduleItem = {}
	local itemGo = self._viewElementsRegistry:findUIElement(key)
	local sheduleRegistry = ViewElementsRegistry.New(itemGo)

	sheduleItem.timeText = sheduleRegistry:findUIElement("schedule_show_item_1138090368", UIComponentType.Text)
	sheduleItem.selectGo = sheduleRegistry:findUIElement("schedule_show_item_1241143300")
	self._scheduleList[workType] = sheduleItem
end

function M:_clickHoliday()
	return
end

function M:_clickAdjust()
	local luaTable = {}

	luaTable.type = 2
	luaTable.data = self._data

	ViewMgr.instance:open(ViewName.LivingAdjustScheduleTip, luaTable)
end

function M:setCellData(data, index, zoneMo)
	self._btnHoliday:AddClickListener(self._clickHoliday, self)
	self._btnAdjust:AddClickListener(self._clickAdjust, self)

	self._data = data
	self._index = index
	self._zoneMo = zoneMo
	self._txtBedName.text = ""

	if self._data then
		goutil.setActive(self._normalGo, true)
		goutil.setActive(self._noneGo, false)
		self._roleItemView:setClickCallBack(self._clickRoleItem, self)
		self._roleItemView:setAddStatus(true)
		self._scheduleTimeItemView:needShowTimeIdx(true)
		self._scheduleTimeItemView:showCurShedule(true)
		self._scheduleTimeItemView:onEnter()
		self._scheduleTimeItemView:setCanEdit(false)
		self._scheduleTimeItemView:setUnClickTypeList({
			HouseEnum.WorkStatus.Work
		})

		local heroId = self._data.heroId

		if heroId > 0 then
			local scheduleNO = HouseWorkerModel.instance:getScheduleByHeroId(heroId)
			local timeList = LivingFacilitiesZoneController.instance:getScheduleTimeList(scheduleNO.schedule)

			for i, scheduleItem in ipairs(self._scheduleList) do
				scheduleItem.timeText.text = langF("tip_work_s", timeList[i] or 0)
			end

			self._scheduleTimeItemView:setScheduleList(scheduleNO.schedule)
		else
			for i, scheduleItem in ipairs(self._scheduleList) do
				scheduleItem.timeText.text = langF("tip_work_s", 0)
			end

			self._scheduleTimeItemView:setScheduleList()
		end

		goutil.setActive(self._btnAdjust.gameObject, heroId > 0)
		self._roleItemView:setHero(heroId)
		self._roleItemView:refreshCell()

		local furnCfg = self._data:getFurnitureCfg()

		self._txtBedName.text = furnCfg.name

		self:_refreshPosName()
		self:_refreshScheduleStatus()
	else
		goutil.setActive(self._normalGo, false)
		goutil.setActive(self._noneGo, true)
	end
end

function M:_refreshPosName()
	if self._zoneMo:getHeroCount() == 1 then
		self._txtPosName.text = ""

		goutil.setActive(self._goPos, false)
	else
		self._txtPosName.text = HouseEnum.DormBedPosName[self._index]

		goutil.setActive(self._goPos, true)

		self._txtPos.text = self._index
	end
end

function M:_refreshScheduleStatus()
	local hasHero = self._data.heroId > 0
	local curWorkStatus

	if hasHero then
		curWorkStatus = HouseSceneUtil.getWorkStatusByHeroId(self._data.heroId)
	end

	for workStatus, scheduleItem in pairs(self._scheduleList) do
		goutil.setActive(scheduleItem.selectGo, hasHero and workStatus == curWorkStatus)
	end
end

function M:_clickRoleItem()
	local bunks = self._zoneMo:getBunkList()
	local info = {
		clickIndex = self._index,
		maxSelectPerson = #bunks,
		bunkList = bunks,
		openType = HouseEnum.OpenType.Dorm,
		zoneId = self._zoneMo:getId()
	}

	ViewMgr.instance:open(ViewName.JobWorkerSelect, info)
end

function M:_refreshPerMinute()
	self:_refreshScheduleStatus()
end

function M:onEnter()
	self._minuteTimer:restart(60, true)
end

function M:onExit()
	self._btnHoliday:RemoveClickListener()
	self._btnAdjust:RemoveClickListener()
	self._scheduleTimeItemView:onExit()
	self._minuteTimer:stop()
end

function M:onDestroy()
	self._btnHoliday = nil
	self._btnAdjust = nil

	self._scheduleTimeItemView:OnDestroy()

	self._scheduleTimeItemView = nil
	self._data = nil
	self._index = nil
	self._txtBedName = nil
	self._txtPosName = nil
	self._roleItemGo = nil

	self._roleItemView:OnDestroy()

	self._roleItemView = nil
	self._scheduleList = nil

	self._minuteTimer:clear()

	self._minuteTimer = nil
end

return M
