-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/publicity/PublicityMainViewPresentor.lua

module("logic.extensions.publicity.PublicityMainViewPresentor", package.seeall)

local PublicityMainViewPresentor = class("PublicityMainViewPresentor", ViewWithGuidePresentor)

function PublicityMainViewPresentor:ctor()
	PublicityMainViewPresentor.super.ctor(self)
end

function PublicityMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PublicityMainViewPresentor:dependWhatResources()
	return {
		"ui/views/publicity/publicitymainview.prefab"
	}
end

function PublicityMainViewPresentor:buildViews()
	return {
		PublicityMainView.New()
	}
end

return PublicityMainViewPresentor
