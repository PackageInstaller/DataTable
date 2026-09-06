-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengemainView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengemainView", package.seeall)

local KingciyuanchallengemainView = class("KingciyuanchallengemainView", ViewComponent)

function KingciyuanchallengemainView:ctor()
	KingciyuanchallengemainView.super.ctor(self)
end

function KingciyuanchallengemainView:unbindEvents()
	KingciyuanchallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge_1)
	GameUtil.rmClickHandler(self._btnChallenge_2)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTry)
	GameUtil.rmClickHandler(self._btnPetInfo)
end

function KingciyuanchallengemainView:bindEvents()
	KingciyuanchallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge_1, self._onClickFight1, self)
	GameUtil.addClickHandler(self._btnChallenge_2, self._onClickFight2, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTry, self._onClickTry, self)
	GameUtil.addClickHandler(self._btnPetInfo, self._onClickInfo, self)
end

function KingciyuanchallengemainView:buildUI()
	KingciyuanchallengemainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnTry = self:getGo("btnTry")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._petRare = self:getGo("petInfo/rare")
	self._btnPetInfo = self:getGo("petInfo/btnInfo")
	self._btnChallenge_1 = self:getGo("btnChallenge_1")
	self._txtChallengeTip_1 = self:getTxt("btnChallenge_1/txtTip")
	self._redChallenge_1 = self:getGo("btnChallenge_1/redpoint")
	self._btnChallenge_2 = self:getGo("btnChallenge_2")
	self._txtChallengeTip_2 = self:getTxt("btnChallenge_2/txtTip")
	self._redChallenge_2 = self:getGo("btnChallenge_2/redpoint")
end

function KingciyuanchallengemainView:onExit()
	KingciyuanchallengemainView.super.onExit(self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	MaterialMgr.resetAll(self._petRare)
end

function KingciyuanchallengemainView:onEnter()
	KingciyuanchallengemainView.super.onEnter(self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)

	local activityId = checknumber(self:getFirstParam())

	if activityId == 0 then
		activityId = 241001
	end

	if activityId <= 0 then
		self:close()

		return
	end

	self._activityId = activityId
	self._activityConfig = KingCiYuanChallengeConfig.instance:getActivityConfig(self._activityId)

	self:_initUnChanged()
	KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanGetInfoReq(self._activityId)
end

function KingciyuanchallengemainView:_initUnChanged()
	self._txtChallengeTip_1.text = KingCiYuanChallengeConfig.instance:getCommonValue("A7")
	self._txtChallengeTip_2.text = KingCiYuanChallengeConfig.instance:getCommonValue("A8")

	local raceId = KingCiYuanChallengeConfig.instance:getCommonValue("A15", true)

	MaterialMgr.setCell(MatType.Rare, raceId, self._petRare)

	self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)
	self._txtPetName.text = self._skinCfg.name
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function KingciyuanchallengemainView:_invalidateAll()
	return
end

function KingciyuanchallengemainView:_onClickRule()
	local ruleKey = KingCiYuanChallengeConfig.instance:getCommonValue("A4")

	if not string.nilorempty(ruleKey) then
		UIStateManager.instance:open(ViewName.RulesView, ruleKey)
	end
end

function KingciyuanchallengemainView:_onClickFight1()
	local timeStart = GameUtil.string2time(self._activityConfig.extChallengeTime)

	if timeStart <= ServerTime.now() then
		UIStateManager.instance:push(ViewName.KingciyuanchallengelimitView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("不在开放时间内"))
	end
end

function KingciyuanchallengemainView:_onClickFight2()
	local timeStart = GameUtil.string2time(self._activityConfig.bossChallengeTime)

	if timeStart <= ServerTime.now() then
		UIStateManager.instance:push(ViewName.KingciyuanchallengebossView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("不在开放时间内"))
	end
end

function KingciyuanchallengemainView:_onClickRank()
	local gotoStr = KingCiYuanChallengeConfig.instance:getCommonValue("A2")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function KingciyuanchallengemainView:_onClickShop()
	local gotoStr = KingCiYuanChallengeConfig.instance:getCommonValue("A3")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function KingciyuanchallengemainView:_onClickTry()
	local gotoStr = KingCiYuanChallengeConfig.instance:getCommonValue("A1")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function KingciyuanchallengemainView:_onClickInfo()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:openPetinfoView(raceId)
	end
end

return KingciyuanchallengemainView
