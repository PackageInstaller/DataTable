-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonmainView.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonmainView", package.seeall)

local DivinesuperdragonmainView = class("DivinesuperdragonmainView", ViewComponent)

function DivinesuperdragonmainView:buildUI()
	DivinesuperdragonmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTimeGo = goutil.findChild(self.mainGO, "txtTime")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")
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
	self._clgBtnCol = goutil.findChild(self.mainGO, "clgBtnCol")
	self._clgBtnCol_btnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1")
	self._clgBtnCol_btnClg1_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._clgBtnCol_btnClg1_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._clgBtnCol_btnClg1_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/imgPass")
	self._clgBtnCol_btnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2")
	self._clgBtnCol_btnClg2_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._clgBtnCol_btnClg2_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._clgBtnCol_btnClg2_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/imgPass")
	self._bubble = self:getGo("clgBtnCol/bubble")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
end

function DivinesuperdragonmainView:bindEvents()
	DivinesuperdragonmainView.super.bindEvents(self)
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
end

function DivinesuperdragonmainView:unbindEvents()
	DivinesuperdragonmainView.super.unbindEvents(self)
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
end

function DivinesuperdragonmainView:onEnter()
	DivinesuperdragonmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineSuperDragonClgGetInfoRes, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivinesuperdragonController.instance:getActivityId()
	end

	self._activityType = DivinesuperdragonController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actCfg = DivinesuperdragonConfig.instance:getActCfg(self._activityId)

	self:_initAoqiGodUI()
	self:_setActTime()
	self:_setRole()
	self:_updateUI()
	DivineSuperDragonClgAgent.instance:sendPM_DivineSuperDragonClgGetInfoReq(self._activityId)
end

function DivinesuperdragonmainView:_initAoqiGodUI()
	GameUtil.SetActive(self._txtTimeGo.gameObject, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._bubble, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
end

function DivinesuperdragonmainView:onExit()
	DivinesuperdragonmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
end

function DivinesuperdragonmainView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivinesuperdragonmainView:_setRole()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function DivinesuperdragonmainView:_updateUI()
	self:_updateSuperBubble()
end

function DivinesuperdragonmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivinesuperdragonmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivinesuperdragonmainView:_getRaceId()
	return DivinesuperdragonController.instance:getRaceId(self._activityId)
end

function DivinesuperdragonmainView:_getSkinId()
	return DivinesuperdragonConfig.instance:getSkinId(self._activityId)
end

function DivinesuperdragonmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivinesuperdragonmainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineSuperDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.DivinesuperdragonsuperstageView, self._activityId)
end

function DivinesuperdragonmainView:_onClickBtnClg2()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineSuperDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.DivinesuperdragonbuffstageView, self._activityId)
end

function DivinesuperdragonmainView:_onClickBtnTip()
	local key = DivinesuperdragonConfig.instance:getRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function DivinesuperdragonmainView:_updateSuperBubble()
	if not self._isAoqiGodProcessType then
		MaterialMgr.resetAll(self._itemcellGo)
		goutil.setActive(self._imgHasGainGo, false)
		MaterialMgr.setCellByCfg("4:510259:100", self._itemcellGo)
	end
end

return DivinesuperdragonmainView
