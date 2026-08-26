-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142StoryView.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142StoryView", package.seeall)

local Activity142StoryView = class("Activity142StoryView", BaseView)

function Activity142StoryView:onInitView()
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_storylist")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_blackbg/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142StoryView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function Activity142StoryView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Activity142StoryView:_editableInitView()
	return
end

function Activity142StoryView:onUpdateParam()
	return
end

function Activity142StoryView:onOpen()
	Activity142StoryListModel.instance:init(self.viewParam.actId, self.viewParam.episodeId)
end

function Activity142StoryView:onClose()
	return
end

function Activity142StoryView:onDestroyView()
	return
end

return Activity142StoryView
