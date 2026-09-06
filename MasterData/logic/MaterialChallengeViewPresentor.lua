-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MaterialChallengeViewPresentor.lua

module("logic.extensions.materialchallenge.view.MaterialChallengeViewPresentor", package.seeall)

local MaterialChallengeViewPresentor = class("MaterialChallengeViewPresentor", ViewWithGuidePresentor)

function MaterialChallengeViewPresentor:ctor()
	MaterialChallengeViewPresentor.super.ctor(self)
end

function MaterialChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MaterialChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/reschapterview.prefab"
	}
end

function MaterialChallengeViewPresentor:getTempResources()
	local resultPath = {}
	local chapterId = self:getFirstParam()
	local cfg = MaterialChallengeConfig.instance:getChapter(chapterId)

	if not cfg then
		return resultPath
	end

	if not string.nilorempty(cfg.nearBg) then
		table.insert(resultPath, string.format("ui/bigbg/copychapter/chapterbg/%s.png", cfg.nearBg))
	end

	if not string.nilorempty(cfg.middleBg) then
		table.insert(resultPath, string.format("ui/bigbg/copychapter/chapterbg/%s.png", cfg.middleBg))
	end

	if not string.nilorempty(cfg.farBg) then
		table.insert(resultPath, string.format("ui/bigbg/copychapter/chapterbg/%s.png", cfg.farBg))
	end

	return resultPath
end

function MaterialChallengeViewPresentor:buildViews()
	return {
		MaterialChallengeView.New()
	}
end

return MaterialChallengeViewPresentor
