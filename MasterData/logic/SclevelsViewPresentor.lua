-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SclevelsViewPresentor.lua

module("logic.extensions.scenariocopy.view.SclevelsViewPresentor", package.seeall)

local SclevelsViewPresentor = class("SclevelsViewPresentor", ViewPresentor)

function SclevelsViewPresentor:ctor()
	SclevelsViewPresentor.super.ctor(self)
end

function SclevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SclevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/sclevelsview.prefab"
	}
end

function SclevelsViewPresentor:getTempResources()
	local resultPath = {}

	table.insert(resultPath, "ui/icon/yyfb/board_yyfb_19.png")
	table.insert(resultPath, "ui/icon/yyfb/board_yyfb_18.png")
	table.insert(resultPath, "ui/icon/yyfb/board_yyfb_17.png")
	table.insert(resultPath, "ui/icon/yyfb/board_yyfb_12_01.png")
	table.insert(resultPath, "ui/icon/yyfb/board_yyfb_12.png")

	return resultPath
end

function SclevelsViewPresentor:buildViews()
	return {
		SclevelsView.New()
	}
end

return SclevelsViewPresentor
