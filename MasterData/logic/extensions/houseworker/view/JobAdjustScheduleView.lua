-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobAdjustScheduleView.lua

module("logic.extensions.houseworker.view.JobAdjustScheduleView", package.seeall)

local M = class("JobAdjustScheduleView", ViewComponent)
local RoomType = HouseEnum.RoomType

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._roomNameTxt = self:getTextByPath("content1/name/txtHint2")
	self._roomLevelTxt = self:getTextByPath("content1/level/txtLevel")
	self._personCountTxt = self:getText("room_adjust_schedule_view2_-317702612")
	self._adjustScheduleBtnGo = self:getGo("room_adjust_schedule_view2_1015058094")

	goutil.setActive(self._adjustScheduleBtnGo, false)

	self._loopListHelper = LoopListHelper.New(self:getGo("room_adjust_schedule_view2_-1037029159"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._mapBgImg = {
		[RoomType.Supervisor] = self:getGoByPath("bg/zhuguanshi"),
		[RoomType.Trading] = self:getGoByPath("bg/maoyizhan"),
		[RoomType.Manufacturing] = self:getGoByPath("bg/zhizaochang"),
		[RoomType.Shelter] = self:getGoByPath("bg/shourongshi"),
		[RoomType.Living] = self:getGoByPath("bg/sushe")
	}
	self._mapIconImg = {
		[RoomType.Supervisor] = self:getGoByPath("content1/facility_icon/zhuguanshi"),
		[RoomType.Trading] = self:getGoByPath("content1/facility_icon/maoyizhan"),
		[RoomType.Manufacturing] = self:getGoByPath("content1/facility_icon/zhizaochang"),
		[RoomType.Living] = self:getGoByPath("content1/facility_icon/sushe")
	}
	self._hintGo = self:getGo("room_adjust_schedule_view2_-124512097")

	goutil.setActive(self._hintGo, false)
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnHome = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshRightView, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshRightView, self)
end

function M:onEnter()
	self:_bindEvents()

	self._roomIndex = self:getFirstParam()

	self:_initStaticInfo()
	self:_initRightView()
end

function M:_initStaticInfo()
	local cfgCoList = HouseWorkerModel.instance:getRoomConfigByIndex(self._roomIndex)

	self._jobCoList = cfgCoList
	self._scheduleCoList = {}

	for i, v in ipairs(self._jobCoList) do
		for i = 1, 3 do
			local jobTable = {}

			jobTable.jobCo = v
			jobTable.workerIndex = i

			table.insert(self._scheduleCoList, jobTable)
		end
	end

	self._roomNameTxt.text = self._jobCoList[1].roomName
	self._roomLevelTxt.text = string.format("Lv.%d", HouseWorkerModel.instance:getLevelByHouseType(self._jobCoList[1].roomType))

	local roomType = self._jobCoList[1].roomType

	for type, bg in pairs(self._mapBgImg) do
		goutil.setActive(bg, type == roomType)
	end

	for type, icon in pairs(self._mapIconImg) do
		goutil.setActive(icon, type == roomType)
	end
end

function M:onExit()
	self:_unbindEvents()
	self._loopListHelper:ClearCells()
end

function M:_initRightView()
	self._loopListHelper:SetListItemCount(#self._scheduleCoList, true)
	self:_refreshRightView()
	self._loopListHelper:MoveToItemIndex(0)
end

function M:_refreshRightView()
	self._loopListHelper:RefreshAllShownItem()

	local personCount = 0
	local unlockJobCount = 0

	for i, v in ipairs(self._jobCoList) do
		if HouseWorkerModel.instance:getIfJobCanSettled(v.jobCode) then
			unlockJobCount = unlockJobCount + 1
		end

		local jobDataList = HouseWorkerModel.instance:getScheduleByJob(v.jobCode)

		for j, jobData in ipairs(jobDataList) do
			if jobData.hero and jobData.hero > 0 then
				personCount = personCount + 1
			end
		end
	end

	self._personCountTxt.text = string.format("%d/%d", personCount, unlockJobCount * 3)
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._scheduleCoList[curIndex]
	local item = self._loopListHelper:NewListViewItem("adjust_schedule_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, JobScheduleAdjustCell)

	shower:setData(itemData.jobCo, itemData.workerIndex)

	return item
end

return M
