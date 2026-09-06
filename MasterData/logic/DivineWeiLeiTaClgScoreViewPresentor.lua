-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgScoreViewPresentor.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgScoreViewPresentor", package.seeall)

local DivineWeiLeiTaClgScoreViewPresentor = class("DivineWeiLeiTaClgScoreViewPresentor", ViewPresentor)

function DivineWeiLeiTaClgScoreViewPresentor:ctor()
	DivineWeiLeiTaClgScoreViewPresentor.super.ctor(self)
end

function DivineWeiLeiTaClgScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineWeiLeiTaClgScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/divineweileitaclg/divineweileitaclgscoreview.prefab"
	}
end

function DivineWeiLeiTaClgScoreViewPresentor:buildViews()
	return {
		DivineWeiLeiTaClgScoreView.New()
	}
end

function DivineWeiLeiTaClgScoreViewPresentor:onClickOutside()
	self:close()
end

return DivineWeiLeiTaClgScoreViewPresentor
