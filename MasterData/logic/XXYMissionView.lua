-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/formation/XXYMissionView.lua

module("logic.extensions.xinxiyamirror.view.formation.XXYMissionView", package.seeall)

local XXYMissionView = class("XXYMissionView", MissionView)

function XXYMissionView:ctor()
	XXYMissionView.super.ctor(self)
end

function XXYMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self:_setBtnRuleActive(true)
end

function XXYMissionView:procMid()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = XinxiyaMirrorConfig.instance:getMasterTeamCfg(params.masterId)
		local titleStr = teamCfg.name
		local levelStr = ""

		if not teamCfg.rule then
			local ruleDesc = lang("text_none")

			self:_setDescStr(titleStr, levelStr, teamCfg.rule)
			self:_setRedPoint(teamCfg.redPoint)

			local cfgPerfectWin = BattleSettlementConfig.instance:getBattlePerfectWinOpCfgById(teamCfg.perfectWinId)
			local cfgPerfectWinOpType = BattleSettlementConfig.instance:getBattlePerfectWinOpTypeCfgById(teamCfg.perfectWinId)

			if cfgPerfectWin and cfgPerfectWinOpType then
				local perfectDesc = string.format(cfgPerfectWinOpType.desc, cfgPerfectWin.params)

				self:_setPerfectRuleDesc(perfectDesc)
			end
		end
	end
end

function XXYMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params and params.stageId then
		BattleFacade.instance:startXinxiyaMirror(params.masterId)
		XinxiyaMirrorController.instance:csMirrorChallengeReq(params.stageId)
		UIJumper.instance:pushOneStack(ViewName.XinxiyaMirror, true)
	end
end

function XXYMissionView:onExit()
	XXYMissionView.super.onExit(self)
	XinxiyaMirrorModel.instance:resetOrSetMirrorPet()
end

function XXYMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(petMo)
		if XinxiyaMirrorModel.instance:checkIsMirrorPet(petMo.raceId) then
			return false
		else
			return true
		end
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

return XXYMissionView
