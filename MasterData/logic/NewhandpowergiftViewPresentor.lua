-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandpowergiftViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandpowergiftViewPresentor", package.seeall)

local NewhandpowergiftViewPresentor = class("NewhandpowergiftViewPresentor", ViewPresentor)

function NewhandpowergiftViewPresentor:ctor()
	NewhandpowergiftViewPresentor.super.ctor(self)
end

function NewhandpowergiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandpowergiftViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandpowergiftview.prefab"
	}
end

function NewhandpowergiftViewPresentor:buildViews()
	return {
		NewhandpowergiftView.New()
	}
end

function NewhandpowergiftViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandpowergiftViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandpowergiftViewPresentor
