-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsMainViewPresentor.lua

module("logic.extensions.catchprops.view.CatchPropsMainViewPresentor", package.seeall)

local CatchPropsMainViewPresentor = class("CatchPropsMainViewPresentor", ViewPresentor)

function CatchPropsMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CatchPropsMainViewPresentor:dependWhatResources()
	return {
		"ui/views/catchprops/catchpropsmainview.prefab"
	}
end

function CatchPropsMainViewPresentor:getTempResources()
	return {
		CatchPropsModel.instance:getBgImage(),
		CatchPropsModel.instance:getUnlockImage(),
		CatchPropsModel.instance:getThrowerImage(),
		CatchPropsModel.instance:getCatcherImage(),
		UIEffectManager.instance:getEffectPath(CatchPropsModel.instance:getEffPath()),
		UIEffectManager.instance:getEffectPath(CatchPropsModel.instance:getStartGameEffPath())
	}
end

function CatchPropsMainViewPresentor:buildViews()
	return {
		CatchPropsMainView.New()
	}
end

return CatchPropsMainViewPresentor
