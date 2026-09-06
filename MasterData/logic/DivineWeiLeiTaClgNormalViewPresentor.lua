-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgNormalViewPresentor.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgNormalViewPresentor", package.seeall)

local DivineWeiLeiTaClgNormalViewPresentor = class("DivineWeiLeiTaClgNormalViewPresentor", ViewPresentor)

function DivineWeiLeiTaClgNormalViewPresentor:ctor()
	DivineWeiLeiTaClgNormalViewPresentor.super.ctor(self)
end

function DivineWeiLeiTaClgNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineWeiLeiTaClgNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divineweileitaclg/divineweileitaclgnormalview.prefab"
	}
end

function DivineWeiLeiTaClgNormalViewPresentor:buildViews()
	return {
		DivineWeiLeiTaClgNormalView.New()
	}
end

return DivineWeiLeiTaClgNormalViewPresentor
