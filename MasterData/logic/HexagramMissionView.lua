-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/fmtview/HexagramMissionView.lua

module("logic.extensions.yirenpozhen.view.fmtview.HexagramMissionView", package.seeall)

local HexagramMissionView = class("HexagramMissionView", MissionView)

function HexagramMissionView:onEnter()
	self:onEnterInherit()

	local ruleDesc = "击败对方全体精灵"
	local params = self._viewPresentor:getFirstParam()
	local cfg = YirenPozhenConfig.instance:getStageCfg(params.stageId)

	self:_setDescStr(cfg.stageName, nil, ruleDesc)
	FastFormation.instance:setGetCurPetList(function()
		return YirenPozhenModel.instance:getAllPetList()
	end)
end

function HexagramMissionView:_enterBattle()
	UIJumper.instance:pushOneStack(ViewName.YirenPozhenMainView, true)
	TheOutcastChallengeAgent.instance:sendPM_TheOutcastChallengeReq()
end

function HexagramMissionView:_openPassRuleView()
	local params = self._viewPresentor:getFirstParam()

	UIStateManager.instance:open(ViewName.HexagramRuleView, params)
end

return HexagramMissionView
