-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryMaskView.lua

module("logic.extensions.story.view.StoryMaskView", package.seeall)

local StoryMaskView = class("StoryMaskView", ViewComponent)

function StoryMaskView:buildUI()
	local uiCameraGO = GlobalModel.instance.uiCameraGO:GetComponent("Camera")
	local uiCanvas = self.mainGO:GetComponent("Canvas")

	uiCanvas.worldCamera = uiCameraGO
	uiCanvas.sortingOrder = 999
end

return StoryMaskView
