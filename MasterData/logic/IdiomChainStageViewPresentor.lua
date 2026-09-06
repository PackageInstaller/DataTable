-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainStageViewPresentor.lua

module("logic.extensions.idiomchain.view.IdiomChainStageViewPresentor", package.seeall)

local IdiomChainStageViewPresentor = class("IdiomChainStageViewPresentor", ViewPresentor)

function IdiomChainStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function IdiomChainStageViewPresentor:dependWhatResources()
	return {
		"ui/views/idiomchain/idiomchainstageview.prefab"
	}
end

function IdiomChainStageViewPresentor:buildViews()
	return {
		IdiomChainStageView.New()
	}
end

return IdiomChainStageViewPresentor
