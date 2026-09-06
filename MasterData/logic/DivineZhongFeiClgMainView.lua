-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgMainView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgMainView", package.seeall)

local DivineZhongFeiClgMainView = class("DivineZhongFeiClgMainView", ViewComponent)

function DivineZhongFeiClgMainView:ctor()
	DivineZhongFeiClgMainView.super.ctor(self)
end

function DivineZhongFeiClgMainView:unbindEvents()
	DivineZhongFeiClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnNormalChallenge)
	GameUtil.rmClickHandler(self._btnExtChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function DivineZhongFeiClgMainView:bindEvents()
	DivineZhongFeiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnNormalChallenge, self._onClickNormalChallenge, self)
	GameUtil.addClickHandler(self._btnExtChallenge, self._onClickExtChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function DivineZhongFeiClgMainView:buildUI()
	DivineZhongFeiClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnCard = self:getGo("btnCard")
	self._btnShop = self:getGo("btnShop")
	self._btnNormalChallenge = self:getGo("btnNormalChallenge")
	self._passNormal = self:getGo("btnNormalChallenge/pass")
	self._redpointNormal = self:getGo("btnNormalChallenge/redpoint")
	self._btnExtChallenge = self:getGo("btnExtChallenge")
	self._passExt = self:getGo("btnExtChallenge/pass")
	self._extPrizeCon = self:getGo("extremePrize/con")
	self._txtExtPrize = self:getTxt("extremePrize/txtPrize")
	self._receiveGo = self:getGo("extremePrize/receive")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
end

function DivineZhongFeiClgMainView:onExit()
	DivineZhongFeiClgMainView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	RedPointController.instance:unregRedPoint(self._redpointNormal)
end

function DivineZhongFeiClgMainView:onEnter()
	DivineZhongFeiClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineZhongFeiClgGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 515001
	end

	self._activityCfg = DivineZhongFeiClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.setCellByCfg(self._activityCfg.extremePrize, self._extPrizeCon)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.extremePrize)

	self._txtExtPrize.text = langPara("通关可获得%s", MaterialMgr.getMaterialsName(matType, matId))

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	DivineZhongFeiClgAgent.instance:sendPM_DivineZhongFeiClgExtremeInfoReq(self._activityId)
	DivineZhongFeiClgAgent.instance:sendPM_DivineZhongFeiClgNormalInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redpointNormal, self._activityCfg.redPointId)
end

function DivineZhongFeiClgMainView:_refreshView()
	GameUtil.SetActive(self._passExt, DivineZhongFeiClgModel.instance:isGainExtPassPrize(self._activityId))
	GameUtil.SetActive(self._receiveGo, DivineZhongFeiClgModel.instance:isGainExtPassPrize(self._activityId))

	local isGainAll = DivineZhongFeiClgController.instance:isAllNormalPrizeGain(self._activityId)

	GameUtil.SetActive(self._passNormal, isGainAll)
end

function DivineZhongFeiClgMainView:_onClickExtChallenge()
	UIStateManager.instance:push(ViewName.DivineZhongFeiClgExtremeView, self._activityId)
end

function DivineZhongFeiClgMainView:_onClickNormalChallenge()
	local isGainAll = DivineZhongFeiClgController.instance:isAllNormalPrizeGain(self._activityId)

	if not isGainAll then
		UIStateManager.instance:push(ViewName.DivineZhongFeiClgNormalView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("已领取所有奖励"))
	end
end

function DivineZhongFeiClgMainView:_onClickFirstRank()
	if not string.nilorempty(self._activityCfg.jumpToFirstRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToFirstRank)
	end
end

function DivineZhongFeiClgMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpToRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToRank)
	end
end

function DivineZhongFeiClgMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpToPrize) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPrize)
	end
end

function DivineZhongFeiClgMainView:_onClickCard()
	if not string.nilorempty(self._activityCfg.jumpToCard) then
		GotoMgr.gotoByString(self._activityCfg.jumpToCard)
	end
end

function DivineZhongFeiClgMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpToShop) then
		GotoMgr.gotoByString(self._activityCfg.jumpToShop)
	end
end

function DivineZhongFeiClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_zhong_fei_clg_rule")
end

function DivineZhongFeiClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineZhongFeiClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

return DivineZhongFeiClgMainView
