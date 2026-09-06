-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/RenamePresentor.lua

module("logic.extensions.roleinfo.view.RenamePresentor", package.seeall)

local RenamePresentor = class("RenamePresentor", ViewPresentor)

function RenamePresentor:ctor()
	RenamePresentor.super.ctor(self)
end

function RenamePresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RenamePresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/renameview.prefab"
	}
end

function RenamePresentor:buildViews()
	return {
		RenameView.New()
	}
end

return RenamePresentor
