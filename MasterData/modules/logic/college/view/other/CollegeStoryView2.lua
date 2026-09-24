-- chunkname: @modules/logic/college/view/other/CollegeStoryView2.lua

module("modules.logic.college.view.other.CollegeStoryView2", package.seeall)

local CollegeStoryView2 = class("CollegeStoryView2", BaseView)

function CollegeStoryView2:onInitView()
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
end

function CollegeStoryView2:addEvents()
	self._btnSkip:AddClickListener(self._skipStory, self)
	NavigateMgr.instance:addEscape(self.viewName, self._skipStory, self)
end

function CollegeStoryView2:removeEvents()
	self._btnSkip:RemoveClickListener()
end

function CollegeStoryView2:_skipStory()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, self.closeThis, nil, nil, self)
end

function CollegeStoryView2:onClose()
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

return CollegeStoryView2
