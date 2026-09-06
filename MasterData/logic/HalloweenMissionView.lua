-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/formation/HalloweenMissionView.lua

module("logic.extensions.halloweenguest.view.formation.HalloweenMissionView", package.seeall)

local HalloweenMissionView = class("HalloweenMissionView", MissionView)

function HalloweenMissionView:ctor()
	HalloweenMissionView.super.ctor(self)
end

function HalloweenMissionView:onEnter()
	self:onEnterInherit()
	GameUtil.SetActive(self._videoButton, false)
	self:procMid()
	self:_setBtnRuleActive(true)
end

function HalloweenMissionView:procMid()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = params.isBoss and HalloweenGuestConfig.instance:getBossTeamCfg(params.planId, params.baseId) or HalloweenGuestConfig.instance:getMasterTeamCfg(params.baseId)

		if teamCfg then
			if not teamCfg.name then
				local titleStr = "战斗"

				if teamCfg then
					if not teamCfg.ruleDesc then
						self:_setDescStr(titleStr, "", (teamCfg and not string.nilorempty(teamCfg.ruleDesc) or nil) and teamCfg.ruleDesc)

						if teamCfg == nil then
							return
						end

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
		end
	end
end

function HalloweenMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params and params.actId then
		if params.isBoss then
			UIJumper.instance:pushOneStack(ViewName.HalloweenBoss, true)
			HalloweenGuestController.instance:csGetHalloweenBossChallengeReq(params.actId, params.baseId)
		else
			UIJumper.instance:pushOneStack(ViewName.HalloweenMonster, true)
			UIJumper.instance:pushOneStack(ViewName.HalloweenMonsterTask, true)
			HalloweenGuestController.instance:csGetHalloweenSceneMonsterChallengeReq(params.actId, params.sceneId, params.posId)
		end
	end
end

return HalloweenMissionView
