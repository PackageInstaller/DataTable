-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/view/OriginHotBloodMMClgMainView.lua

module("logic.extensions.originhotbloodmmclg.view.OriginHotBloodMMClgMainView", package.seeall)

local OriginHotBloodMMClgMainView = class("OriginHotBloodMMClgMainView", ViewComponent)

function OriginHotBloodMMClgMainView:ctor()
	OriginHotBloodMMClgMainView.super.ctor(self)
end

function OriginHotBloodMMClgMainView:unbindEvents()
	OriginHotBloodMMClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPack)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnGainBuff)
end

function OriginHotBloodMMClgMainView:bindEvents()
	OriginHotBloodMMClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBtnBuy, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnPack, self._onClickBtnPack, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onBtnChallenge, self)
end

function OriginHotBloodMMClgMainView:buildUI()
	OriginHotBloodMMClgMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnBuy = self:getGo("jumpBtnCol/btnBuy")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnPack = self:getGo("jumpBtnCol/btnPack")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._item = self:getGo("reward/item")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._buffText = self:getTxt("buffCol/txtDesc")
	self._buffRed = self:getGo("buffCol/cell/redPoint")
	self._goAllPass = self:getGo("btnNorClg/goAllPass")
end

function OriginHotBloodMMClgMainView:onExit()
	OriginHotBloodMMClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)
	RoleObjectPool.instance:removeRole(self._role)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._item)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginHotBloodMMClgMainView:onEnter()
	OriginHotBloodMMClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginHotBloodMMClgGetInfoRes, self._refreshUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 599001
	end

	self._actCfg = OriginHotBloodMMClgConfig.instance:getActivity(self._activityId)

	self:_onSetUI()
	self:_refreshUI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	OriginHotBloodMMClgController.instance:sendInfoReq(self._activityId)
end

function OriginHotBloodMMClgMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local raceId = self._actCfg.raceId
	local petName
	local petData = CharacterConfig.instance:getPetCo(raceId)

	if petData then
		self._txtPetNameInInfo.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._con, nil, nil, true, nil, nil)

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)
	end

	MaterialMgr.setCellByCfg(self._actCfg.passPrize, self._item)
end

function OriginHotBloodMMClgMainView:_onClickBtnRank()
	GotoMgr.gotoByString(self._actCfg.jumpToRank)
end

function OriginHotBloodMMClgMainView:_onClickBtnBuy()
	GotoMgr.gotoByString(self._actCfg.jumpToPrize)
end

function OriginHotBloodMMClgMainView:_onClickBtnShop()
	GotoMgr.gotoByString(self._actCfg.jumpToShop)
end

function OriginHotBloodMMClgMainView:_onClickBtnPack()
	GotoMgr.gotoByString(self._actCfg.jumpToPack)
end

function OriginHotBloodMMClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginHotBloodMMClgMainView:_onBtnSkillClg()
	PetbookController.instance:previewBattle(self._actCfg.raceId)
end

function OriginHotBloodMMClgMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.raceId)
end

function OriginHotBloodMMClgMainView:_onBtnChallenge()
	if OriginHotBloodMMClgController.instance:isAllStagePassed(self._activityId) then
		TipsFacade.instance:openCommonTips(lang("已完成所有关卡"))

		return
	end

	UIStateManager.instance:push(ViewName.OriginHotBloodMMClgStageView, self._activityId)
end

function OriginHotBloodMMClgMainView:_refreshUI()
	self:_updateBuffUI(SignInBuffController.instance:getCurSignInBuffParam(self._activityId))
	GameUtil.SetActive(self._goAllPass, OriginHotBloodMMClgController.instance:isAllStagePassed(self._activityId))
end

function OriginHotBloodMMClgMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._buffRed, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._buffText.text = buffCfg.des or lang("点击激活Buff")
	end
end

return OriginHotBloodMMClgMainView
