-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/view/DragonpoolmainViewPresentor.lua

module("logic.extensions.dragonpool.view.DragonpoolmainViewPresentor", package.seeall)

local DragonpoolmainViewPresentor = class("DragonpoolmainViewPresentor", ViewPresentor)

DragonpoolmainViewPresentor.ShouTao = "character/30003_pet_shoutao/30003_pet_shoutao_p.prefab"

function DragonpoolmainViewPresentor:ctor()
	DragonpoolmainViewPresentor.super.ctor(self)
end

function DragonpoolmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonpoolmainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpool/dragonpoolmainview.prefab",
		DragonpoolmainViewPresentor.ShouTao
	}
end

function DragonpoolmainViewPresentor:buildViews()
	return {
		DragonpoolmainView.New()
	}
end

return DragonpoolmainViewPresentor
