-- chunkname: @modules/logic/gm/view/GMToolStoryView.lua

module("modules.logic.gm.view.GMToolStoryView", package.seeall)

local GMToolStoryView = class("GMToolStoryView", BaseView)

function GMToolStoryView:onInitView()
	self._gostory = gohelper.findChild(self.viewGO, "viewport/content/#go_story")
	self._inputtxt = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/#go_story/#input_txt")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/#go_story/#btn_skip")
	self._btnheropreview = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/#go_story/#btn_heropreview")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/#go_story/#btn_play")
end

function GMToolStoryView:addEvents()
	self._btnskip:AddClickListener(self._onbtnskipOnClick, self)
	self._btnheropreview:AddClickListener(self._onbtnheropreviewOnClick, self)
	self._btnplay:AddClickListener(self._onbtnplayOnClick, self)
end

function GMToolStoryView:removeEvents()
	self._btnskip:RemoveClickListener()
	self._btnheropreview:RemoveClickListener()
	self._btnplay:RemoveClickListener()
end

function GMToolStoryView:onOpen()
	self._inputtxt:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewStory, ""))
end

function GMToolStoryView:_onbtnplayOnClick()
	self:closeThis()

	local txt = self._inputtxt:GetText()

	if not string.nilorempty(txt) then
		local results = string.splitToNumber(txt, "#")
		local storyId = results[1]
		local stepId = results[2]

		if storyId then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewStory, storyId)

			if stepId then
				StoryController.instance:playStoryByStartStep(storyId, stepId)
			else
				local param = {}

				param.isReplay = true
				param.mark = false

				StoryController.instance:playStory(storyId, param)
			end
		end
	end
end

function GMToolStoryView:_onbtnskipOnClick()
	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		StoryController.instance:playFinished()
	end
end

function GMToolStoryView:_onbtnheropreviewOnClick()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.StoryHeroPreview)
end

function GMToolStoryView:onClose()
	return
end

function GMToolStoryView:onDestroyView()
	return
end

return GMToolStoryView
