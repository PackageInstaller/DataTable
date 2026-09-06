-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/PvEMissionView.lua

module(..., package.seeall)

local PvEMissionView = class("PvEMissionView", MissionView)

function PvEMissionView:onEnter()
	self:onEnterInherit()

	self._fightPveId = self._viewPresentor._openParam[1]

	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(BattleRecordRankController.instance:isPveWithBattleRecord(self._fightPveId))
	self:_setMissionCfgInfo()
	self:_onSpClassLoad()
end

function PvEMissionView:_setMissionCfgInfo()
	local scene = SceneMgr.instance:getCurScene()
	local sceneId = scene:getSceneId()
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)
	local configCo = WuShenConfig.instance:getMasterCoById(self._fightPveId)
	local titleStr = sceneCo.scene_name
	local levelStr = configCo.name
	local ruleDesc = "击败敌方阵容即可通关"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
	self:_updatePowerCost(configCo.strengthConsumption)
end

function PvEMissionView:_setBattleResultTxtTitle()
	PvEMissionView.super._setBattleResultTxtTitle(self)

	local configCo = WuShenConfig.instance:getMasterCoById(self._fightPveId)

	BattleModel.instance:setBattleName(configCo.name)
end

function PvEMissionView:onEnterFinished()
	self:_procLRTxt()
end

function PvEMissionView:_getSpClassCo()
	return WuShenConfig.instance:getMasterCoById(self._fightPveId)
end

function PvEMissionView:_onClickVideo()
	local ranKey = BattleRecordRankController.instance:getPveRankKey(self._fightPveId)

	BattleRecordRankController.instance:enterView2(ranKey)
end

function PvEMissionView:_enterBattle()
	if BattleRecordRankController.instance:isPveWithBattleRecord(self._fightPveId) then
		local cfg = CopyConfig.instance:getTeamCfg(self._fightPveId)

		if cfg and cfg.video then
			local params = {}

			params.videoKey = BattleRecordRankController.instance:getPveRankKey(self._fightPveId)

			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Default, params)
		end
	end

	TaskAgent.instance:sendTaskFightMonsterReq(self._fightPveId)
end

return PvEMissionView
