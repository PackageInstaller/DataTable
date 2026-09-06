-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectblessinglionViewPresentor.lua

module("logic.extensions.birthdaywishes.view.CollectblessinglionViewPresentor", package.seeall)

local CollectblessinglionViewPresentor = class("CollectblessinglionViewPresentor", ViewPresentor)

function CollectblessinglionViewPresentor:ctor()
	CollectblessinglionViewPresentor.super.ctor(self)
end

function CollectblessinglionViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CollectblessinglionViewPresentor:dependWhatResources()
	return {
		"ui/views/collectblessing/collectblessinglionview.prefab"
	}
end

function CollectblessinglionViewPresentor:buildViews()
	return {
		CollectBlessingLionView.New()
	}
end

return CollectblessinglionViewPresentor
