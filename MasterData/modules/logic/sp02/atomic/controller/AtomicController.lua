-- chunkname: @modules/logic/sp02/atomic/controller/AtomicController.lua

module("modules.logic.sp02.atomic.controller.AtomicController", package.seeall)

local AtomicController = class("AtomicController", BaseController)

function AtomicController:onInit()
	return
end

function AtomicController:onInitFinish()
	return
end

function AtomicController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._onDailyRefresh, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onStoryFinished, self)
end

function AtomicController:reInit()
	return
end

function AtomicController:_onDailyRefresh()
	local isActOpen = ActivityHelper.isOpen(VersionActivity3_10Enum.ActivityId.Outside)

	if not isActOpen then
		return
	end

	AtomicRpc.instance:sendAtomicGetInfoRequest(self.dailyRefresh, self)
end

function AtomicController:dailyRefresh()
	self:dispatchEvent(AtomicEvent.DailyRefresh)
end

function AtomicController:openTalentView(param)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)
	ViewMgr.instance:openView(ViewName.AtomicCultivateView, param)
end

function AtomicController:openRewardView(actId)
	actId = actId or VersionActivity3_10Enum.ActivityId.Outside

	MileStoneController.instance:openViewByActId(ViewName.AtomicRewardView, actId)
end

function AtomicController:openDataBaseView()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)
	ViewMgr.instance:openView(ViewName.AtomicDataBaseView)
end

function AtomicController:openDataBaseInfoView(param)
	ViewMgr.instance:openView(ViewName.AtomicDataBaseInfoView, param)
end

function AtomicController:setPlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end
end

function AtomicController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(key, value) or GameUtil.playerPrefsGetStringByUserId(key, value)

	return value
end

function AtomicController:openAvgPlayView(param)
	ViewMgr.instance:openView(ViewName.AtomicAvgPlayView, param)
end

function AtomicController:_onStoryFinished(storyId)
	if storyId == AtomicEnum.AVGPlayStoryId then
		self:openAvgPlayView()
	end
end

AtomicController.instance = AtomicController.New()

return AtomicController
