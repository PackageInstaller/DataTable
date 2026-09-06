-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgMainView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgMainView", package.seeall)

local DivineXiuErClgMainView = class("DivineXiuErClgMainView", ViewComponent)

function DivineXiuErClgMainView:ctor()
	DivineXiuErClgMainView.super.ctor(self)

	self._redGoPool = {}
end

function DivineXiuErClgMainView:buildUI()
	DivineXiuErClgMainView.super.buildUI(self)

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
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._jumpBtnCol_btnJump4_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4/redPoint")
	self._clgBtnCol = goutil.findChild(self.mainGO, "clgBtnCol")
	self._clgBtnCol_btnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1")
	self._clgBtnCol_btnClg1_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._clgBtnCol_btnClg1_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._clgBtnCol_btnClg1_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/imgPass")
	self._clgBtnCol_btnClg1_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/itemcell")
	self._clgBtnCol_btnClg1_bubble_imgHasGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/imgHasGain")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
	self._clgBtnCol_btnClg1_bubble_btnGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/btnGain")
	self._clgBtnCol_btnClg1_bubble_effRoot = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/effRoot")
	self._clgBtnCol_btnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2")
	self._clgBtnCol_btnClg2_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._clgBtnCol_btnClg2_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._clgBtnCol_btnClg2_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/imgPass")
	self._clgBtnCol_btnClg2_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/bubble/itemcell")
	self._clgBtnCol_btnClg2_bubble_imgHasGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/bubble/imgHasGain")
	self._clgBtnCol_btnClg2_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg2/bubble/txt")
	self._clgBtnCol_btnClg2_bubble_btnGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/bubble/btnGain")
	self._clgBtnCol_btnClg2_bubble_effRoot = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/bubble/effRoot")
end

function DivineXiuErClgMainView:bindEvents()
	DivineXiuErClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg2_btn, self._onClickBtnClg2, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_bubble_btnGain, self._onClickBtnClg1BubbleBtnGain, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg2_bubble_btnGain, self._onClickBtnClg2BubbleBtnGain, self)
end

function DivineXiuErClgMainView:unbindEvents()
	DivineXiuErClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_bubble_btnGain)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_bubble_btnGain)
end

function DivineXiuErClgMainView:onEnter()
	DivineXiuErClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(self._activityId)

	if self._activityId <= 0 then
		self._activityId = DivineXiuErClgController.instance:getActivityId()
	end

	self._activityType = DivineXiuErClgController.instance:getActivityType()

	local isInTime = DivineXiuErClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DivineXiuErClgConfig.instance:getDxecActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErGainNormalClgPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErGainExtremeClgPrizeRes, self._onUpdate, self)
	DivineXiuErClgController.instance:sendPM_DivineXiuErClgGetInfoReq(self._activityId)
end

function DivineXiuErClgMainView:onExit()
	DivineXiuErClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg2_bubble_itemcell)
	UIEffectManager.instance:stopEffect(self._effOfBtnClg1Bubble)

	self._effOfBtnClg1Bubble = nil

	UIEffectManager.instance:stopEffect(self._effOfBtnClg2Bubble)

	self._effOfBtnClg2Bubble = nil

	self:_unRegAllRedPoint()
end

function DivineXiuErClgMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local redInfoList = {}

	table.insert(redInfoList, {
		{
			DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "jumpRedIdOne")
		},
		self._jumpBtnCol_btnJump1_redPoint
	})
	table.insert(redInfoList, {
		{
			DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "jumpRedIdTwo")
		},
		self._jumpBtnCol_btnJump2_redPoint
	})
	table.insert(redInfoList, {
		{
			DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "jumpRedIdThree")
		},
		self._jumpBtnCol_btnJump3_redPoint
	})
	table.insert(redInfoList, {
		{
			DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "jumpRedIdFour")
		},
		self._jumpBtnCol_btnJump4_redPoint
	})

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]
		local redIdList = {}

		for _, redId in ipairs(list) do
			if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
				table.insert(redIdList, redId)
			end
		end

		self:_regRedPoint(redGo, redIdList)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	MaterialMgr.setCellByCfg(self._actData.normalClgPrize, self._clgBtnCol_btnClg1_bubble_itemcell)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._actData.normalClgPrize)

	self._clgBtnCol_btnClg1_bubble_txt.text = string.format("通关获得%s", matName)

	MaterialMgr.setCellByCfg(self._actData.extremeClgPrize, self._clgBtnCol_btnClg2_bubble_itemcell)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._actData.extremeClgPrize)

	self._clgBtnCol_btnClg2_bubble_txt.text = string.format("通关获得%s", matName)
