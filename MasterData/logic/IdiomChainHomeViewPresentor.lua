-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainHomeViewPresentor.lua

module("logic.extensions.idiomchain.view.IdiomChainHomeViewPresentor", package.seeall)

local IdiomChainHomeViewPresentor = class("IdiomChainHomeViewPresentor", ViewPresentor)

function IdiomChainHomeViewPresentor:ctor()
	IdiomChainHomeViewPresentor.super.ctor(self)
end

function IdiomChainHomeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IdiomChainHomeViewPresentor:dependWhatResources()
	return {
		"ui/views/idiomchain/idiomchainhomeview.prefab"
	}
end

function IdiomChainHomeViewPresentor:buildViews()
	return {
		IdiomChainHomeView.New()
	}
end

return IdiomChainHomeViewPresentor
