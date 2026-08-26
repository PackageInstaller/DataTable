-- chunkname: @modules/logic/act189/view/ShortenActViewContainer_impl.lua

module("modules.logic.act189.view.ShortenActViewContainer_impl", package.seeall)

local ShortenActViewContainer_impl = class("ShortenActViewContainer_impl", Activity189BaseViewContainer)

function ShortenActViewContainer_impl:initTaskScrollView(scrollParam)
	if self.__taskScrollView then
		return self.__taskScrollView
	end

	if not scrollParam then
		scrollParam = ListScrollParam.New()
		scrollParam.scrollGOPath = "root/right/#scroll_tasklist"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam.prefabUrl = self._viewSetting.otherRes[1]
		scrollParam.cellClass = ShortenAct_TaskItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 1
		scrollParam.cellWidth = 872
		scrollParam.cellHeight = 132
		scrollParam.cellSpaceH = 0
		scrollParam.cellSpaceV = 16
	end

	local times = {}

	for i = 1, 5 do
		times[i] = (i - 1) * 0.06
	end

	self.__taskScrollView = LuaListScrollViewWithAnimator.New(Activity189_TaskListModel.instance, scrollParam, times)
	self.notPlayAnimation = true

	return self.__taskScrollView
end

function ShortenActViewContainer_impl:taskScrollView()
	return self.__taskScrollView or self:initTaskScrollView()
end

function ShortenActViewContainer_impl:onContainerInit()
	ShortenActViewContainer_impl.super.onContainerInit(self)

	self.__taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self:taskScrollView())

	self.__taskAnimRemoveItem:setMoveInterval(0)
end

function ShortenActViewContainer_impl:removeByIndex(index, cb, cbObj)
	self.__taskAnimRemoveItem:removeByIndex(index, cb, cbObj)
end

function ShortenActViewContainer_impl:actId()
	return ShortenActConfig.instance:getActivityId()
end

return ShortenActViewContainer_impl
