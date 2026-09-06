-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryRecrutViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddessGloryRecrutViewPresentor", package.seeall)

local GoddessGloryRecrutViewPresentor = class("GoddessGloryRecrutViewPresentor", ViewPresentor)

function GoddessGloryRecrutViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessGloryRecrutViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessgloryrecruitview.prefab"
	}
end

function GoddessGloryRecrutViewPresentor:buildViews()
	return {
		GoddessGloryRecrutView.New()
	}
end

function GoddessGloryRecrutViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessGloryRecrutViewPresentor
