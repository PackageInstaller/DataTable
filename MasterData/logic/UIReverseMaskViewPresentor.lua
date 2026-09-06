-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/view/UIReverseMaskViewPresentor.lua

module("logic.extensions.global.view.UIReverseMaskViewPresentor", package.seeall)

local UIReverseMaskViewPresentor = class("UIReverseMaskViewPresentor", ViewPresentor)

function UIReverseMaskViewPresentor:attachToWhichRoot()
	return nil
end

function UIReverseMaskViewPresentor:dependWhatResources()
	return {
		"ui/views/global/reversemaskview.prefab"
	}
end

function UIReverseMaskViewPresentor:buildViews()
	local views = {}
	local view = UIReverseMaskView.New()

	table.insert(views, view)

	return views
end

return UIReverseMaskViewPresentor
