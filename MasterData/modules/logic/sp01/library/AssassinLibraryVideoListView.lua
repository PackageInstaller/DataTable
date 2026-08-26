-- chunkname: @modules/logic/sp01/library/AssassinLibraryVideoListView.lua

module("modules.logic.sp01.library.AssassinLibraryVideoListView", package.seeall)

local AssassinLibraryVideoListView = class("AssassinLibraryVideoListView", BaseView)

function AssassinLibraryVideoListView:onInitView()
	self._scrollvideo = gohelper.findChildScrollRect(self.viewGO, "#scroll_video")
	self._govideoitem = gohelper.findChild(self.viewGO, "#scroll_video/Viewport/Content/#go_videoitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLibraryVideoListView:addEvents()
	return
end

function AssassinLibraryVideoListView:removeEvents()
	return
end

function AssassinLibraryVideoListView:_editableInitView()
	self:addScrollView()
end

function AssassinLibraryVideoListView:onUpdateParam()
	return
end

function AssassinLibraryVideoListView:onOpen()
	self._actId = AssassinLibraryModel.instance:getCurActId()
	self._libType = AssassinLibraryModel.instance:getCurLibType()
	self._libraryCoList = AssassinConfig.instance:getLibraryConfigs(self._actId, self._libType)

	self._scrollInst:setList(self._libraryCoList)
end

function AssassinLibraryVideoListView:addScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_video"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_video/Viewport/Content/#go_videoitem"
	scrollParam.cellClass = AssassinLibraryVideoListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1300
	scrollParam.cellHeight = 234
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 16
	scrollParam.endSpace = 16
	self._scrollInst = ListScrollModel.New()
	self._scrollView = LuaListScrollView.New(self._scrollInst, scrollParam)

	self:addChildView(self._scrollView)
end

function AssassinLibraryVideoListView:onClose()
	return
end

function AssassinLibraryVideoListView:onDestroyView()
	return
end

return AssassinLibraryVideoListView
