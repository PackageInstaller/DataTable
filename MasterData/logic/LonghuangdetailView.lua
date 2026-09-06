-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuangdetailView.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuangdetailView", package.seeall)

local LonghuangdetailView = class("LonghuangdetailView", TimeLimitedDetailView)

function LonghuangdetailView:ctor()
	LonghuangdetailView.super.ctor(self)
end

function LonghuangdetailView:buildUI()
	LonghuangdetailView.super.buildUI(self)

	self._challengeId = LonghuangGameModel.instance:getChallengeId()
end

function LonghuangdetailView:_onClickStart()
	local dodgeTime = LonghuangGameModel.instance:getDodgeTime()

	if dodgeTime == 0 then
		UIStateManager.instance:push(ViewName.LonghuanggameView)
	else
		LonghuangdetailView.super._onClickStart(self)
	end
end

return LonghuangdetailView
