-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgResultViewPresentor.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgResultViewPresentor", package.seeall)

local DivineWeiLeiTaClgResultViewPresentor = class("DivineWeiLeiTaClgResultViewPresentor", ViewPresentor)

function DivineWeiLeiTaClgResultViewPresentor:ctor()
	DivineWeiLeiTaClgResultViewPresentor.super.ctor(self)
end

function DivineWeiLeiTaClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineWeiLeiTaClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineweileitaclg/divineweileitaclgresultview.prefab"
	}
end

function DivineWeiLeiTaClgResultViewPresentor:buildViews()
	return {
		DivineWeiLeiTaClgResultView.New()
	}
end

return DivineWeiLeiTaClgResultViewPresentor
