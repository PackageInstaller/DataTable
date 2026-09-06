-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/view/DivineasheslessdragonmainView.lua

module("logic.extensions.divineasheslessdragon.view.DivineasheslessdragonmainView", package.seeall)

local DivineasheslessdragonmainView = class("DivineasheslessdragonmainView", ViewComponent)

function DivineasheslessdragonmainView:buildUI()
	DivineasheslessdragonmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._timeGo = goutil.findChild(self.mainGO, "txtOpenTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._passGo = self:getGo("btnChallenge/pass")
end

function DivineasheslessdragonmainView:bindEvents()
	DivineasheslessdragonmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function DivineasheslessdragonmainView:unbindEvents()
	DivineasheslessdragonmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	self._btnChallenge:RemoveClickListener()
end

function DivineasheslessdragonmainView:onEnter()
	DivineasheslessdragonmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineAsheslessDragonGetInfoRes, self._updateUI, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DivineasheslessdragonController.instance:getActivityId()
	end

	DivineasheslessdragonModel.instance:setActivityId(self._activityId)

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = DivineasheslessdragonConfig.instance:getActCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()
	self:_updateUI()
	DivineAsheslessDragonAgent.instance:sendPM_DivineAsheslessDragonGetInfoReq(self._activityId)
	DivineasheslessdragonController.instance:recordDailyEnter()
end

function DivineasheslessdragonmainView:onExit()
	DivineasheslessdragonmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function DivineasheslessdragonmainView:_initAoqiGodUI()
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._timeGo, not self._isAoqiGodProcessType)
end

function DivineasheslessdragonmainView:_updateUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local isPass = DivineasheslessdragonController.instance:isChallengePass(self._activityId)

	goutil.setActive(self._passGo, isPass)
end

function DivineasheslessdragonmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineasheslessdragonmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineasheslessdragonmainView:_getRaceId()
	return DivineasheslessdragonController.instance:getRaceId(self._activityId)
end

function DivineasheslessdragonmainView:_getSkinId()
	return DivineasheslessdragonConfig.instance:getSkinId(self._activityId)
end

function DivineasheslessdragonmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineasheslessdragonmainView:_onClickBtnTip()
	local key = DivineasheslessdragonConfig.instance:getRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function DivineasheslessdragonmainView:_onClickbtnChallenge()
	local isPass = DivineasheslessdragonController.instance:isChallengePass(self._activityId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineasheslessdragonlevelView)
end

return DivineasheslessdragonmainView
