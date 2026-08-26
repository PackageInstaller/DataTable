-- chunkname: @modules/logic/guide/view/GuideStepEditorContainer.lua

module("modules.logic.guide.view.GuideStepEditorContainer", package.seeall)

local GuideStepEditorContainer = class("GuideStepEditorContainer", BaseViewContainer)

function GuideStepEditorContainer:buildViews()
	return {
		GuideStepEditor.New(),
		GuideMaskView.New(),
		GuideTipsView.New(),
		GuideStoryView.New(),
		GuideDialogueView.New()
	}
end

return GuideStepEditorContainer
