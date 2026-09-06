-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/PetreturnwelfareViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.PetreturnwelfareViewPresentor", package.seeall)

local PetreturnwelfareViewPresentor = class("PetreturnwelfareViewPresentor", ViewPresentor)

function PetreturnwelfareViewPresentor:ctor()
	PetreturnwelfareViewPresentor.super.ctor(self)
end

function PetreturnwelfareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetreturnwelfareViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/petreturnwelfareview.prefab"
	}
end

function PetreturnwelfareViewPresentor:buildViews()
	return {
		PetreturnwelfareView.New()
	}
end

return PetreturnwelfareViewPresentor
