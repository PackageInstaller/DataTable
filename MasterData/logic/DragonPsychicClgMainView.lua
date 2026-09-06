-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgMainView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgMainView", package.seeall)

local DragonPsychicClgMainView = class("DragonPsychicClgMainView", ViewComponent)

function DragonPsychicClgMainView:ctor()
	DragonPsychicClgMainView.super.ctor(self)

	self._redGoPool = {}
end

function DragonPsychicClgMainView:buildUI()
	DragonPsychicClgMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._txtOpenTimeGo = goutil.findChild(self.mainGO, "txtOpenTime")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._redJum3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._redJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._redJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnBtnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._redClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._imgPassClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/imgPass")
	self._btnBtnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._redClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._imgPassClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/imgPass")
end

function DragonPsychicClgMainView:bindEvents()
	DragonPsychicClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnBtnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnBtnClg2, self._onClickBtnClg2, self)
end

function DragonPsychicClgMainView:unbindEvents()
	DragonPsychicClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnBtnClg1)
	GameUtil.rmClickHandler(self._btnBtnClg2)
end

function DragonPsychicClgMainView:onEnter()
	DragonPsychicClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DragonPsychicClgController.instance:getActivityId()
	end

	self._activityType = DragonPsychicClgController.instance:getActivityType()

	local isInTime = DragonPsychicClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DragonPsychicClgConfig.instance:getDpcData(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.handlePM_DPClgGetUniversalInfoRes, self._onUpdate, self)

	if not self._isAoqiGodProcessType then
		DragonPsychicClgController.instance:sendPM_DPClgGetUniversalInfoReq(self._activityId)
	end
end

function DragonPsychicClgMainView:onExit()
	DragonPsychicClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	UIEffectManager.instance:stopEffect(self._effOfBtnClg1Bubble)

	self._effOfBtnClg1Bubble = nil

	self:_unRegAllRedPoint()
end

function DragonPsychicClgMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local redInfoList = {}

	table.insert(redInfoList, {
		{
			DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "jumpRedIdOne")
		},
		self._redJum3
	})
	table.insert(redInfoList, {
		{
			DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "jumpRedIdTwo")
		},
		self._redJump2
	})
	table.insert(redInfoList, {
		{
			DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "jumpRedIdThree")
		},
		self._redJump3
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

	goutil.setActive(self._btnBtnClg1.gameObject, not self._isAoqiGodProcessType)
	goutil.setActive(self._btnJump1.gameObject, not self._isAoqiGodProcessType)
	goutil.setActive(self._btnJump2.gameObject, not self._isAoqiGodProcessType)
	goutil.setActive(self._btnJump3.gameObject, not self._isAoqiGodProcessType)
	goutil.setActive(self._txtOpenTimeGo, not self._isAoqiGodProcessType)
end

function DragonPsychicClgMainView:_onUpdate()
	local isPassAll = DragonPsychicClgController.instance:isAllStagePassOfNor(self._activityId)

	GameUtil.SetActive(self._imgPassClg1, isPassAll)
end

function DragonPsychicClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DragonPsychicClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DragonPsychicClgMainView:_getRaceId()
	return DragonPsychicClgController.instance:getRaceId(self._activityId)
end

function DragonPsychicClgMainView:_getSkinId()
	return DragonPsychicClgController.instance:getSkinId(self._activityId)
end

function DragonPsychicClgMainView:_regRedPoint(redGo, redIdList)
	if #redIdList > 0 and not goutil.isNil(redGo) then
		RedPointController.instance:regRedPoint(redGo, unpack(redIdList))

		self._redGoPool[redGo] = redGo
	end
end

function DragonPsychicClgMainView:_unRegAllRedPoint()
	for k, v in pairs(self._redGoPool) do
		RedPointController.instance:unregRedPoint(v)
	end

	table.clear(self._redGoPool)
end

function DragonPsychicClgMainView:_onClickBtnJump(key)
	local jumpToStr = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function DragonPsychicClgMainView:_onClickBtnClg1()
	local result, tips = DragonPsychicClgController.instance:getTryEnterDpcNormalViewResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DragonPsychicClgNormalView, self._activityId)
end

function DragonPsychicClgMainView:_onClickBtnClg1BubbleBtnGain()
	return
end

function DragonPsychicClgMainView:_onClickBtnClg2()
	local result, tips = DragonPsychicClgController.instance:getTryEnterDpcExtViewResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.DragonPsychicClgExtView, self._activityId)
end

function DragonPsychicClgMainView:_onClickBtnTip()
	local key = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return DragonPsychicClgMainView
