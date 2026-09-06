-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgCommonView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgCommonView", package.seeall)

local NuoYaSisterClgCommonView = class("NuoYaSisterClgCommonView", ViewComponent)

function NuoYaSisterClgCommonView:ctor()
	NuoYaSisterClgCommonView.super.ctor(self)
end

function NuoYaSisterClgCommonView:unbindEvents()
	NuoYaSisterClgCommonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRightChallenge)
	GameUtil.rmClickHandler(self._btnLeftChallenge)
	GameUtil.rmClickHandler(self._btnScore)
end

function NuoYaSisterClgCommonView:bindEvents()
	NuoYaSisterClgCommonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRightChallenge, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLeftChallenge, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnScore, self._onClickScore, self)
end

function NuoYaSisterClgCommonView:buildUI()
	NuoYaSisterClgCommonView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRightChallenge = self:getGo("btnRightChallenge")
	self._btnLeftChallenge = self:getGo("btnLeftChallenge")
	self._btnScore = self:getGo("btnScore")
	self._txtNameA = self:getTxt("petInfo_A/txtNameA")
	self._rareA = self:getGo("petInfo_A/rare")
	self._txtNameB = self:getTxt("petInfo_B/txtNameB")
	self._rareB = self:getGo("petInfo_B/rare")
	self._petCon_1 = self:getGo("petCon_1")
	self._petCon_2 = self:getGo("petCon_2")
	self._txtDamageA = self:getTxt("damageA/txtDamageA")
	self._txtDamageB = self:getTxt("damageB/txtDamageB")
	self._txtDamageDiff = self:getTxt("damageDiff/txtDamageDiff")

	local playerRoot = self:getGo("playerRoot")

	self._rewardSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtTotal = self:getTxt("playerRoot/txtTotal")
end

function NuoYaSisterClgCommonView:onExit()
	NuoYaSisterClgCommonView.super.onExit(self)
	self._rewardSliderMo:onExit()
	RoleObjectPool.instance:removeRole(self._raceObj_1)
	RoleObjectPool.instance:removeRole(self._raceObj_2)
	MaterialMgr.resetAll(self._rareA)
	MaterialMgr.resetAll(self._rareB)
end

function NuoYaSisterClgCommonView:onEnter()
	NuoYaSisterClgCommonView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NuoYaSisterCommonClgInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()

	self:initSlider()

	self._day = NuoYaSisterClgModel.instance:getCommonDay(self._activityId)
	self._commonBossCfg = NuoYaSisterClgConfig.instance:getCommonBossCfg(self._activityId, self._day)

	local petACfg = CharacterConfig.instance:getPetCo(self._commonBossCfg.bossARaceId)

	self._txtNameA.text = petACfg.name
	self._raceObj_1 = RoleObjectPool.instance:addRoleToParent(self._raceObj_1, self._commonBossCfg.bossARaceId, self._petCon_1)

	MaterialMgr.setCell(MatType.Rare, self._commonBossCfg.bossARaceId, self._rareA)

	local petBCfg = CharacterConfig.instance:getPetCo(self._commonBossCfg.bossBRaceId)

	self._txtNameB.text = petBCfg.name
	self._raceObj_2 = RoleObjectPool.instance:addRoleToParent(self._raceObj_2, self._commonBossCfg.bossBRaceId, self._petCon_2)

	MaterialMgr.setCell(MatType.Rare, self._commonBossCfg.bossBRaceId, self._rareB)
	NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterCommonClgInfoReq(self._activityId)
end

function NuoYaSisterClgCommonView:_refreshView()
	local bossADamage = NuoYaSisterClgModel.instance:getBossADamage(self._activityId)
	local bossBDamage = NuoYaSisterClgModel.instance:getBossBDamage(self._activityId)

	self._txtDamageA.text = langPara("今日最高伤害：%d", bossADamage)
	self._txtDamageB.text = langPara("今日最高伤害：%d", bossBDamage)
	self._txtDamageDiff.text = langPara("伤害差值\n<size=40>%d</size>", math.abs(bossADamage - bossBDamage))
	self._txtTotal.text = NuoYaSisterClgModel.instance:getCommonScore(self._activityId)

	self._rewardSliderMo:updatePlayerReward()
end

function NuoYaSisterClgCommonView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = NuoYaSisterClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	function sliderParam.getPlayerProgress()
		return NuoYaSisterClgModel.instance:getCommonScore(self._activityId)
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return NuoYaSisterClgModel.instance:isCanGetProgressReward(rewardCfg.activityId, rewardCfg.prizeId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return NuoYaSisterClgModel.instance:isGetedProgressReward(rewardCfg.activityId, rewardCfg.prizeId)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterCommonClgGainPrizeReq(rewardCfg.activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function NuoYaSisterClgCommonView:_onClickLeft()
	local fmtMo = NuoYaSisterClgModel.instance:getComFmtMo()

	fmtMo:initParams(self._activityId, self._day, NuoYaSisterClgModel.BOSSA_ID)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function NuoYaSisterClgCommonView:_onClickRight()
	local fmtMo = NuoYaSisterClgModel.instance:getComFmtMo()

	fmtMo:initParams(self._activityId, self._day, NuoYaSisterClgModel.BOSSB_ID)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function NuoYaSisterClgCommonView:_onClickScore()
	UIStateManager.instance:push(ViewName.NuoYaSisterClgScoreView, self._activityId)
end

return NuoYaSisterClgCommonView
