-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackBuyViewPresentor.lua

module("logic.extensions.groupredpack.view.GroupRedpackBuyViewPresentor", package.seeall)

local GroupRedpackBuyViewPresentor = class("GroupRedpackBuyViewPresentor", ViewPresentor)

function GroupRedpackBuyViewPresentor:ctor()
	GroupRedpackBuyViewPresentor.super.ctor(self)
end

function GroupRedpackBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRedpackBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/groupredpack/groupredpackbuyview.prefab"
	}
end

function GroupRedpackBuyViewPresentor:buildViews()
	return {
		GroupRedpackBuyView.New()
	}
end

return GroupRedpackBuyViewPresentor
