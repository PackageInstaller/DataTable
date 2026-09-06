-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingsupportrecordViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingsupportrecordViewPresentor", package.seeall)

local YoungchampionkingsupportrecordViewPresentor = class("YoungchampionkingsupportrecordViewPresentor", ViewPresentor)

function YoungchampionkingsupportrecordViewPresentor:ctor()
	YoungchampionkingsupportrecordViewPresentor.super.ctor(self)
end

function YoungchampionkingsupportrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YoungchampionkingsupportrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingsupportrecordview.prefab"
	}
end

function YoungchampionkingsupportrecordViewPresentor:buildViews()
	return {
		YoungchampionkingsupportrecordView.New()
	}
end

return YoungchampionkingsupportrecordViewPresentor
