-- chunkname: @modules/logic/sp01/library/AssassinLibraryListView.lua

module("modules.logic.sp01.library.AssassinLibraryListView", package.seeall)

local AssassinLibraryListView = class("AssassinLibraryListView", BaseView)
local DelayTimePerLine = 0.06

function AssassinLibraryListView:onInitView()
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLibraryListView:addEvents()
	return
end

function AssassinLibraryListView:removeEvents()
	return
end

function AssassinLibraryListView:_editableInitView()
	self:addScrollView()
end

function AssassinLibraryListView:onUpdateParam()
	return
end

function AssassinLibraryListView:onOpen()
	self._actId = AssassinLibraryModel.instance:getCurActId()
	self._libType = AssassinLibraryModel.instance:getCurLibType()
	self._libraryCoList = AssassinConfig.instance:getLibraryConfigs(self._actId, self._libType)

	self._scrollInst:setList(self._libraryCoList)
	self._scrollView:playOpenAnimation()
end

function AssassinLibraryListView:addScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_info"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_info/Viewport/Content/#go_infoitem"
	scrollParam.cellClass = AssassinLibraryListInfoItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 450
	scrollParam.cellHeight = 256
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 16
	scrollParam.endSpace = 16

	local AnimationDelayTimes = {}
	local delayTime

	for i = 1, 4 do
		AnimationDelayTimes[i] = (i - 1) * DelayTimePerLine
	end

	self._scrollInst = ListScrollModel.New()
	self._scrollView = LuaListScrollViewWithAnimator.New(self._scrollInst, scrollParam, AnimationDelayTimes)

	self:addChildView(self._scrollView)
end

function AssassinLibraryListView:onClose()
	return
end

function AssassinLibraryListView:onDestroyView()
	return
end

return AssassinLibraryListView
