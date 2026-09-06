-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaDifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaDifficultyView", package.seeall)

local LeilaDifficultyView = class("LeilaDifficultyView", PerfectRuleModeDifficultyView)

function LeilaDifficultyView:buildUI()
	LeilaDifficultyView.super.buildUI(self)
end

return LeilaDifficultyView
