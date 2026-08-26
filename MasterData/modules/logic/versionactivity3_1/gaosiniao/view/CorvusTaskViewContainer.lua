-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/CorvusTaskViewContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.CorvusTaskViewContainer", package.seeall)

local CorvusTaskViewContainer = class("CorvusTaskViewContainer", TaskViewBaseContainer)

function CorvusTaskViewContainer:actId()
	return assert(self.viewParam.actId)
end

function CorvusTaskViewContainer:taskType()
	return assert(self.viewParam.taskType)
end

function CorvusTaskViewContainer:_createMainView()
	return self:onCreateMainView()
end

function CorvusTaskViewContainer:_createLeftTopView()
	return self:onCreateLeftTopView()
end

function CorvusTaskViewContainer:_createListScrollParam()
	return self:onCreateListScrollParam()
end

function CorvusTaskViewContainer:_createScrollView()
	local scrollModel = self:onCreateScrollView()
	local listScrollParam = self:_createListScrollParam()

	return scrollModel, listScrollParam
end

function CorvusTaskViewContainer:buildViews()
	local scrollModel, listScrollParam = self:_createScrollView()

	self.__scrollModel = scrollModel
	self.__listScrollParam = listScrollParam
	self.__mainView = self:_createMainView()
	self.__leftTopView = self:_createLeftTopView()

	return self:onBuildViews()
end

function CorvusTaskViewContainer:onBuildViews()
	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	assert(self.__listScrollParam.cellClass)
	assert(self.__listScrollParam.scrollGOPath)
	assert(self.__listScrollParam.prefabUrl)

	self.__scrollView = LuaListScrollViewWithAnimator.New(self.__scrollModel, self.__listScrollParam, animationDelayTimes)

	return {
		self.__scrollView,
		self.__mainView,
		self.__leftTopView
	}
end

function CorvusTaskViewContainer:scrollModel()
	return self.__scrollModel
end

function CorvusTaskViewContainer:onContainerInit()
	CorvusTaskViewContainer.super.onContainerInit(self)

	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.__scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
end

function CorvusTaskViewContainer:removeByIndex(index, cb, cbObj)
	self._taskAnimRemoveItem:removeByIndex(index, cb, cbObj)
end

function CorvusTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function CorvusTaskViewContainer:onCreateMainView()
	assert(false, "please overeide this function!")
end

function CorvusTaskViewContainer:onCreateLeftTopView()
	return TabViewGroup.New(1, "#go_lefttop")
end

function CorvusTaskViewContainer:onCreateScrollView()
	return CorvusTaskListModel.New()
end

function CorvusTaskViewContainer:onCreateListScrollParam()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	listScrollParam.sortMode = ScrollEnum.ScrollSortDown
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 1160
	listScrollParam.cellHeight = 165
	listScrollParam.cellSpaceV = 0
	listScrollParam.startSpace = 0
	listScrollParam.scrollGOPath = "#scroll_TaskList"
	listScrollParam.cellClass = CorvusTaskItem
	listScrollParam.rectMaskSoftness = {
		0,
		0
	}

	return listScrollParam
end

function CorvusTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return CorvusTaskViewContainer
