-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgMainViewPresentor.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgMainViewPresentor", package.seeall)

local DivineWeiLeiTaClgMainViewPresentor = class("DivineWeiLeiTaClgMainViewPresentor", ViewPresentor)

function DivineWeiLeiTaClgMainViewPresentor:ctor()
	DivineWeiLeiTaClgMainViewPresentor.super.ctor(self)
end

function DivineWeiLeiTaClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineWeiLeiTaClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineweileitaclg/divineweileitaclgmainview.prefab"
	}
end

function DivineWeiLeiTaClgMainViewPresentor:buildViews()
	return {
		DivineWeiLeiTaClgMainView.New()
	}
end

return DivineWeiLeiTaClgMainViewPresentor
