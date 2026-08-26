-- chunkname: @modules/logic/story/view/StoryPrologueSkipView.lua

module("modules.logic.story.view.StoryPrologueSkipView", package.seeall)

local StoryPrologueSkipView = class("StoryPrologueSkipView", BaseView)

function StoryPrologueSkipView:onInitView()
	self._simagefg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fg")
	self._simagefg2 = gohelper.findChildSingleImage(self.viewGO, "bg/simage_fg")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "ani/simage_1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "ani/simage_2")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_close")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#txt_content")
	self._bgClick = gohelper.getClickWithAudio(self._simagefg.gameObject)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryPrologueSkipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._bgClick:AddClickListener(self._onBgClick, self)
end

function StoryPrologueSkipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._bgClick:RemoveClickListener()
end

function StoryPrologueSkipView:_btncloseOnClick()
	self:_hideStoryViewContent(false)
	self:closeThis()
	StoryController.instance:dispatchEvent(StoryEvent.OnPrologueSkipClick)
end

function StoryPrologueSkipView:_onBgClick()
	self:_hideStoryViewContent(false)
	self:closeThis()
	StoryController.instance:dispatchEvent(StoryEvent.OnPrologueSkipClick)
end

function StoryPrologueSkipView:_editableInitView()
	return
end

function StoryPrologueSkipView:onUpdateParam()
	return
end

function StoryPrologueSkipView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)

	self._txtcontent.text = self.viewParam.content

	self._simagefg:LoadImage(ResUrl.getStoryPrologueSkip("prologueskip_fullbg2"))
	self._simagefg2:LoadImage(ResUrl.getStoryPrologueSkip("bg1"))
	self._simagebg1:LoadImage(ResUrl.getStoryPrologueSkip("bg2"))
	self._simagebg2:LoadImage(ResUrl.getStoryPrologueSkip("bg3"))
	self:_hideStoryViewContent(true)
end

function StoryPrologueSkipView:_hideStoryViewContent(hide)
	local storyHeroView = ViewMgr.instance:getContainer(ViewName.StoryHeroView)

	gohelper.setActive(storyHeroView.viewGO, not hide)

	local storyView = ViewMgr.instance:getContainer(ViewName.StoryView)
	local contentRootGo = gohelper.findChild(storyView.viewGO, "#go_contentroot")

	gohelper.setActive(contentRootGo, not hide)
end

function StoryPrologueSkipView:onClose()
	return
end

function StoryPrologueSkipView:onDestroyView()
	self._simagefg:UnLoadImage()
	self._simagefg2:UnLoadImage()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return StoryPrologueSkipView
