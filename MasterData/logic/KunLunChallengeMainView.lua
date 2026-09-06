-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunChallengeMainView.lua

module("logic.extensions.kunlunchallenge.view.KunLunChallengeMainView", package.seeall)

local KunLunChallengeMainView = class("KunLunChallengeMainView", ViewComponent)

function KunLunChallengeMainView:buildUI()
	KunLunChallengeMainView.super.buildUI(self)

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
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._clgBtnCol = goutil.findChild(self.mainGO, "clgBtnCol")
	self._clgBtnCol_btnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1")
	self._clgBtnCol_btnClg1_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._clgBtnCol_btnClg1_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._clgBtnCol_btnClg1_bubble = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble")
	self._clgBtnCol_btnClg1_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/itemcell")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
	self._clgBtnCol_btnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2")
	self._clgBtnCol_btnClg2_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._clgBtnCol_btnClg2_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._clgBtnCol_btnClg2_txtDesc = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg2/desc/txt")
	self._goDefaultActives = {}

	self:_recordGoDefaultActive(self._jumpBtnCol)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg2)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg1_bubble)
end

function KunLunChallengeMainView:bindEvents()
	KunLunChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "KUNLUNCHALLENGE_JUMP_KEY_1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "KUNLUNCHALLENGE_JUMP_KEY_2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "KUNLUNCHALLENGE_JUMP_KEY_3"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg2_btn, self._onClickBtnClg2, self)
end

function KunLunChallengeMainView:unbindEvents()
	KunLunChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_btn)
end

function KunLunChallengeMainView:_recordGoDefaultActive(go)
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function KunLunChallengeMainView:_isActiveInDefault(go)
	return self._goDefaultActives[go]
end

function KunLunChallengeMainView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

function KunLunChallengeMainView:onEnter()
	KunLunChallengeMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KunLunChallengeController.instance:getActivityId()
	end

	self._activityType = KunLunChallengeController.instance:getActivityType()

	local isInTime = KunLunChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._klActData = KunLunChallengeConfig.instance:getKlActData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.KunLunCommonClgInfoRes, self._onUpdate, self)

	if not self._isAoqiGodProcessType then
		KunLunChallengeController.instance:sendPM_KunLunCommonClgInfoReq(self._activityId)
	end
end

function KunLunChallengeMainView:onExit()
	KunLunChallengeMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump1_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump2_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump3_redPoint)
	RedPointController.instance:unregRedPoint(self._clgBtnCol_btnClg1_redPoint)
end

function KunLunChallengeMainView:_onSetUI()
	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
		GameUtil.SetActive(self._clgBtnCol_btnClg2, not self._isAoqiGodProcessType)
		GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble, not self._isAoqiGodProcessType)
	else
		self:_refreshDefaultActive(self._jumpBtnCol)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg2)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg1_bubble)
	end

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redId = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, "KUNLUNCHALLENGE_JUMP_RED_1")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump1_redPoint, redId)
	end

	local redId = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, "KUNLUNCHALLENGE_JUMP_RED_2")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump2_redPoint, redId)
	end

	local redId = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, "KUNLUNCHALLENGE_JUMP_RED_3")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump3_redPoint, redId)
	end

	local redIdList = {
		RedPointModel.ID_KUNLUNCHALLENGE_NORMAL_CLG_TIMES
	}

	RedPointController.instance:regRedPoint(self._clgBtnCol_btnClg2_redPoint, unpack(redIdList))

	local extremePrize = self._klActData.extremePrize

	if not string.nilorempty(extremePrize) then
		MaterialMgr.setCellByCfg(extremePrize, self._clgBtnCol_btnClg1_bubble_itemcell)

		local matName = MaterialMgr.getMaterialsNameByCfg(extremePrize)

		self._clgBtnCol_btnClg1_bubble_txt.text = string.format("通关获得%s", matName)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function KunLunChallengeMainView:_onUpdate()
	return
end

function KunLunChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KunLunChallengeMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KunLunChallengeMainView:_getRaceId()
	return KunLunChallengeController.instance:getRaceId(self._activityId)
end

function KunLunChallengeMainView:_getSkinId()
	return KunLunChallengeController.instance:getSkinId(self._activityId)
end

function KunLunChallengeMainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, key, false)

	GotoMgr.gotoByString(jumpToStr)
end

function KunLunChallengeMainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.KunLunChallengeExtremeView, self._activityId)
end

function KunLunChallengeMainView:_onClickBtnClg2()
	if self._isAoqiGodProcessType then
		return
	end

	UIStateManager.instance:push(ViewName.KunLunChallengeNormalView)
end

function KunLunChallengeMainView:_onClickBtnTip()
	local key = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, "KUNLUNCHALLENGE_RULE_MAIN_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return KunLunChallengeMainView
