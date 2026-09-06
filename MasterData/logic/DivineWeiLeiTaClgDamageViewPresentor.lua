-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgDamageViewPresentor.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgDamageViewPresentor", package.seeall)

local DivineWeiLeiTaClgDamageViewPresentor = class("DivineWeiLeiTaClgDamageViewPresentor", ViewPresentor)

function DivineWeiLeiTaClgDamageViewPresentor:ctor()
	DivineWeiLeiTaClgDamageViewPresentor.super.ctor(self)
end

function DivineWeiLeiTaClgDamageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineWeiLeiTaClgDamageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineweileitaclg/divineweileitaclgdamageview.prefab"
	}
end

function DivineWeiLeiTaClgDamageViewPresentor:buildViews()
	return {
		DivineWeiLeiTaClgDamageView.New()
	}
end

return DivineWeiLeiTaClgDamageViewPresentor
