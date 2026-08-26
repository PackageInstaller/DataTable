-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114GetPhotoViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114GetPhotoViewContainer", package.seeall)

local Activity114GetPhotoViewContainer = class("Activity114GetPhotoViewContainer", BaseViewContainer)

function Activity114GetPhotoViewContainer:buildViews()
	return {
		Activity114GetPhotoView.New()
	}
end

return Activity114GetPhotoViewContainer
