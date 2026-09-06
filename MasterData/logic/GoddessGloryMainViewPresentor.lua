-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryMainViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddessGloryMainViewPresentor", package.seeall)

local GoddessGloryMainViewPresentor = class("GoddessGloryMainViewPresentor", ViewPresentor)

function GoddessGloryMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessGloryMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessglorymainview.prefab"
	}
end

function GoddessGloryMainViewPresentor:getTempResources()
	return {
		GoddessGloryModel.instance:getMainImage()
	}
end

function GoddessGloryMainViewPresentor:buildViews()
	return {
		GoddessGloryMainView.New()
	}
end

return GoddessGloryMainViewPresentor
