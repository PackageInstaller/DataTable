-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticetaskcellViewPresentor.lua

module("logic.extensions.upholdjustice.view.UpholdjusticetaskcellViewPresentor", package.seeall)

local UpholdjusticetaskcellViewPresentor = class("UpholdjusticetaskcellViewPresentor", ViewPresentor)

function UpholdjusticetaskcellViewPresentor:ctor()
	UpholdjusticetaskcellViewPresentor.super.ctor(self)
end

function UpholdjusticetaskcellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UpholdjusticetaskcellViewPresentor:dependWhatResources()
	return {
		"ui/views/upholdjustice/upholdjusticetaskcellview.prefab"
	}
end

function UpholdjusticetaskcellViewPresentor:buildViews()
	return {
		UpholdjusticetaskcellView.New()
	}
end

return UpholdjusticetaskcellViewPresentor
