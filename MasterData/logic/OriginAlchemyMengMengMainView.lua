-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengMainView.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengMainView", package.seeall)

local OriginAlchemyMengMengMainView = class("OriginAlchemyMengMengMainView", ViewComponent)

function OriginAlchemyMengMengMainView:ctor()
	OriginAlchemyMengMengMainView.super.ctor(self)
end

function OriginAlchemyMengMengMainView:unbindEvents()
	OriginAlchemyMengMengMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginAlchemyMengMengMainView:bindEvents()
	OriginAlchemyMengMengMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnChallenge, self._onBtnChallenge, self)
end

function OriginAlchemyMengMengMainView:buildUI()
	OriginAlchemyMengMengMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._firstPass = self:getGo("btnNorClg/firstPass")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._item = self:getGo("reward/item")
	self._tagHasGain = self:getGo("reward/tagHasGain")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/redPoint")
end

function OriginAlchemyMengMengMainView:onExit()
	OriginAlchemyMengMengMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)
	MaterialMgr.resetAll(self._item)
end

function OriginAlchemyMengMengMainView:onEnter()
	OriginAlchemyMengMengMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginAlchemyMengMengGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 601001
	end

	self._actCfg = OriginalChemyMengMengConfig.instance:getActivityCfg(self._activityId) or {}

	self:_onSetUI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	OriginalChemyMengMengController.instance:sendPM_OriginAlchemyMengMengGetInfoReq(self._activityId)
end

function OriginAlchemyMengMengMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = checknumber(self._actCfg.skinId)
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)

	self._txtPetNameInInfo.text = (petData or nil) and petData.name or ""

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	MaterialMgr.setCellByCfg(self._actCfg.passPrize or self._actCfg.prize, self._item)
end

function OriginAlchemyMengMengMainView:_onUpdate()
	local info = OriginalChemyMengMengModel.instance:getInfo(self._activityId)

	GameUtil.SetActive(self._firstPass, info.hasGainPrize)
	GameUtil.SetActive(self._tagHasGain, info.hasGainPrize)
end

function OriginAlchemyMengMengMainView:_onClickBtnJump(jumpIdx)
	local jumpTo = self._actCfg.jumpTo
	local jumpStr = jumpTo and jumpTo[jumpIdx]

	if jumpStr then
		GotoMgr.gotoByString(jumpStr)
	end
end

function OriginAlchemyMengMengMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	if key then
		TipsFacade.instance:openRulesView(key)
	end
end

function OriginAlchemyMengMengMainView:_onBtnSkillClg()
	local skinId = checknumber(self._actCfg.skinId)

	if skinId > 0 then
		PetbookController.instance:previewBattle(skinId)
	end
end

function OriginAlchemyMengMengMainView:_onBtnIntroduceClg()
	local skinId = checknumber(self._actCfg.skinId)

	if skinId > 0 then
		PetbookController.instance:openPetinfoView(skinId)
	end
end

function OriginAlchemyMengMengMainView:_onBtnChallenge()
	UIStateManager.instance:push(ViewName.OriginAlchemyMengMengLevelView, self._activityId)
end

function OriginAlchemyMengMengMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or lang("点击激活buff")
	end
end

return OriginAlchemyMengMengMainView
