-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingMissionView.lua

module("logic.extensions.teachingdungeon.view.TeachingMissionView", package.seeall)

local TeachingMissionView = class("TeachingMissionView", MissionView)

function TeachingMissionView:ctor()
	TeachingMissionView.super.ctor(self)

	self.model = TeachingDungeonModel.instance
end

function TeachingMissionView:onEnter()
	UIStateManager.instance:open(ViewName.TechingtagView)
	self:onEnterInherit()

	self.stageId = self.model:getCurrStageId()

	self:procMid()

	local cfg = TeachingDungeonConfig.instance:getConfigByStageId(self.stageId)

	self._videoButton.gameObject:SetActive(checknumber(cfg.hasVideo) == 1)
	self._btnEvaluate.gameObject:SetActive(false)
	GameUtil.SetActive(self._btnOneKey, false)
	UIStateManager.instance:push(ViewName.TeachingDungeonTip, {
		tag = 1,
		stageId = TeachingDungeonModel.instance:getCurrStageId()
	})
	GlobalDispatcher:addListener(BattleCollegeAgent.BC_ChallengeRes, self._onMissionBattleResBack, self)
end

function TeachingMissionView:onExit()
	GlobalDispatcher:removeListener(BattleCollegeAgent.BC_ChallengeRes, self._onMissionBattleResBack, self)
	TeachingMissionView.super.onExit(self)
	ViewMgr.instance:close(ViewName.TechingtagView)
end

function TeachingMissionView:procMid()
	local cfg = TeachingDungeonConfig.instance:getMonsterCfg()

	if cfg then
		if not cfg.name then
			local titleStr = ""
			local levelStr = ""

			if cfg then
				if not cfg.rule then
					local ruleDesc = "无"

					self:_setDescStr(titleStr, levelStr, ruleDesc)
					self:_setRedPoint(cfg.redPoint)

					local cfgPerfectWin = BattleSettlementConfig.instance:getBattlePerfectWinOpCfgById(cfg.perfectWinId)
					local cfgPerfectWinOpType = BattleSettlementConfig.instance:getBattlePerfectWinOpTypeCfgById(cfg.perfectWinId)

					if cfgPerfectWin and cfgPerfectWinOpType then
						local perfectDesc = string.format(cfgPerfectWinOpType.desc, cfgPerfectWin.params)

						self:_setPerfectRuleDesc(perfectDesc)
					end
				end
			end
		end
	end
end

function TeachingMissionView:_onClickVideo()
	local ranKey = BattleRecordRankController.instance:getTeachRankKey(self.stageId)

	BattleRecordRankController.instance:enterView2(ranKey)
end

function TeachingMissionView:_onClickStart()
	if self.model:isCurFormationEmpty() then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), nil, "去布阵")

		return
	end

	if self:_checkFormationPosNumber(function()
		self:_startClg()
	end) then
		return
	end

	self:_startClg()
end

function TeachingMissionView:_startClg()
	self:_setMaskBlock(true)
	self.model:saveCurrFormation()
	self:_startNow()
end

function TeachingMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = self.model:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local totalPos = math.min(5, #self.model:getConfigPetIds())
	local petsNum = self.model:bagCount()

	if totalPos <= petsNum and numPos < totalPos then
		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback)

		return true
	end
end

function TeachingMissionView:_setBattleResultTxtTitle()
	local str = string.format("破阵天下 %s", self:_getTitleStr())

	BattleSettlementModel.instance:setTxtTitle(str)
end

function TeachingMissionView:_onClickOneKey()
	TeachingFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function TeachingMissionView:_onClickClean()
	TeachingFastFormation.instance:clean()
end

function TeachingMissionView:_startNow()
	self:_setBattleResultTxtTitle()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	BattleFacade.instance:startTeaching(self.stageId)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.TeachingDungeon)
	TeachingDungeonController.instance:sendBC_ChallengeReq()
end

return TeachingMissionView
