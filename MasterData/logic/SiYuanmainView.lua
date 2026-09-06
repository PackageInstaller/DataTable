-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SiYuanmainView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SiYuanmainView", package.seeall)

local SiYuanmainView = class("SiYuanmainView", SkslmainView)

function SiYuanmainView:bindEvents()
	SiYuanmainView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "imperialDragon_rule")
	end, self)
end

function SiYuanmainView:_getActivityId()
	return ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.SiyuanChallenge)
end

function SiYuanmainView:_getPetRaceId()
	return 16017
end

function SiYuanmainView:_getDifficultyView()
	return ViewName.SiYuandifficultyView
end

function SiYuanmainView:buildUI()
	SiYuanmainView.super.buildUI(self)

	local go = self:getGo("jumpButton/btnShop")

	GameUtil.SetActive(go, false)
end

return SiYuanmainView
