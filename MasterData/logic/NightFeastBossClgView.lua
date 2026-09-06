-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossClgView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossClgView", package.seeall)

local NightFeastBossClgView = class("NightFeastBossClgView", ViewComponent)

function NightFeastBossClgView:ctor()
	NightFeastBossClgView.super.ctor(self)
end

function NightFeastBossClgView:buildUI()
	NightFeastBossClgView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnLevels = self:getBtn("btnLevels")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtBossNum = self:getTxt("txtBossNum")

	local rewardRoot = self:getGo("rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtPlayerScore = self:getTxt("rewardRoot/total/txtTotal")
	self._con = self:getGo("con")
end

function NightFeastBossClgView:bindEvents()
	NightFeastBossClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnLevels, self._onClickLevels, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function NightFeastBossClgView:unbindEvents()
	NightFeastBossClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.addClickHandler(self._btnRank)
	GameUtil.addClickHandler(self._btnBuff)
	GameUtil.addClickHandler(self._btnLevels)
	GameUtil.addClickHandler(self._btnChallenge)
end

function NightFeastBossClgView:onEnter()
	NightFeastBossClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgGainProgressPrizeRes, self._onGainProgressPrizeRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = NightFeastBossConfig.instance:getActivityCfg(self._activityId)
	self._maxFightBossNum = self._cfgActivity.dailyFightBossCount

	self:_initView()
	self:_showRoleModel(self._con, self._cfgActivity.raceId)
end

function NightFeastBossClgView:onExit()
	NightFeastBossClgView.super.onExit(self)
	self:_resetRoleModel()
end

function NightFeastBossClgView:_onClickTip()
	TipsFacade.instance:openRulesView("nightfeastbossclgview_rule")
end

function NightFeastBossClgView:_onClickRank()
	UIStateManager.instance:push(ViewName.NightFeastBossRankView, self._activityId)
end

function NightFeastBossClgView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NightFeastBossBuffView, self._activityId)
end

function NightFeastBossClgView:_onClickLevels()
	UIStateManager.instance:push(ViewName.NightFeastBossLevelView, self._activityId)
end

function NightFeastBossClgView:_onClickChallenge()
	local curNum = NightFeastBossModel.instance:getDailyHasFightBossCount(self._activityId)
	local leftNum = Mathf.Max(0, self._maxFightBossNum - curNum)

	if leftNum > 0 then
		NightFeastBossController.instance:openBossMissionView(self._activityId)
	else
		FloatWordMgr.instance:show("无挑战次数")
	end
end

function NightFeastBossClgView:_onGainProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function NightFeastBossClgView:_initView()
	local curNum = NightFeastBossModel.instance:getDailyHasFightBossCount(self._activityId)
	local leftNum = Mathf.Max(0, self._maxFightBossNum - curNum)

	if leftNum > 0 then
		if not ColorConst.White then
			local colorStr = ColorConst.Red

			self._txtBossNum.text = string.format("今日剩余次数：<color=#%s>%d</color>/%d", colorStr, leftNum, self._maxFightBossNum)

			self:_initRewardParams()
			self:_setPlayerScore()
			self._playerSliderMo:updateAndRelocationReward()
		end
	end
end

function NightFeastBossClgView:_setPlayerScore()
	self._txtPlayerScore.text = NightFeastBossModel.instance:getRewardProgress(self._activityId)
end

function NightFeastBossClgView:_initRewardParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = NightFeastBossConfig.instance:getProgressList(self._activityId)

	function playerParam.getPlayerProgress()
		return NightFeastBossModel.instance:getRewardProgress(self._activityId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return checknumber(rewardCfg.progress)
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.prize, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return NightFeastBossModel.instance:isPlayerRewardCanGet(self._activityId, rewardCfg.dataBitId, checknumber(rewardCfg.progress))
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return NightFeastBossModel.instance:isPlayerRewardGeted(self._activityId, rewardCfg.dataBitId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGainProgressPrizeReq(self._activityId, rewardCfg.dataBitId)
	end

	self._playerSliderMo:initParam(playerParam, true)
	self._playerSliderMo:initSlider()
end

function NightFeastBossClgView:_showRoleModel(go, raceId)
	local curFaceId = raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, go, scale, nil, true, x, y)
end

function NightFeastBossClgView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return NightFeastBossClgView
