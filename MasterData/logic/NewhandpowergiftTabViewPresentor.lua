-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandpowergiftTabViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandpowergiftTabViewPresentor", package.seeall)

local NewhandpowergiftTabViewPresentor = class("NewhandpowergiftTabViewPresentor", ViewPresentor)

function NewhandpowergiftTabViewPresentor:ctor()
	NewhandpowergiftTabViewPresentor.super.ctor(self)
end

function NewhandpowergiftTabViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandpowergiftTabViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandpowergifttabview.prefab"
	}
end

function NewhandpowergiftTabViewPresentor:buildViews()
	return {
		NewhandpowergiftTabView.New()
	}
end

function NewhandpowergiftTabViewPresentor:playEnterAnimation()
	if ViewSetting.instance:isFullScreen(self.viewName) then
		self:_onEnterAnimationDone()
	else
		NewhandpowergiftTabViewPresentor.super.playEnterAnimation(self)
	end
end

return NewhandpowergiftTabViewPresentor
