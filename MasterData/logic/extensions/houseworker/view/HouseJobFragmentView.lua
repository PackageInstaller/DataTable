-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseJobFragmentView.lua

module("logic.extensions.houseworker.view.HouseJobFragmentView", package.seeall)

local M = class("HouseJobFragmentView", DynamicFragmentView)

function M:buildUI()
	self._personCountTxt = self._registry:findUIElement("job_settled_panel_-1452500953", UIComponentType.Text)
	self._schedulePreviewButton = self._registry:findUIElement("job_settled_panel_-1333257525", UIComponentType.ButtonAdapter)
	self._jobCellGo = self._registry:findUIElement("job_settled_panel_2121597035")
	self._jobContentGo = self._registry:findUIElement("job_settled_panel_-1603052163")
end

function M:bindEvents()
	self._schedulePreviewButton:AddClickListener(self._openScheduleView, self)
end

function M:unbindEvents()
	self._schedulePreviewButton:RemoveClickListener()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._updateJobPanel, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
	GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._updateJobPanel, self)
end

function M:_onMoodUpdate()
	self:_updateJobPanel()
end

function M:onEnter()
	self:_initJobPanel()
	self:_bindEvents()
	HouseAgent.instance:sendGetHeroFeatureRequest()
	self:_updateJobPanel()
end

function M:_initJobPanel()
	if not self._jobCellViewList then
		self._jobCellViewList = {}

		local roomConfigList = HouseWorkerModel.instance:getAllUnlockRoomConfig()

		for i, v in ipairs(roomConfigList) do
			local jobRoom = goutil.clone(self._jobCellGo)

			goutil.setActive(jobRoom, true)
			goutil.addChildToParent(jobRoom, self._jobContentGo)

			self._jobCellViewList[i] = Astral.LuaComponentContainer.Add(jobRoom, HouseJobHeroConditionCell)

			self._jobCellViewList[i]:initByConfigData(v, i)
			self._jobCellViewList[i]:setClickCallBack(self._onClickJobPanel, self)
		end
	else
		for i, v in ipairs(self._jobCellViewList) do
			v:_bindEvents(self._onClickJobPanel, self)
		end
	end
end

function M:_updateJobPanel()
	for i, v in ipairs(self._jobCellViewList) do
		v:_updatePanel()
	end

	local jobCount = 0
	local roomConfigList = HouseWorkerModel.instance:getAllUnlockRoomConfig()

	for i, jobConfigDataList in ipairs(roomConfigList) do
		local count = 0

		for _, jobConfig in ipairs(jobConfigDataList) do
			if HouseWorkerModel.instance:getIfJobCanSettled(jobConfig.jobCode) then
				count = count + 1
			end
		end

		jobCount = jobCount + count
	end

	local scheduleWithHeroList = HouseWorkerModel.instance:getAllScheduleWithHero()

	self._personCountTxt.text = string.format(lang("tip_job_schedule_adjust_3"), #scheduleWithHeroList, jobCount * 3)
end

function M:_onClickJobPanel(roomIndex, clickIndex)
	local info = {}

	info.roomIndex = roomIndex
	info.clickIndex = clickIndex

	ViewMgr.instance:open(ViewName.JobDetail, info)
end

function M:_openScheduleView()
	ViewMgr.instance:open(ViewName.HouseJobAdjust)
end

function M:onExit()
	self:_unbindEvents()

	for i, v in ipairs(self._jobCellViewList) do
		v:_onExit()
	end
end

return M
