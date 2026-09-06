-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/MoonKingBuffViewPresentor.lua

module("logic.extensions.moonking.view.MoonKingBuffViewPresentor", package.seeall)

local MoonKingBuffViewPresentor = class("MoonKingBuffViewPresentor", ViewWithGuidePresentor)

function MoonKingBuffViewPresentor:ctor()
	MoonKingBuffViewPresentor.super.ctor(self)
end

function MoonKingBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MoonKingBuffViewPresentor:dependWhatResources()
	if self._openParam and self._openParam.challId == MoonKingModel.instance.pbChallendId then
		return {
			"ui/views/moonking/paladinbuffview.prefab"
		}
	end

	return {
		"ui/views/moonking/moonkingbuffview.prefab"
	}
end

function MoonKingBuffViewPresentor:buildViews()
	return {
		MoonKingBuffView.New()
	}
end

return MoonKingBuffViewPresentor
