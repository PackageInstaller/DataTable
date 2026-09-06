-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/publiccardpool/PublicDragonTabViewPresentor.lua

module("logic.extensions.lottery.view.publiccardpool.PublicDragonTabViewPresentor", package.seeall)

local PublicDragonTabViewPresentor = class("PublicDragonTabViewPresentor", ViewPresentor)

function PublicDragonTabViewPresentor:ctor()
	PublicDragonTabViewPresentor.super.ctor(self)
end

function PublicDragonTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PublicDragonTabViewPresentor:dependWhatResources()
	return {
		"ui/views/publicdragonlottery/publicdragontabview.prefab"
	}
end

function PublicDragonTabViewPresentor:buildViews()
	return {
		PublicDragonTabView.New()
	}
end

return PublicDragonTabViewPresentor
