-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/MiZongViewPresentor.lua

module("logic.extensions.lottery.view.paladin.MiZongViewPresentor", package.seeall)

local MiZongViewPresentor = class("MiZongViewPresentor", ViewPresentor)

function MiZongViewPresentor:ctor()
	MiZongViewPresentor.super.ctor(self)
end

function MiZongViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiZongViewPresentor:dependWhatResources()
	return {
		"ui/views/paladinlottery/mizongview.prefab"
	}
end

function MiZongViewPresentor:buildViews()
	return {
		MiZongView.New()
	}
end

return MiZongViewPresentor
