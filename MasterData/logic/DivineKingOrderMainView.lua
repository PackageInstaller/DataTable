-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderMainView.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderMainView", package.seeall)

local DivineKingOrderMainView = class("DivineKingOrderMainView", ViewComponent)

function DivineKingOrderMainView:ctor()
	DivineKingOrderMainView.super.ctor(self)
end

function DivineKingOrderMainView:buildUI()
	DivineKingOrderMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTimeGo = self:getGo("txtOpenTime")
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

function DivineKingOrderMainView:bindEvents()
	DivineKingOrderMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function DivineKingOrderMainView:unbindEvents()
	DivineKingOrderMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	self._btnChallenge:RemoveClickListener()
end

function DivineKingOrderMainView:onEnter()
	DivineKingOrderMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineKingOrderClgGetInfo, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineKingOrderClgController.instance:getActivityId()
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	DivineKingOrderClgModel.instance:setActivityId(self._activityId)

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = DivineKingOrderClgConfig.instance:getActCfg(self._activityId)

	self:_initAoqiGodUI()
	self:_updateUI()
	DivineKingOrderClgController.instance:getInfo(self._activityId)
end

function DivineKingOrderMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtOpenTimeGo, not self._isAoqiGodProcessType)
end

function DivineKingOrderMainView:onExit()
	DivineKingOrderMainView.super.onExit(self)

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

function DivineKingOrderMainView:_updateUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local isPass = DivineKingOrderClgModel.instance:isChallengePass(self._activityId)

	goutil.setActive(self._passGo, isPass)
end

function DivineKingOrderMainView:_onClickBtnSkill()
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

function DivineKingOrderMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineKingOrderMainView:_getRaceId()
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self:_getSkinId())

	return petSkinCfg and petSkinCfg.raceId
end

function DivineKingOrderMainView:_getSkinId()
	return self._actCfg.skinId
end

function DivineKingOrderMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineKingOrderMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineKingOrderMainView:_onClickbtnChallenge()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineKingOrderClg, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local isPass = DivineKingOrderClgModel.instance:isChallengePass(self._activityId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineKingOrderStageView)
end

return DivineKingOrderMainView
