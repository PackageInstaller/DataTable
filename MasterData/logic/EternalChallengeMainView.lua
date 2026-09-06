-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/EternalChallengeMainView.lua

module("logic.extensions.eternalchallenge.view.EternalChallengeMainView", package.seeall)

local EternalChallengeMainView = class("EternalChallengeMainView", ViewComponent)

function EternalChallengeMainView:buildUI()
	EternalChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = {}

	if self._jumpBtnCol then
		local mainGo = goutil.findChild(self.mainGO, "jumpBtnCol")

		self._jumpBtnCol._mainGo = mainGo
		self._jumpBtnCol._btnJump1 = {}
		self._jumpBtnCol._btnJump1._mainGo = goutil.findChild(mainGo, "btnJump1")
		self._jumpBtnCol._btnJump1._redPoint = goutil.findChild(mainGo, "btnJump1/redPoint")
		self._jumpBtnCol._btnJump2 = {}
		self._jumpBtnCol._btnJump2._mainGo = goutil.findChild(mainGo, "btnJump2")
		self._jumpBtnCol._btnJump2._redPoint = goutil.findChild(mainGo, "btnJump2/redPoint")
		self._jumpBtnCol._btnJump3 = {}
		self._jumpBtnCol._btnJump3._mainGo = goutil.findChild(mainGo, "btnJump3")
		self._jumpBtnCol._btnJump3._redPoint = goutil.findChild(mainGo, "btnJump3/redPoint")
	end

	self._clgBtnCol = {}

	if self._clgBtnCol then
		local mainGo = goutil.findChild(self.mainGO, "clgBtnCol")

		self._clgBtnCol._mainGo = mainGo
		self._clgBtnCol._btnClg1 = {}
		self._clgBtnCol._btnClg1._mainGo = goutil.findChild(mainGo, "btnClg1")
		self._clgBtnCol._btnClg1._btn = goutil.findChild(mainGo, "btnClg1/btn")
		self._clgBtnCol._btnClg1._redPoint = goutil.findChild(mainGo, "btnClg1/btn/redPoint")
		self._clgBtnCol._btnClg2 = {}
		self._clgBtnCol._btnClg2._mainGo = goutil.findChild(mainGo, "btnClg2")
		self._clgBtnCol._btnClg2._btn = goutil.findChild(mainGo, "btnClg2/btn")
		self._clgBtnCol._btnClg2._redPoint = goutil.findChild(mainGo, "btnClg2/btn/redPoint")
		self._clgBtnCol._btnClg2._txtDesc = goutil.findChildTextComponent(mainGo, "btnClg2/desc/txt")
	end
end

function EternalChallengeMainView:bindEvents()
	EternalChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol._btnJump1._mainGo, GameUtil.handler(self._onClickBtnJump, self, "ETERNALCHALLENGE_JUMP_KEY_1"))
	GameUtil.addClickHandler(self._jumpBtnCol._btnJump2._mainGo, GameUtil.handler(self._onClickBtnJump, self, "ETERNALCHALLENGE_JUMP_KEY_2"))
	GameUtil.addClickHandler(self._jumpBtnCol._btnJump3._mainGo, GameUtil.handler(self._onClickBtnJump, self, "ETERNALCHALLENGE_JUMP_KEY_3"))
	GameUtil.addClickHandler(self._clgBtnCol._btnClg1._btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol._btnClg2._btn, self._onClickBtnClg2, self)
end

function EternalChallengeMainView:unbindEvents()
	EternalChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol._btnJump1._mainGo)
	GameUtil.rmClickHandler(self._jumpBtnCol._btnJump2._mainGo)
	GameUtil.rmClickHandler(self._jumpBtnCol._btnJump3._mainGo)
	GameUtil.rmClickHandler(self._clgBtnCol._btnClg1._btn)
	GameUtil.rmClickHandler(self._clgBtnCol._btnClg2._btn)
end

function EternalChallengeMainView:onEnter()
	EternalChallengeMainView.super.onEnter(self)

	self._activityId = EternalChallengeController.instance:getActivityId()
	self._activityType = EternalChallengeController.instance:getActivityType()

	local isInTime = EternalChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.EternalChallengeInfoRes, self._onUpdate, self)
	EternalChallengeController.instance:sendPM_EternalChallengeInfoReq(self._activityId)
end

function EternalChallengeMainView:onExit()
	EternalChallengeMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol._btnJump1._redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol._btnJump2._redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol._btnJump3._redPoint)
	RedPointController.instance:unregRedPoint(self._clgBtnCol._btnClg1._redPoint)
end

function EternalChallengeMainView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	end

	local redId = EternalChallengeConfig.instance:getEcClientCommonValue(self._activityId, "ETERNALCHALLENGE_JUMP_RED_1")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol._btnJump1._redPoint, redId)
	end

	local redId = EternalChallengeConfig.instance:getEcClientCommonValue(self._activityId, "ETERNALCHALLENGE_JUMP_RED_2")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol._btnJump2._redPoint, redId)
	end

	local redId = EternalChallengeConfig.instance:getEcClientCommonValue(self._activityId, "ETERNALCHALLENGE_JUMP_RED_3")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol._btnJump3._redPoint, redId)
	end

	local redIdList = {
		RedPointModel.ID_ETERNAL_CHALLENGE_PET,
		RedPointModel.ID_ETERNAL_CHALLENGE_BUFF
	}

	RedPointController.instance:regRedPoint(self._clgBtnCol._btnClg1._redPoint, unpack(redIdList))

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function EternalChallengeMainView:_onUpdate()
	local dmg = EternalChallengeController.instance:getMaxDamage()

	self._clgBtnCol._btnClg2._txtDesc.text = string.format("最高伤害%s", dmg)
end

function EternalChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function EternalChallengeMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function EternalChallengeMainView:_getRaceId()
	return EternalChallengeController.instance:getRaceId(self._activityId)
end

function EternalChallengeMainView:_getSkinId()
	return EternalChallengeController.instance:getSkinId(self._activityId)
end

function EternalChallengeMainView:_onClickBtnJump(key)
	local jumpToStr = EternalChallengeConfig.instance:getEcClientCommonValue(self._activityId, key, false)

	GotoMgr.gotoByString(jumpToStr)
end

function EternalChallengeMainView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.EternalChallengeShopView)
end

function EternalChallengeMainView:_onClickBtnClg2()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.EternalChallengeMainView)
	EternalChallengeController.instance:enterBattleAsEternalChallenge(self._activityId)
end

function EternalChallengeMainView:_onClickBtnTip()
	local key = EternalChallengeConfig.instance:getEcClientCommonValue(self._activityId, "ETERNALCHALLENGE_RULE_MAIN_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return EternalChallengeMainView
