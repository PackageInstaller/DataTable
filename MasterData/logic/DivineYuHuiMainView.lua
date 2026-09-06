-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiMainView.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiMainView", package.seeall)

local DivineYuHuiMainView = class("DivineYuHuiMainView", ViewComponent)

function DivineYuHuiMainView:ctor()
	DivineYuHuiMainView.super.ctor(self)
end

function DivineYuHuiMainView:unbindEvents()
	DivineYuHuiMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DivineYuHuiMainView:bindEvents()
	DivineYuHuiMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, self._onClickFirPass, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnExtClg, self)
end

function DivineYuHuiMainView:buildUI()
	DivineYuHuiMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnChallenge = self:getGo("btnExtClg/btn")
	self._firstPass = self:getGo("btnExtClg/firstPass")
end

function DivineYuHuiMainView:onExit()
	DivineYuHuiMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._role)
	MaterialMgr.resetAll(self._pointRare)
end

function DivineYuHuiMainView:onEnter()
	DivineYuHuiMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineYuHuiClgInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 499001
	end

	self._actCfg = DivineYuHuiConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	DivineYuHuiController.instance:sendPM_DivineYuHuiClgInfoReq(self._activityId)
end

function DivineYuHuiMainView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end
end

function DivineYuHuiMainView:_onUpdate()
	self._info = DivineYuHuiModel.instance:getInfo(self._activityId) or {}

	GameUtil.SetActive(self._firstPass, self._info.hadGainFinishPrize)
end

function DivineYuHuiMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function DivineYuHuiMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function DivineYuHuiMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function DivineYuHuiMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineYuHuiMainView:_onClickBtnExtClg()
	UIStateManager.instance:push(ViewName.DivineYuHuiChallengeView, self._activityId)
end

function DivineYuHuiMainView:_onClickFirPass()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

return DivineYuHuiMainView
