-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenMainView.lua

module("logic.extensions.divinejieshen.view.DivineJieShenMainView", package.seeall)

local DivineJieShenMainView = class("DivineJieShenMainView", ViewComponent)

function DivineJieShenMainView:ctor()
	DivineJieShenMainView.super.ctor(self)
end

function DivineJieShenMainView:buildUI()
	DivineJieShenMainView.super.buildUI(self)

	self._btnClg1 = goutil.findChild(self.mainGO, "btnClg1/btn")
	self._btnClg2 = goutil.findChild(self.mainGO, "btnClg2/btn")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._con = goutil.findChild(self.mainGO, "con")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._itemcellClg1 = goutil.findChild(self.mainGO, "btnClg1/bubble/itemcell")
	self._imgHasGainClg1 = goutil.findChild(self.mainGO, "btnClg1/bubble/imgHasGain")
	self._itemcellClg2 = goutil.findChild(self.mainGO, "btnClg2/bubble/itemcell")
	self._imgHasGainClg2 = goutil.findChild(self.mainGO, "btnClg2/bubble/imgHasGain")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
end

function DivineJieShenMainView:bindEvents()
	DivineJieShenMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineJieShenMainView:unbindEvents()
	DivineJieShenMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineJieShenMainView:onEnter()
	DivineJieShenMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineJieShenController.instance:getActivityId()
	end

	self._activityType = DivineJieShenController.instance:getActivityType()

	local isInTime = DivineJieShenController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._divineJieShenMo = DivineJieShenModel.instance:getDivineJieShenMo(self._activityId)
	self._actData = DivineJieShenConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgGetInfoRes, self._onUpdate, self)
	DivineJieShenController.instance:sendPM_DivineJieShenClgGetInfoReq(self._activityId)
end

function DivineJieShenMainView:onExit()
	DivineJieShenMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellClg1)
	MaterialMgr.resetAll(self._itemcellClg2)
end

function DivineJieShenMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	MaterialMgr.setCellByCfg(self._actData.normalPassPrize, self._itemcellClg1)
	MaterialMgr.setCellByCfg(self._actData.extremePassPrize, self._itemcellClg2)
end

function DivineJieShenMainView:_onUpdate()
	local isPass = self._divineJieShenMo:isPassBossInNor()

	if isPass then
		local key = string.format("DivineJieShenNorPass_" .. self._activityId)
		local isNotFirst = GameUtil.getUserData(key)

		if not isNotFirst then
			GameUtil.saveUserData(key, true)
			UIStateManager.instance:push(ViewName.DivineSuccessView)
		end
	end

	GameUtil.SetActive(self._imgHasGainClg1, self._divineJieShenMo:isPassBossInNor())
	GameUtil.SetActive(self._imgHasGainClg2, self._divineJieShenMo:isPassAllInExt())
end

function DivineJieShenMainView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.DivineJieShenNorView, self._activityId)
end

function DivineJieShenMainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.DivineJieShenExtView, self._activityId)
end

function DivineJieShenMainView:_onJumpBtnClg(key)
	local btnStr = DivineJieShenConfig.instance:getCommonValue(self._activityId, key)

	GotoMgr.gotoByString(btnStr)
end

function DivineJieShenMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineJieShenMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineJieShenMainView:_getRaceId()
	return DivineJieShenController.instance:getRaceId(self._activityId)
end

function DivineJieShenMainView:_getSkinId()
	return DivineJieShenController.instance:getSkinId(self._activityId)
end

function DivineJieShenMainView:_onClickBtnTip()
	local key = DivineJieShenConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return DivineJieShenMainView
