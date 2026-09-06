-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgSkillBuffViewPresentor.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgSkillBuffViewPresentor", package.seeall)

local DivineMiyaClgSkillBuffViewPresentor = class("DivineMiyaClgSkillBuffViewPresentor", ViewPresentor)

function DivineMiyaClgSkillBuffViewPresentor:ctor()
	DivineMiyaClgSkillBuffViewPresentor.super.ctor(self)
end

function DivineMiyaClgSkillBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiyaClgSkillBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiyaclg/divinemiyaclgbuffview.prefab"
	}
end

function DivineMiyaClgSkillBuffViewPresentor:buildViews()
	return {
		DivineMiyaClgSkillBuffView.New()
	}
end

return DivineMiyaClgSkillBuffViewPresentor
