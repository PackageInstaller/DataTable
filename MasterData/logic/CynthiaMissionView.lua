-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/mission/CynthiaMissionView.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.mission.CynthiaMissionView", package.seeall)

local CynthiaMissionView = class("CynthiaMissionView", MissionView)

function CynthiaMissionView:onEnter()
	self:onEnterInherit()

	self.monsterCfg = self:_getMonsterCo()

	local ruleDesc = self.monsterCfg.WinDesc
	local titleStr = self.monsterCfg.name

	self:_setDescStr(titleStr, nil, ruleDesc)
	self:_setPureValidatorDesc(self.monsterCfg.missionDesc)
	GlobalDispatcher:addListener(GlobalNotify.PM_CynthiaEnterBattleError, self._onClickClose, self)
end

function CynthiaMissionView:onExit()
	CynthiaMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_CynthiaEnterBattleError, self._onClickClose, self)
end

function CynthiaMissionView:_getMonsterCo()
	local param = self._viewPresentor:getFirstParam()

	if param then
		return param
	end

	return {}
end

function CynthiaMissionView:_enterBattle()
	local param = self._viewPresentor:getFirstParam()

	if param then
		local cfg = self.monsterCfg
		local ruleDesc = cfg.WinDesc

		MissionModel.instance:setRuleDesc(ruleDesc, self._txtValidatorDesc.text)
		BattleFacade.instance:startBattle(GameEnum.MissionType.CYNTHIA)

		local ctrl = CynthiaController.instance

		BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl, param.challengeId))
		CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeFightReq(param.challengeId, param.stage)
	end
end

return CynthiaMissionView
