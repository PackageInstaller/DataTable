-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/view/KingIsaacClgMainView.lua

module("logic.extensions.kingisaacclg.view.KingIsaacClgMainView", package.seeall)

local KingIsaacClgMainView = class("KingIsaacClgMainView", ViewComponent)

function KingIsaacClgMainView:ctor()
	KingIsaacClgMainView.super.ctor(self)

	self._redGoPool = {}
end

function KingIsaacClgMainView:buildUI()
	KingIsaacClgMainView.super.buildUI(self)

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
	self._clgBtnCol_btnClg1_bubble_imgHasGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/imgHasGain")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
	self._clgBtnCol_btnClg1_bubble_btnGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/btnGain")
	self._clgBtnCol_btnClg1_bubble_effRoot = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/effRoot")
end

function KingIsaacClgMainView:bindEvents()
	KingIsaacClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_bubble_btnGain, self._onClickBtnClg1BubbleBtnGain, self)
end

function KingIsaacClgMainView:unbindEvents()
	KingIsaacClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_bubble_btnGain)
end

function KingIsaacClgMainView:onEnter()
	KingIsaacClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KingIsaacClgController.instance:getActivityId()
	end

	self._activityType = KingIsaacClgController.instance:getActivityType()

	local isInTime = KingIsaacClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = KingIsaacClgConfig.instance:getKicActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.handlePM_KingIsaacClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifyKingIsaacClgChallengeEndRes, self._onUpdate, self)
	KingIsaacClgController.instance:sendPM_KingIsaacClgInfoReq(self._activityId)
end

function KingIsaacClgMainView:onExit()
	KingIsaacClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	UIEffectManager.instance:stopEffect(self._effOfBtnClg1Bubble)

	self._effOfBtnClg1Bubble = nil

	self:_unRegAllRedPoint()
end

function KingIsaacClgMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local redInfoList = {}

	table.insert(redInfoList, {
		{
			KingIsaacClgConfig.instance:getKicCommonValue(self._activityId, "jumpRedIdOne")
		},
		self._jumpBtnCol_btnJump1_redPoint
	})
	table.insert(redInfoList, {
		{
			KingIsaacClgConfig.instance:getKicCommonValue(self._activityId, "jumpRedIdTwo")
		},
		self._jumpBtnCol_btnJump2_redPoint
	})
	table.insert(redInfoList, {
		{
			KingIsaacClgConfig.instance:getKicCommonValue(self._activityId, "jumpRedIdThree")
		},
		self._jumpBtnCol_btnJump3_redPoint
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
end

function KingIsaacClgMainView:_onUpdate()
	local isPassAll = KingIsaacClgController.instance:isHasPassAllStage(self._activityId)

	GameUtil.SetActive(self._clgBtnCol_btnClg1_imgPass, isPassAll)
end

function KingIsaacClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KingIsaacClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KingIsaacClgMainView:_getRaceId()
	return KingIsaacClgController.instance:getRaceId(self._activityId)
end

function KingIsaacClgMainView:_getSkinId()
	return KingIsaacClgController.instance:getSkinId(self._activityId)
end

function KingIsaacClgMainView:_regRedPoint(redGo, redIdList)
	if #redIdList > 0 and not goutil.isNil(redGo) then
		RedPointController.instance:regRedPoint(redGo, unpack(redIdList))

		self._redGoPool[redGo] = redGo
	end
end

function KingIsaacClgMainView:_unRegAllRedPoint()
	for k, v in pairs(self._redGoPool) do
		RedPointController.instance:unregRedPoint(v)
	end

	table.clear(self._redGoPool)
end

function KingIsaacClgMainView:_onClickBtnJump(key)
	local jumpToStr = KingIsaacClgConfig.instance:getKicCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function KingIsaacClgMainView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.KingIsaacClgStageView, self._activityId)
end

function KingIsaacClgMainView:_onClickBtnClg1BubbleBtnGain()
	return
end

function KingIsaacClgMainView:_onClickBtnTip()
	local key = KingIsaacClgConfig.instance:getKicCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return KingIsaacClgMainView
