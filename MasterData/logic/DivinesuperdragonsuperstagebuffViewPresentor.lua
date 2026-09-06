-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonsuperstagebuffViewPresentor.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonsuperstagebuffViewPresentor", package.seeall)

local DivinesuperdragonsuperstagebuffViewPresentor = class("DivinesuperdragonsuperstagebuffViewPresentor", ViewPresentor)

function DivinesuperdragonsuperstagebuffViewPresentor:ctor()
	DivinesuperdragonsuperstagebuffViewPresentor.super.ctor(self)
end

function DivinesuperdragonsuperstagebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivinesuperdragonsuperstagebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinesuperdragon/divinesuperdragonsuperstagebuffview.prefab"
	}
end

function DivinesuperdragonsuperstagebuffViewPresentor:buildViews()
	return {
		DivinesuperdragonsuperstagebuffView.New()
	}
end

function DivinesuperdragonsuperstagebuffViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function DivinesuperdragonsuperstagebuffViewPresentor:setGrayMaskGO(grayMaskGO)
	DivinesuperdragonsuperstagebuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return DivinesuperdragonsuperstagebuffViewPresentor
