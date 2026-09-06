-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/view/DivineGasiriMainView.lua

module("logic.extensions.divinegasiri.view.DivineGasiriMainView", package.seeall)

local DivineGasiriMainView = class("DivineGasiriMainView", ViewComponent)

function DivineGasiriMainView:ctor()
	DivineGasiriMainView.super.ctor(self)
end

function DivineGasiriMainView:buildUI()
	DivineGasiriMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._passGo = self:getGo("btnChallenge/pass")
	self._buffRoot = self:getGo("buffRoot")
end

function DivineGasiriMainView:bindEvents()
	DivineGasiriMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "junpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "junpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "junpStr3"))
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function DivineGasiriMainView:unbindEvents()
	DivineGasiriMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	self._btnChallenge:RemoveClickListener()
end

function DivineGasiriMainView:onEnter()
	DivineGasiriMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DivineAresMomGetInfoRes, self._updateUIByInfo, self)
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	DivineGasiriController.instance:sendPM_DivineAresMomGetInfoReq(self._activityId)
end

function DivineGasiriMainView:onExit()
	DivineGasiriMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)
end

function DivineGasiriMainView:_updateUIByCfg()
	self._actCfg = DivineGasiriConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end
end

function DivineGasiriMainView:_updateUIByInfo()
	DivineGasiriModel.instance:setCurActMo(self._activityId)

	local isPass = DivineGasiriModel.instance:getIsAllPass(self._activityId)

	goutil.setActive(self._passGo, isPass)
end

function DivineGasiriMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId ~= 0 then
		if raceId == skinId then
			PetbookController.instance:previewBattle(raceId)
		else
			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function DivineGasiriMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineGasiriMainView:_getRaceId()
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self:_getSkinId())

	return petSkinCfg and petSkinCfg.raceId
end

function DivineGasiriMainView:_getSkinId()
	return self._actCfg.skinId
end

function DivineGasiriMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DivineGasiriMainView:_onClickBtnTip()
	local key = self._actCfg.ruleTip

	TipsFacade.instance:openRulesView(key)
end

function DivineGasiriMainView:_onClickbtnChallenge()
	local isPass = DivineGasiriModel.instance:getIsAllPass(self._activityId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineGasiriStageView, self._activityId)
end

return DivineGasiriMainView
