-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseJobAdjustCell.lua

module("logic.extensions.houseworker.view.HouseJobAdjustCell", package.seeall)

local M = class("HouseJobAdjustCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._roleCompList = {}
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._jobNameTxt = goutil.findChildTextComponent(self._go, "normal/Content1/txtHint1")
	self._rolePanelGoList = {}
	self._rolePanelGoList[1] = goutil.findChild(self._go, "normal/Content1/roleList/role_arrange_item1")
	self._rolePanelGoList[2] = goutil.findChild(self._go, "normal/Content1/roleList/role_arrange_item2")
	self._rolePanelGoList[3] = goutil.findChild(self._go, "normal/Content1/roleList/role_arrange_item3")

	for i, v in ipairs(self._rolePanelGoList) do
		goutil.setActive(v, true)
	end

	self._lockGo = goutil.findChild(self._go, "lock")
	self._lockJobTxt = goutil.findChildTextComponent(self._go, "lock/txtCareer")
	self._lockLevelTxt = goutil.findChildTextComponent(self._go, "lock/txtUnlock")
	self._arrangeTimePanelGo = goutil.findChild(self._go, "normal/Content1/scheduleShow")
	self._holidayBtnGo = goutil.findChild(self._go, "normal/Content1/btnHoliday")
	self._shedulePanelGo = goutil.findChild(self._go, "normal/schedule_time_item")
	self._scheduleTimeItemView = Astral.LuaComponentContainer.Add(self._shedulePanelGo, HouseScheduleItem)
	self._adjustBtn = ButtonAdapter.Get(goutil.findChild(self._go, "normal/schedule_time_item/btnAdjust"))
	self._holidayBtn = ButtonAdapter.Get(self._holidayBtnGo)

	self._adjustBtn:AddClickListener(self._onClickAdjustSchedule, self)
	self._holidayBtn:AddClickListener(self._onClickHolidayBtn, self)
	goutil.setActive(self._arrangeTimePanelGo, false)
	goutil.setActive(self._holidayBtnGo, false)
end

function M:setData(workerData)
	self._workerCo = workerData
	self._roomId = workerData.zoneId
	self._jobNameTxt.text = self._workerCo.jobName

	self:_refreshCell()
end

function M:setHolidayBtnStatus(status)
	goutil.setActive(self._holidayBtnGo, false)
end

function M:_refreshCell()
	local isUnlock = HouseWorkerModel.instance:getIfJobUnlock(self._workerCo.jobCode)

	goutil.setActive(self._lockGo, not isUnlock)

	if not isUnlock then
		self._lockJobTxt.text = self._workerCo.jobName

		local unlockLevel = HouseWorkerModel.instance:getUnlockConditionByRoomTypeAndIndex(self._workerCo.roomType, self._workerCo.indexInRoom)

		self._lockLevelTxt.text = string.format("%s Lv.%d", self._workerCo.roomName, unlockLevel)
	end

	if #self._roleCompList == 0 then
		for i, v in ipairs(self._rolePanelGoList) do
			local shower = Astral.LuaComponentContainer.Add(v, HouseWorkerRoleCell)

			shower:setJobCodeAndIndex(self._workerCo.jobCode, i)
			shower:setClickCallBack(self._onClickHero, self)
			shower:refreshCell()

			self._roleCompList[i] = shower
		end
	else
		for i, v in ipairs(self._roleCompList) do
			v:setJobCodeAndIndex(self._workerCo.jobCode, i)
			v:refreshCell()
		end
	end

	self._scheduleTimeItemView:onEnter()
	self._scheduleTimeItemView:setCanEdit(false)

	local jobScheduleList = HouseWorkerModel.instance:getScheduleByJob(self._workerCo.jobCode)
	local workSchedule = {}
	local heroList = {}

	for i = 1, 24 do
		workSchedule[i] = 0
	end

	for i = 1, 3 do
		heroList[i] = 0
	end

	for i, v in ipairs(jobScheduleList) do
		heroList[v.index] = v.hero

		for time, workStatus in ipairs(v.schedule) do
			if workStatus == HouseEnum.WorkStatus.Work then
				workSchedule[time] = v.index
			end
		end
	end

	self._scheduleTimeItemView:setScheduleList(workSchedule, heroList)
end

function M:_onClickHero(jobCode, index)
	local info = {}

	info.jobCode = jobCode
	info.index = index
	info.maxSelectPerson = 3
	info.openType = HouseEnum.OpenType.Job

	GlobalDispatcher:addEventListener(EventType.HOUSE_HERO_SELECT_ENSURE, self._sendJobHeroChangeRequest, self)
	ViewMgr.instance:open(ViewName.JobWorkerSelect, info)
end

function M:_sendJobHeroChangeRequest(_, heroList)
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HERO_SELECT_ENSURE, self._sendJobHeroChangeRequest, self)
	HouseAgent.instance:SendJobHeroChangeRequest(self._workerCo.jobCode, heroList)
end

function M:OnDestroy()
	self._adjustBtn:RemoveClickListener()
	self._holidayBtn:RemoveClickListener()
end

function M:_onClickAdjustSchedule()
	local info = {}

	info.jobCode = self._workerCo.jobCode

	ViewMgr.instance:open(ViewName.JobScheduleAdjustTips, info)
end

function M:_onClickHolidayBtn()
	local info = {}

	info.jobCode = self._workerCo.jobCode

	ViewMgr.instance:open(ViewName.JobHolidayAdjustTips, info)
end

return M
