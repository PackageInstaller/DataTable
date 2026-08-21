-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineActivityView.lua

module("logic.extensions.dungeon.view.mainline.MainlineActivityView", package.seeall)

local M = class("MainlineActivityView", ViewComponent)
local activityId = 100001

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtContent")
	self._btnClick = UIComponentType.ButtonAdapter(self.mainGO)

	self._btnClick:AddClickListener(self._onClickJump, self)

	self._redPoint = goutil.findChild(self.mainGO, "red_point")
	self._taskList = ActivityTaskConfig.instance:getTaskConfByActivityId(activityId)

	self:_setEvent(true)
end

function M:refresh(chapterId)
	TaskAgent.instance:sendListTaskRequest(TaskEnum.TaskLabel.ChapterReward)

	self._chapterId = chapterId
end

function M:_onTaskRefresh()
	chapterId = self._chapterId

	local taskList = ActTaskRewardModel.instance:getTaskList(activityId)
	local cfgChapter = DungeonConfig.instance:getCfgMainLineByChapterId(chapterId)
	local dungeons = {}

	goutil.setActive(self.mainGO, false)

	for _, chapter in ipairs(cfgChapter) do
		for _, dungeonId in ipairs(chapter.dungeonIds) do
			table.insert(dungeons, dungeonId)
		end
	end

	local isShowRedPoint = false

	for _, task in ipairs(taskList) do
		if TableUtil.contains(dungeons, tonumber(task._param)) then
			self._txtContent.text = task:getText()
			isShowRedPoint = isShowRedPoint or task:canGetReward()

			goutil.setActive(self.mainGO, not task:getIsFinish())
		end
	end

	goutil.setActive(self._redPoint, isShowRedPoint)

	if #taskList == 0 and self._taskList[1] then
		local taskDesc = TaskUtil.parseContent(self._taskList[1].content, self._taskList[1].param)

		self._txtContent.text = self._taskList[1].text ~= "" and self._taskList[1].text or taskDesc

		goutil.setActive(self.mainGO, true)
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ACT_REWARD_TASK_REFRESH, self._onTaskRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ACT_REWARD_TASK_REFRESH, self._onTaskRefresh, self)
	end
end

function M:_onClickJump()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.ChapterReward, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, 80100001)
end

function M:destroyUI()
	self:_setEvent(false)
	self._btnClick:RemoveClickListener()
end

return M
