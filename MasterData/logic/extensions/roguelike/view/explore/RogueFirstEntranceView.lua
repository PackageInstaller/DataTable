-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueFirstEntranceView.lua

module("logic.extensions.roguelike.view.explore.RogueFirstEntranceView", package.seeall)

local M = class("RogueFirstEntranceView", ViewComponent)

function M:buildUI()
	self._btnTask = self:getBtn("rungroup_all_entry_view_2007345792")
	self._btnStore = self:getBtn("rungroup_all_entry_view_-1839425699")
	self._btnEquip = self:getBtn("rungroup_all_entry_view_-1100128642")
	self._btnRunGroup = self:getBtn("rungroup_all_entry_view_-60990508")
	self._btnMemory = self:getBtn("rungroup_all_entry_view_-701180860")
	self._txtWeeklyTask = self:getText("rungroup_all_entry_view_-78843910")
	self._txtMonthTask = self:getText("rungroup_all_entry_view_-71037291")
	self._txtScriptName = self:getText("rungroup_all_entry_view_-141750611")
	self._goTaskLock = self:getGo("rungroup_all_entry_view_-2073370855")
	self._goTaskNormal = self:getGo("rungroup_all_entry_view_-830032413")
	self._goStoreLock = self:getGo("rungroup_all_entry_view_-2025117169")
	self._goStoreNormal = self:getGo("rungroup_all_entry_view_-1648424464")
	self._goEquipLock = self:getGo("rungroup_all_entry_view_-1846168562")
	self._goEquipNormal = self:getGo("rungroup_all_entry_view_-397969198")
	self._rawRole = self:getUIComponent("rungroup_all_entry_view_482976464", UIComponentType.RawImage)
	self._photoCenterPointGo = self:getGo("rungroup_all_entry_view_7854136")
	self._photoUnit = PhotoUnit.Get(self._rawRole.gameObject)

	self._photoUnit:clear()

	self._goScriptNewSign = self:getGo("rungroup_all_entry_view_1631522610")
	self._runGroupRedPoint = goutil.findChild(self.mainGO, "task_entry/red_point")
end

function M:destroyUI()
	self._btnTask = nil
	self._btnStore = nil
	self._btnEquip = nil
	self._btnRunGroup = nil
	self._btnMemory = nil
	self._txtWeeklyTask = nil
	self._txtMonthTask = nil
	self._goTaskLock = nil
	self._goTaskNormal = nil
	self._goStoreLock = nil
	self._goStoreNormal = nil
	self._goEquipLock = nil
	self._goEquipNormal = nil
	self._rawRole = nil
	self._photoUnit = nil
	self._photoCenterPointGo = nil
end

