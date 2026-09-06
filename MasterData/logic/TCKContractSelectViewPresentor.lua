-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKContractSelectViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKContractSelectViewPresentor", package.seeall)

local TCKContractSelectViewPresentor = class("TCKContractSelectViewPresentor", ViewPresentor)

function TCKContractSelectViewPresentor:ctor()
	TCKContractSelectViewPresentor.super.ctor(self)
end

function TCKContractSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKContractSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckcontractselectview.prefab"
	}
end

function TCKContractSelectViewPresentor:buildViews()
	return {
		TCKContractSelectView.New()
	}
end

return TCKContractSelectViewPresentor
