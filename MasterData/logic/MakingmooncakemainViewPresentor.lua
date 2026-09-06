-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingmooncakemainViewPresentor.lua

module("logic.extensions.makingmooncake.view.MakingmooncakemainViewPresentor", package.seeall)

local MakingmooncakemainViewPresentor = class("MakingmooncakemainViewPresentor", ViewPresentor)

function MakingmooncakemainViewPresentor:ctor()
	MakingmooncakemainViewPresentor.super.ctor(self)
end

function MakingmooncakemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MakingmooncakemainViewPresentor:dependWhatResources()
	return {
		"ui/views/makingmooncake/makingmooncakemainview.prefab"
	}
end

function MakingmooncakemainViewPresentor:buildViews()
	return {
		MakingMoonCakeMainView.New()
	}
end

function MakingmooncakemainViewPresentor:getTempResources()
	return {
		MakingMoonCakeModel.instance:getRoleUrl()
	}
end

return MakingmooncakemainViewPresentor