function M:bindEvents()
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnStore:AddClickListener(self._onClickStore, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnRunGroup:AddClickListener(self._onClickRunGroup, self)
	self._btnMemory:AddClickListener(self._onClickMemory, self)
end

function M:unbindEvents()
	self._btnTask:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnRunGroup:RemoveClickListener()
	self._btnMemory:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	RoguelikeAgent.instance:sendGetAllEquipRequest()
	RoguelikeAgent.instance:sendListTaskRequest()
	RoguelikeAgent.instance:sendLoadInfoRequest()
	self:showScriptInfo()
	settimer(0.02, self._checkShowStory, self, false)
	RedDotModel.instance:createDotView({
		dotNode = self._runGroupRedPoint,
		keyList = {
			RedDotType.ERedDotKey.RUNGROUP_WEEK,
			RedDotType.ERedDotKey.RUNGROUP_MONTH,
			RedDotType.ERedDotKey.RUNGROUP_PERIOD
		}
	})
	settimer(0.02, function()
		RoguelikeModel.instance:checkRedPoint()
	end, self, false)
end

function M:_checkShowStory()
	local storyId = RoguelikeConfig.instance:getConstByName("FirstOpenViewStoryId").numValue
	local isPlay = RoguelikeConst.GetStoryPlayed(storyId)

	if not isPlay and storyId ~= 0 and RoguelikeConst.IsAllowStory(storyId) then
		StoryMgr.instance:startSingle(storyId, false, self._onPlotFinish, self)
		RoguelikeConst.SetStoryPlayed(storyId)
	end
end

function M:_onPlotFinish()
	return
end

function M:showScriptInfo()
	local scriptCo, isNew = RoguelikeUtil.instance:getLastExploreScripts()

	goutil.setActive(self._goScriptNewSign, isNew)

	if scriptCo then
		self._txtScriptName.text = scriptCo.name
	else
		self._txtScriptName.text = ""
	end
end

function M:showRole()
	local modelId = 100044
	local transform = self._photoCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._photoUnit,
		modelId = modelId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
end

function M:onExit()
	self:setEvent(false)
	removetimer(self._checkShowStory, self)

	if self._photoUnit then
		self._photoUnit:clear()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_GET_ALL_ROGUE_EQUIP, self._onGetRogueEquip, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_GET_ALL_TASK, self._onGetRogueTask, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GET_ALL_ROGUE_EQUIP, self._onGetRogueEquip, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GET_ALL_TASK, self._onGetRogueTask, self)
	end
end

function M:_onClickTask()
	self._curTaskMos = self._curTaskMos or {}

	if #self._curTaskMos == 0 then
		FloatWordMgr.instance:show(lang("tip_r_not_task"))

		return
	end

	ViewMgr.instance:open(ViewName.RogueTaskMain)
end

function M:_onClickStore()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Store, true) then
		return
	end

	local storeId = 180001
	local goodsId

	StoreAgent.instance:reqJumpTo(storeId, goodsId)
end

function M:_onClickEquip()
	if ViewMgr.instance:isOpen(ViewName.RogueEquipMain2) then
		ViewMgr.instance:close(ViewName.RogueEquipMain2)
	end

	local equips = RoguelikeModel.instance:getEquipMOS() or {}

	if #equips == 0 and not RoguelikeConst.IsGuildMode() then
		FloatWordMgr.instance:show(lang("tip_r_not_equip"))

		return
	end

	ViewMgr.instance:open(ViewName.RogueEquipMain2)
end

function M:_onClickRunGroup()
	ViewMgr.instance:open(ViewName.RogueEntrance)
end

function M:_onClickMemory()
	ViewMgr.instance:open(ViewName.RogueMemoryEntry)
end

function M:_onGetRogueEquip(sender, equips)
	if #equips == 0 then
		-- block empty
	end
end

function M:_onGetRogueTask(sender, tasks)
	self._curTaskMos = tasks

	if #tasks == 0 then
		self._txtWeeklyTask.text = lang("tip_r_task_weekly") .. "0/0"
		self._txtMonthTask.text = lang("tip_r_task_month") .. "0/0"
	else
		local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueWeekly)

		if tabId then
			local curTaskList = TaskModel.instance:getTaskList(tabId)
			local count = TaskUtil.getFinishCount(curTaskList)

			self._txtWeeklyTask.text = lang("tip_r_task_weekly") .. (count == 0 and string.format("%d/%d", count, #curTaskList) or string.format("<color=#bf404a>%d</color>/%d", count, #curTaskList))
		end

		tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.RogueMonthly)

		if tabId then
			local curTaskList = TaskModel.instance:getTaskList(tabId)
			local count = TaskUtil.getFinishCount(curTaskList)

			self._txtMonthTask.text = lang("tip_r_task_month") .. (count == 0 and string.format("%d/%d", count, #curTaskList) or string.format("<color=#bf404a>%d</color>/%d", count, #curTaskList))
		else
			self._txtMonthTask.text = ""
		end

		goutil.setActive(self._txtMonthTask.gameObject, tabId)
	end
end

return M
