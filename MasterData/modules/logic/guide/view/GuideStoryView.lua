-- chunkname: @modules/logic/guide/view/GuideStoryView.lua

module("modules.logic.guide.view.GuideStoryView", package.seeall)

local GuideStoryView = class("GuideStoryView", BaseView)

function GuideStoryView:onInitView()
	self._storyGO = gohelper.findChild(self.viewGO, "story")
	self._txtContent = gohelper.findChildText(self.viewGO, "story/go_content/txt_content")
end

function GuideStoryView:onOpen()
	self:_updateUI()
	self.addEventCb(self, GuideController.instance, GuideEvent.UpdateMaskView, self._updateUI, self)
end

function GuideStoryView:onUpdateParam()
	self:_updateUI()
	self.removeEventCb(self, GuideController.instance, GuideEvent.UpdateMaskView, self._updateUI, self)
end

function GuideStoryView:_updateUI()
	if not self.viewParam then
		return
	end

	gohelper.setActive(self._storyGO, self.viewParam.hasStory)

	if not self.viewParam.hasStory then
		return
	end

	self._txtContent.text = LuaUtil.replaceSpace(self.viewParam.storyContent)
end

function GuideStoryView:onClose()
	return
end

return GuideStoryView
