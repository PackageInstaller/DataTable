-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinMainView.lua

module("logic.extensions.xiayin.view.XiaYinMainView", package.seeall)

local XiaYinMainView = class("XiaYinMainView", ViewComponent)

function XiaYinMainView:buildUI()
	XiaYinMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnGift1 = self:getBtn("btnGift1")
	self._btnGift2 = self:getBtn("btnGift2")
	self._btnRank = self:getBtn("btnRank")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._buffRoot = self:getGo("buffRoot")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")

	local rewardRoot = self:getGo("rewardRoot")

	self._rewardRoot = rewardRoot
	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtPlayerScore = self:getTxt("total/txtTotal")
	self._totalGo = self:getGo("total")
end

function XiaYinMainView:bindEvents()
	XiaYinMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnSummon, self._onClickSummon, self)
	GameUtil.addClickHandler(self._btnGift1, self._onClickGift1, self)
	GameUtil.addClickHandler(self._btnGift2, self._onClickGift2, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function XiaYinMainView:unbindEvents()
	XiaYinMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnGift1)
	GameUtil.rmClickHandler(self._btnGift2)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function XiaYinMainView:onEnter()
	XiaYinMainView.super.onEnter(self)
	XiaYinModel.instance:setJumpViews(ViewName.XiaYinMainView, ViewName.XiaYinLevelView, ViewName.XiaYinResultView)
	self.addGEvent(self, GlobalNotify.XiaYinGetInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.XiaYinGainProgressPrizeRes, self._onGainProgressPrizeRes, self)

	local actId = checknumber(self:getFirstParam())

	self._activityId = actId > 0 and actId or 336001
	self._activityType = XiaYinModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)

	self._cfgActivity = XiaYinConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	self:_initRewardParams()
	self:_setPlayerScore()
	self:_hideAoqiGodNodes()
	XiaYinAgent.instance:sendPM_XiaYinGetInfoReq(self._activityId)
end

function XiaYinMainView:onExit()
	XiaYinMainView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function XiaYinMainView:_onClickTip()
	TipsFacade.instance:openRulesView("xiayinmainview_rule")
end

function XiaYinMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function XiaYinMainView:_onClickGift1()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function XiaYinMainView:_onClickGift2()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function XiaYinMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo4)
end

function XiaYinMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.XiaYinLevelView, self._activityId)
end

function XiaYinMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function XiaYinMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function XiaYinMainView:_onGetInfoRes()
	self._playerSliderMo:updateAndRelocationReward()
	self:_setPlayerScore()
end

function XiaYinMainView:_onGainProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function XiaYinMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function XiaYinMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function XiaYinMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function XiaYinMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function XiaYinMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function XiaYinMainView:_setPlayerScore()
	self._txtPlayerScore.text = XiaYinModel.instance:getRewardProgress(self._activityId)
end

function XiaYinMainView:_initRewardParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = XiaYinConfig.instance:getPrizeCfgList(self._activityId)

	function playerParam.getPlayerProgress()
		return XiaYinModel.instance:getRewardProgress(self._activityId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.prize, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return XiaYinModel.instance:isPlayerRewardCanGet(self._activityId, rewardCfg.prizeId, rewardCfg.progress)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return XiaYinModel.instance:isPlayerRewardGeted(self._activityId, rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		XiaYinAgent.instance:sendPM_XiaYinGainProgressPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	self._playerSliderMo:initParam(playerParam, true)
	self._playerSliderMo:initSlider()
end

function XiaYinMainView:_hideAoqiGodNodes()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	goutil.setActive(self._btnSummon.gameObject, not self._isAoqiGodProcessType)
	goutil.setActive(self._btnRank.gameObject, not self._isAoqiGodProcessType)
	goutil.setActive(self._rewardRoot, not self._isAoqiGodProcessType)
	goutil.setActive(self._totalGo, not self._isAoqiGodProcessType)
end

return XiaYinMainView