end

function DivineXiuErClgMainView:_onUpdate()
	local enterResult = DivineXiuErClgController.instance:getTryEnterNorClgResultAndTips(self._activityId)
	local prizeResult, tips = DivineXiuErClgController.instance:getTryGetPrizeNorClgResultAndTips(self._activityId)

	GameUtil.SetActive(self._clgBtnCol_btnClg1_imgPass, enterResult == GameEnum.ResultCode.IsPass)
	GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble_imgHasGain, prizeResult == GameEnum.ResultCode.IsHasGain)
	GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble_btnGain, prizeResult == GameEnum.ResultCode.Success)
	UIEffectManager.instance:stopEffect(self._effOfBtnClg1Bubble)

	self._effOfBtnClg1Bubble = nil

	if prizeResult == GameEnum.ResultCode.Success then
		local effectParent = self._clgBtnCol_btnClg1_bubble_itemcell
		local clippParent = self._clgBtnCol_btnClg1_bubble_effRoot
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setClipping(clippParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._effOfBtnClg1Bubble = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end

	local enterResult = DivineXiuErClgController.instance:getTryEnterExtClgResultAndTips(self._activityId)
	local prizeResult, tips = DivineXiuErClgController.instance:getTryGetPrizeExtClgResultAndTips(self._activityId)

	GameUtil.SetActive(self._clgBtnCol_btnClg2_imgPass, enterResult == GameEnum.ResultCode.IsPass)
	GameUtil.SetActive(self._clgBtnCol_btnClg2_bubble_imgHasGain, prizeResult == GameEnum.ResultCode.IsHasGain)
	GameUtil.SetActive(self._clgBtnCol_btnClg2_bubble_btnGain, prizeResult == GameEnum.ResultCode.Success)
	UIEffectManager.instance:stopEffect(self._effOfBtnClg2Bubble)

	self._effOfBtnClg2Bubble = nil

	if prizeResult == GameEnum.ResultCode.Success then
		local effectParent = self._clgBtnCol_btnClg2_bubble_itemcell
		local clippParent = self._clgBtnCol_btnClg2_bubble_effRoot
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setClipping(clippParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._effOfBtnClg2Bubble = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end
end

function DivineXiuErClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineXiuErClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineXiuErClgMainView:_getRaceId()
	return DivineXiuErClgController.instance:getRaceId(self._activityId)
end

function DivineXiuErClgMainView:_getSkinId()
	return DivineXiuErClgController.instance:getSkinId(self._activityId)
end

function DivineXiuErClgMainView:_regRedPoint(redGo, redIdList)
	if #redIdList > 0 and not goutil.isNil(redGo) then
		RedPointController.instance:regRedPoint(redGo, unpack(redIdList))

		self._redGoPool[redGo] = redGo
	end
end

function DivineXiuErClgMainView:_unRegAllRedPoint()
	for k, v in pairs(self._redGoPool) do
		RedPointController.instance:unregRedPoint(v)
	end

	table.clear(self._redGoPool)
end

function DivineXiuErClgMainView:_onClickBtnJump(key)
	local jumpToStr = DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function DivineXiuErClgMainView:_onClickBtnClg1()
	local result, tips = DivineXiuErClgController.instance:getTryEnterNorClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DivineXiuErClgNorView, self._activityId)
end

function DivineXiuErClgMainView:_onClickBtnClg2()
	local result, tips = DivineXiuErClgController.instance:getTryEnterExtClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DivineXiuErClgExtView, self._activityId)
end

function DivineXiuErClgMainView:_onClickBtnClg1BubbleBtnGain()
	local result, tips = DivineXiuErClgController.instance:getTryGetPrizeNorClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DivineXiuErClgController.instance:sendPM_DivineXiuErGainNormalClgPrizeReq(self._activityId)
end

function DivineXiuErClgMainView:_onClickBtnClg2BubbleBtnGain()
	local result, tips = DivineXiuErClgController.instance:getTryGetPrizeExtClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DivineXiuErClgController.instance:sendPM_DivineXiuErGainExtremeClgPrizeReq(self._activityId)
end

function DivineXiuErClgMainView:_onClickBtnTip()
	local key = DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return DivineXiuErClgMainView
