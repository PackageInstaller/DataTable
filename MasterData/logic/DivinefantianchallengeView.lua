-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/copy/DivinefantianchallengeView.lua

module("logic.extensions.femalepsychic.view.copy.DivinefantianchallengeView", package.seeall)

local DivinefantianchallengeView = class("DivinefantianchallengeView", ViewComponent)

function DivinefantianchallengeView:ctor()
	DivinefantianchallengeView.super.ctor(self)
end

function DivinefantianchallengeView:unbindEvents()
	DivinefantianchallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnFullRefund)
	GameUtil.rmClickHandler(self._btnGainBuff)
end

function DivinefantianchallengeView:bindEvents()
	DivinefantianchallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickJumpShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickJumpRank, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickJumpLottery, self)
	GameUtil.addClickHandler(self._btnFullRefund, self._onClickJumpFullRefund, self)
	GameUtil.addClickHandler(self._btnGainBuff, self._onClickBuff, self)
end

function DivinefantianchallengeView:buildUI()
	DivinefantianchallengeView.super.buildUI(self)

	self._con = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._zdl = self:getGo("zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))
	self._txtTime = self:getTxt("time/txtTime")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnEnter = self:getBtn("btnEnter")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnShop = self:getBtn("jumpButton/btnShop")
	self._btnRank = self:getBtn("jumpButton/btnRank")
	self._btnLottery = self:getBtn("jumpButton/btnLottery")
	self._btnFullRefund = self:getBtn("jumpButton/btnFullRefund")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._txtBuffLv = self:getTxt("buffCol/Lv/txt")
	self._iconBuff = self:getGo("buffCol/cell/con/icon")
	self._rdBuff = self:getGo("buffCol/cell/rd")
end

function DivinefantianchallengeView:onExit()
	DivinefantianchallengeView.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
	RoleObjectPool.instance:removeRole(self._loader)
end

function DivinefantianchallengeView:onEnter()
	DivinefantianchallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FemalePsychicChallengeInfoRes, self._updateBuff, self)
	self.addGEvent(self, GlobalNotify.FemalePsychicChallengeUpgradeSignInBuffRes, self._updateBuff, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 253002
	end

	self._activityCfg = FemalePsychicChallengeConfig.instance:getActivityCfgById(self._activityId)

	self._zdl:SetNum(self._activityCfg.recZdl)
	self:_showPetInfo()
	self:_setTimeUI()
	self:_sendChallengeInfoReq()
end

function DivinefantianchallengeView:_sendChallengeInfoReq()
	FemalePsychicController.instance:sendPM_FemalePsychicChallengeInfoReq(self._activityId)
end

function DivinefantianchallengeView:_setTimeUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivinefantianchallengeView:_showPetInfo()
	self._raceId = TimeLimitedConfig.instance:getCfgById(200).raceId

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)

	local x, y, scale = 0, 0, 1

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._con, scale, nil, true, x, y)
	self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._raceId)
end

function DivinefantianchallengeView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DivinefantianchallengeView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

function DivinefantianchallengeView:_onClickTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(200)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivinefantianchallengeView:_onClickEnter()
	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FemalePsychicChallenge, self._activityId) then
		UIStateManager.instance:push(ViewName.DivinefantianlevelView, self._activityId)
	else
		FloatWordMgr.instance:show("不在活动时间范围内")
	end
end

function DivinefantianchallengeView:_onClickJumpShop()
	GotoMgr.gotoByString(self._activityCfg.jumpToShop)
end

function DivinefantianchallengeView:_onClickJumpRank()
	GotoMgr.gotoByString(self._activityCfg.jumpToRank)
end

function DivinefantianchallengeView:_onClickJumpLottery()
	GotoMgr.gotoByString(self._activityCfg.jumpToLottery)
end

function DivinefantianchallengeView:_onClickJumpFullRefund()
	GotoMgr.gotoByString(self._activityCfg.jumpToFullRefund)
end

function DivinefantianchallengeView:_onClickBuff()
	if not self._info then
		return
	end

	if self._info.signToday then
		FloatWordMgr.instance:show("今日已升级")

		return
	end

	FemalePsychicChallengeAgent.instance:sendPM_FemalePsychicChallengeUpgradeSignInBuffReq(self._activityId)
end

function DivinefantianchallengeView:_updateBuff()
	self._info = FemalePsychicModel.instance:getInfo()

	local curBuffLv = self._info.signInBuffLv
	local isGainBuff = self._info.signToday
	local buffCfgs = FemalePsychicChallengeConfig.instance:getBuffCfgs(self._activityId)
	local maxBuffLv = #buffCfgs
	local showEff = not isGainBuff and curBuffLv < maxBuffLv
	local buffCfg = buffCfgs[curBuffLv]

	self._txtBuffLv.text = string.format("Lv.%s", curBuffLv)

	if buffCfg then
		self._txtDescBuff.text = buffCfg.desc or "未激活"
	end

	goutil.setActive(self._rdBuff, showEff)
end

return DivinefantianchallengeView
