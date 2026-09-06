-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SmallluyngardedifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SmallluyngardedifficultyView", package.seeall)

local SmallluyngardedifficultyView = class("SmallluyngardedifficultyView", SksldifficultyView)

function SmallluyngardedifficultyView:bindEvents()
	SmallluyngardedifficultyView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "luyinjiademainview_rule")
	end)
end

function SmallluyngardedifficultyView:_getActivityId()
	return ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.SLYJDChallenge)
end

return SmallluyngardedifficultyView
