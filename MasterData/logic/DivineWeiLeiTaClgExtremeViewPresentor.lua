-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgExtremeViewPresentor.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgExtremeViewPresentor", package.seeall)

local DivineWeiLeiTaClgExtremeViewPresentor = class("DivineWeiLeiTaClgExtremeViewPresentor", ViewPresentor)

function DivineWeiLeiTaClgExtremeViewPresentor:ctor()
	DivineWeiLeiTaClgExtremeViewPresentor.super.ctor(self)
end

function DivineWeiLeiTaClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineWeiLeiTaClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divineweileitaclg/divineweileitaclgextremeview.prefab"
	}
end

function DivineWeiLeiTaClgExtremeViewPresentor:buildViews()
	return {
		DivineWeiLeiTaClgExtremeView.New()
	}
end

return DivineWeiLeiTaClgExtremeViewPresentor
