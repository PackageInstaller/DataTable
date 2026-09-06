-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThroneOneKeyLvUpViewPresentor.lua

module("logic.extensions.throne.view.ThroneOneKeyLvUpViewPresentor", package.seeall)

local ThroneOneKeyLvUpViewPresentor = class("ThroneOneKeyLvUpViewPresentor", ViewPresentor)

function ThroneOneKeyLvUpViewPresentor:ctor()
	ThroneOneKeyLvUpViewPresentor.super.ctor(self)
end

function ThroneOneKeyLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThroneOneKeyLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/throne/throneonekeylvupview.prefab"
	}
end

function ThroneOneKeyLvUpViewPresentor:buildViews()
	return {
		ThroneOneKeyLvUpView.New()
	}
end

function ThroneOneKeyLvUpViewPresentor:onClickOutside()
	self:close()
end

return ThroneOneKeyLvUpViewPresentor
