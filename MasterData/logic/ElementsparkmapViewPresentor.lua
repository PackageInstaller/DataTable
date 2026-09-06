-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkmapViewPresentor.lua

module("logic.extensions.elementspark.view.ElementsparkmapViewPresentor", package.seeall)

local ElementsparkmapViewPresentor = class("ElementsparkmapViewPresentor", ViewPresentor)

ElementsparkmapViewPresentor.ChunkUITagCell = "ui/views/elementspark/mapchunk/mapchunktag.prefab"

function ElementsparkmapViewPresentor:ctor()
	ElementsparkmapViewPresentor.super.ctor(self)
end

function ElementsparkmapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementsparkmapViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkmapview.prefab",
		ElementsparkmapViewPresentor.ChunkUITagCell
	}
end

function ElementsparkmapViewPresentor:buildViews()
	return {
		ElementsparkmapView.New()
	}
end

function ElementsparkmapViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ElementsparkmapViewPresentor
