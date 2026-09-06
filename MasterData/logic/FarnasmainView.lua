-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasmainView.lua

module("logic.extensions.farnas.view.FarnasmainView", package.seeall)

local FarnasmainView = class("FarnasmainView", ViewComponent)

function FarnasmainView:buildUI()
	FarnasmainView.super.buildUI(self)

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
	self._clgBtnCol_btnClg1_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/imgPass")
	self._clgBtnCol_btnClg1_bubble = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble")
	self._clgBtnCol_btnClg1_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/itemcell")
	self._clgBtnCol_btnClg1_bubble_imgHasGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/imgHasGain")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
	self._clgBtnCol_btnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2")
	self._clgBtnCol_btnClg2_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._clgBtnCol_btnClg2_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._clgBtnCol_btnClg2_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/imgPass")
	self._effectGo1 = self:getGo("clgBtnCol/btnClg1/bubble/effect")

	self:_recordGoDefaultActive(self._clgBtnCol_btnClg1_bubble)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg2)
	self:_recordGoDefaultActive(self._jumpBtnCol)
end

function FarnasmainView:bindEvents()
	FarnasmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg2_btn, self._onClickBtnClg2, self)
end

function FarnasmainView:unbindEvents()
	FarnasmainView.super.unbindEvents(self)
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

function FarnasmainView:onEnter()
	FarnasmainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = FarnasController.instance:getActivityId()
	end

	self._activityType = FarnasController.instance:getActivityType()

	local isInTime = FarnasController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actCfg = FarnasConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.FarnasClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.FarnasClgGainExtremePrizeRes, self._onUpdate, self)
	RedPointController.instance:regRedPoint(self._clgBtnCol_btnClg2_redPoint, RedPointModel.ID_Farnas_NorPrize)
	RedPointController.instance:regRedPoint(self._clgBtnCol_btnClg1_redPoint, RedPointModel.ID_Farnas_ExtPrize)
	FarnasChallengeAgent.instance:sendPM_FarnasClgGetInfoReq(self._activityId)
end

function FarnasmainView:onExit()
	FarnasmainView.super.onExit(self)

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

function FarnasmainView:_onSetUI()
	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble, false)
		GameUtil.SetActive(self._clgBtnCol_btnClg2, false)
		GameUtil.SetActive(self._jumpBtnCol, false)
	else
		self:_refreshDefaultActive(self._clgBtnCol_btnClg1_bubble)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg2)
		self:_refreshDefaultActive(self._jumpBtnCol)
	end

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	self:_updateExtBubble()
end

function FarnasmainView:_onUpdate()
	local result, tips = FarnasController.instance:getTryEnterExtClgResultAndTips(self._activityId)

	GameUtil.SetActive(self._clgBtnCol_btnClg1_imgPass, result == GameEnum.ResultCode.IsHasGain)
	GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble_imgHasGain, result == GameEnum.ResultCode.IsHasGain)

	local result, tips = FarnasController.instance:getTryEnterNorClgResultAndTips(self._activityId)

	GameUtil.SetActive(self._clgBtnCol_btnClg2_imgPass, result == GameEnum.ResultCode.IsHasGain)
	self:_updateExtBubble()
end

function FarnasmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function FarnasmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function FarnasmainView:_getRaceId()
	return FarnasController.instance:getRaceId(self._activityId)
end

function FarnasmainView:_getSkinId()
	return FarnasConfig.instance:getSkinId(self._activityId)
end

function FarnasmainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function FarnasmainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local result, tips = FarnasController.instance:getTryEnterExtClgResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	UIStateManager.instance:push(ViewName.FarnasextView, self._activityId)
end

function FarnasmainView:_onClickBtnClg2()
	if self._isAoqiGodProcessType then
		return
	end

	UIStateManager.instance:push(ViewName.FarnasnorView, self._activityId)
end

function FarnasmainView:_onClickBtnTip()
	local key = FarnasConfig.instance:getRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function FarnasmainView:_updateExtBubble()
	local proxy = MaterialMgr.setCellByCfg(self._actCfg.extremeClgPrize, self._clgBtnCol_btnClg1_bubble_itemcell)
	local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.extremeClgPrize)

	self._clgBtnCol_btnClg1_bubble_txt.text = string.format("通关获得%s", matName)

	local isCanGain = not FarnasController.instance:isHasGainExtremeClgPrize() and FarnasController.instance:isPassAllOfExtStage(self._activityId)

	proxy.binder:setAutoTips(not isCanGain)

	if isCanGain then
		proxy.binder:setCallBack(function()
			FarnasChallengeAgent.instance:sendPM_FarnasClgGainExtremePrizeReq(self._activityId)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	goutil.setActive(self._effectGo1, isCanGain)

	if isCanGain then
		self:_playExtPrizeEffect()
	end
end

function FarnasmainView:_playExtPrizeEffect()
	if self._effectHandler then
		return
	end

	local effName = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo1.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1.4)
end

function FarnasmainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function FarnasmainView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return FarnasmainView
