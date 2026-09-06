-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationeSelectViewPresentor.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationeSelectViewPresentor", package.seeall)

local NewBreakFormationeSelectViewPresentor = class("NewBreakFormationeSelectViewPresentor", ViewPresentor)

function NewBreakFormationeSelectViewPresentor:ctor()
	NewBreakFormationeSelectViewPresentor.super.ctor(self)
end

function NewBreakFormationeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewBreakFormationeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/newbreakformation/newbreakformationeselectview.prefab"
	}
end

function NewBreakFormationeSelectViewPresentor:buildViews()
	return {
		NewBreakFormationeSelectView.New()
	}
end

return NewBreakFormationeSelectViewPresentor
