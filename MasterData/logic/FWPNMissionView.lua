-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FWPNMissionView.lua

module("logic.extensions.newfamily.view.war.formation.FWPNMissionView", package.seeall)

local FWPNMissionView = class("FWPNMissionView", MissionView)

function FWPNMissionView:ctor()
	FWPNMissionView.super.ctor(self)
end

function FWPNMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self:_setBtnRuleActive(true)
end

function FWPNMissionView:procMid()
	local params = self._viewPresentor:getFirstParam()

	if params == nil or params.tempId == nil then
		return
	end

	if params.isNest then
		local titleStr = params.name
		local levelStr = ""
		local teamCfg = FamilyWarConfig.instance:getFamilyNestMasterCfg(params.enemyId)

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
	else
		self:_setDescStr(string.format("第%s层", params.curTier), "", lang("text_none"))
	end
end

function FWPNMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params and params.tempId then
		BattleFacade.instance:startFamilyWar(params.isNest, params.tempId)

		if params.isNest then
			FamilyWarController.instance:csRequestFamilyBattleChallengeNestReq(params.tempId)
		else
			FamilyWarController.instance:csRequestFamilyBattleChallengeDivinePillarReq(params.tempId)
		end

		UIJumper.instance:pushOneStack(ViewName.FamilyWarMain, true)
	end
end

function FWPNMissionView:onExit()
	FWPNMissionView.super.onExit(self)
end

return FWPNMissionView
