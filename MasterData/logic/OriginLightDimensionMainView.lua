-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionMainView.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionMainView", package.seeall)

local OriginLightDimensionMainView = class("OriginLightDimensionMainView", ViewComponent)

function OriginLightDimensionMainView:ctor()
	OriginLightDimensionMainView.super.ctor(self)
end

function OriginLightDimensionMainView:unbindEvents()
	OriginLightDimensionMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPassport)
	GameUtil.rmClickHandler(self._btnNormal)
	GameUtil.rmClickHandler(self._btnExtremeChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function OriginLightDimensionMainView:bindEvents()
	OriginLightDimensionMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnPassport, self._onClickPassport, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnExtremeChallenge, self._onClickExtremeChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function OriginLightDimensionMainView:buildUI()
	OriginLightDimensionMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnShop = self:getGo("btnShop")
	self._btnPassport = self:getGo("btnPassport")
	self._btnNormal = self:getGo("btnNormal")
	self._normalPassGo = self:getGo("btnNormal/pass")
	self._btnExtremeChallenge = self:getGo("btnExtremeChallenge")
	self._extremePassGo = self:getGo("btnExtremeChallenge/pass")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
	self._prizeExtCon = self:getGo("bubbleExt/item")
	self._tagExtHasGain = self:getGo("bubbleExt/tagHasGain")
	self._prizeNormalCon = self:getGo("bubbleNormal/item")
	self._tagNormalHasGain = self:getGo("bubbleNormal/tagHasGain")
	self._txtReset = self:getTxt("btnReset/txt")
end

function OriginLightDimensionMainView:onExit()
	OriginLightDimensionMainView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	MaterialMgr.resetAll(self._petRareCon)
end

function OriginLightDimensionMainView:onEnter()
	OriginLightDimensionMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginLightDimensionGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 610001
	end

	self._activityCfg = OriginLightDimensionConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	MaterialMgr.setCellByCfg(self._activityCfg.extremeClgPrize, self._prizeExtCon)
	MaterialMgr.setCellByCfg(self._activityCfg.normalClgPrize, self._prizeNormalCon)
	OriginLightDimensionAgent.instance:sendPM_OriginLightDimensionInfoReq(self._activityId)
end

function OriginLightDimensionMainView:_refreshView()
	GameUtil.SetActive(self._extremePassGo, OriginLightDimensionModel.instance:isGainExtremePrize(self._activityId))
	GameUtil.SetActive(self._tagExtHasGain, OriginLightDimensionModel.instance:isGainExtremePrize(self._activityId))
	GameUtil.SetActive(self._normalPassGo, OriginLightDimensionModel.instance:isGainNormalPrize(self._activityId))
	GameUtil.SetActive(self._tagNormalHasGain, OriginLightDimensionModel.instance:isGainNormalPrize(self._activityId))
end

function OriginLightDimensionMainView:_onClickFirstRank()
	if not string.nilorempty(self._activityCfg.jumpToFirstRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToFirstRank)
	end
end

function OriginLightDimensionMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpToRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToRank)
	end
end

function OriginLightDimensionMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpToPrize) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPrize)
	end
end

function OriginLightDimensionMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpToShop) then
		GotoMgr.gotoByString(self._activityCfg.jumpToShop)
	end
end

function OriginLightDimensionMainView:_onClickPassport()
	if not string.nilorempty(self._activityCfg.jumpToPassport) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPassport)
	end
end

function OriginLightDimensionMainView:_onClickTip()
	TipsFacade.instance:openRulesView("origin_light_dimension_rule")
end

function OriginLightDimensionMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function OriginLightDimensionMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function OriginLightDimensionMainView:_onClickNormal()
	local stageCfgs = OriginLightDimensionConfig.instance:getNormalStageCfgs(self._activityId)

	if OriginLightDimensionModel.instance:getMaxNormalPassStage(self._activityId) >= #stageCfgs then
		FloatWordMgr.instance:show(lang("已领取所有奖励"))

		return
	end

	UIStateManager.instance:push(ViewName.OriginLightDimensionNormalView, self._activityId)
end

function OriginLightDimensionMainView:_onClickExtremeChallenge()
	UIStateManager.instance:push(ViewName.OriginLightDimensionExtremeView, self._activityId)
end

return OriginLightDimensionMainView
