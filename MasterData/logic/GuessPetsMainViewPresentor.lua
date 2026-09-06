-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsMainViewPresentor.lua

module("logic.extensions.guesspets.view.GuessPetsMainViewPresentor", package.seeall)

local GuessPetsMainViewPresentor = class("GuessPetsMainViewPresentor", ViewPresentor)

function GuessPetsMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessPetsMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guesspets/guesspetsmainview.prefab"
	}
end

function GuessPetsMainViewPresentor:open(param)
	local activityId = GuessPetModel.instance:getActivityId()

	if activityId == 0 then
		GuessPetController.instance:calCurrActivityId()
	end

	GuessPetsMainViewPresentor.super.open(self, param)
end

function GuessPetsMainViewPresentor:getTempResources()
	return {
		GuessPetModel.instance:getMainImage()
	}
end

function GuessPetsMainViewPresentor:buildViews()
	return {
		GuessPetsMainView.New()
	}
end

return GuessPetsMainViewPresentor
