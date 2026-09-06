-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainMainViewPresentor.lua

module("logic.extensions.idiomchain.view.IdiomChainMainViewPresentor", package.seeall)

local IdiomChainMainViewPresentor = class("IdiomChainMainViewPresentor", ViewPresentor)

function IdiomChainMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IdiomChainMainViewPresentor:dependWhatResources()
	return {
		"ui/views/idiomchain/idiomchainmainview.prefab"
	}
end

function IdiomChainMainViewPresentor:buildViews()
	return {
		IdiomChainMainView.New()
	}
end

return IdiomChainMainViewPresentor
