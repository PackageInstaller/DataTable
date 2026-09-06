-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainResultViewPresentor.lua

module("logic.extensions.idiomchain.view.IdiomChainResultViewPresentor", package.seeall)

local IdiomChainResultViewPresentor = class("IdiomChainResultViewPresentor", ViewPresentor)

function IdiomChainResultViewPresentor:ctor()
	IdiomChainResultViewPresentor.super.ctor(self)
end

function IdiomChainResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function IdiomChainResultViewPresentor:dependWhatResources()
	return {
		"ui/views/idiomchain/idiomchainresultview.prefab"
	}
end

function IdiomChainResultViewPresentor:buildViews()
	return {
		IdiomChainResultView.New()
	}
end

return IdiomChainResultViewPresentor
