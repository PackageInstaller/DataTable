-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114FullPhotoViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114FullPhotoViewContainer", package.seeall)

local Activity114FullPhotoViewContainer = class("Activity114FullPhotoViewContainer", BaseViewContainer)

function Activity114FullPhotoViewContainer:buildViews()
	return {
		Activity114FullPhotoView.New(self.viewParam)
	}
end

function Activity114FullPhotoViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity114FullPhotoViewContainer
