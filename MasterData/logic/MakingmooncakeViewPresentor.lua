-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingmooncakeViewPresentor.lua

module("logic.extensions.makingmooncake.view.MakingmooncakeViewPresentor", package.seeall)

local MakingmooncakeViewPresentor = class("MakingmooncakeViewPresentor", ViewPresentor)

function MakingmooncakeViewPresentor:ctor()
	MakingmooncakeViewPresentor.super.ctor(self)
end

function MakingmooncakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MakingmooncakeViewPresentor:dependWhatResources()
	return {
		"ui/views/makingmooncake/makingmooncakeview.prefab"
	}
end

function MakingmooncakeViewPresentor:buildViews()
	return {
		MakingMoonCakeView.New()
	}
end

function MakingmooncakeViewPresentor:getTempResources()
	return {
		MakingMoonCakeModel.instance:getRoleUrl()
	}
end

return MakingmooncakeViewPresentor
