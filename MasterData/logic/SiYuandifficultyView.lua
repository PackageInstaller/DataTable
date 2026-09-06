-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SiYuandifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SiYuandifficultyView", package.seeall)

local SiYuandifficultyView = class("SiYuandifficultyView", SksldifficultyView)

function SiYuandifficultyView:bindEvents()
	SiYuandifficultyView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		local ruleName = "imperialDragon_rule"

		UIStateManager.instance:push(ViewName.RulesView, ruleName)
	end)
end

function SiYuandifficultyView:_getActivityId()
	return ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.SiyuanChallenge)
end

return SiYuandifficultyView
