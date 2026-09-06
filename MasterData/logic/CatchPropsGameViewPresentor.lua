-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsGameViewPresentor.lua

module("logic.extensions.catchprops.view.CatchPropsGameViewPresentor", package.seeall)

local CatchPropsGameViewPresentor = class("CatchPropsGameViewPresentor", ViewPresentor)

function CatchPropsGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CatchPropsGameViewPresentor:dependWhatResources()
	return {
		"ui/views/catchprops/catchpropsgameview.prefab"
	}
end

function CatchPropsGameViewPresentor:getTempResources()
	return {
		CatchPropsModel.instance:getGameBgImage(),
		CatchPropsModel.instance:getThrowerImage(),
		CatchPropsModel.instance:getCatcherImage(),
		CatchPropsModel.instance:getSpecialPropAsset(),
		CatchPropsModel.instance:getOtherSpecialPropAsset(),
		UIEffectManager.instance:getEffectPath(CatchPropsModel.instance:getCollisionEffPath()),
		unpack(CatchPropsModel.instance:getNormalPropAsset())
	}
end

function CatchPropsGameViewPresentor:buildViews()
	return {
		CatchPropsGameView.New()
	}
end

return CatchPropsGameViewPresentor
