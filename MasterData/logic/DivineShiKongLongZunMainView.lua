-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/view/DivineShiKongLongZunMainView.lua

module("logic.extensions.divineshikonglongzunmainview.view.DivineShiKongLongZunMainView", package.seeall)

local DivineShiKongLongZunMainView = class("DivineShiKongLongZunMainView", ViewComponent)

function DivineShiKongLongZunMainView:ctor()
	DivineShiKongLongZunMainView.super.ctor(self)
end

function DivineShiKongLongZunMainView:buildUI()
	DivineShiKongLongZunMainView.super.buildUI(self)

	self._btnClg = goutil.findChild(self.mainGO, "btnClg/btn")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnInfo")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._openTimeGo = self:getGo("txtOpenTime")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	self:_recordGoDefaultActive(self._openTimeGo)
	self:_recordGoDefaultActive(self._txtOpenTime.gameObject)
	self:_recordGoDefaultActive(self._jumpBtnCol)
end

function DivineShiKongLongZunMainView:bindEvents()
	DivineShiKongLongZunMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function DivineShiKongLongZunMainView:unbindEvents()
	DivineShiKongLongZunMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function DivineShiKongLongZunMainView:onEnter()
	DivineShiKongLongZunMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineShiKongLongZunController.instance:getActivityId()
	end

	local isInTime = DivineShiKongLongZunController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._openTimeGo, false)
		GameUtil.SetActive(self._txtOpenTime.gameObject, false)
		GameUtil.SetActive(self._jumpBtnCol, false)
	else
		self:_refreshDefaultActive(self._btnChallenge_1)
		self:_refreshDefaultActive(self._jumpBtnCol)
	end

	self:_onSetUI()
end

function DivineShiKongLongZunMainView:onExit()
	DivineShiKongLongZunMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function DivineShiKongLongZunMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = DivineShiKongLongZunController.instance:getSkinId(self._activityId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function DivineShiKongLongZunMainView:_onUpdate()
	return
end

function DivineShiKongLongZunMainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.DivineShiKongLongZunLevelView, self._activityId)
end

function DivineShiKongLongZunMainView:_onJumpBtnClg(key)
	local btnStr = DivineShiKongLongZunConfig.instance:getCommonValue(self._activityId, key)

	GotoMgr.gotoByString(btnStr)
end

function DivineShiKongLongZunMainView:_onClickBtnTip()
	local key = DivineShiKongLongZunConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function DivineShiKongLongZunMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineShiKongLongZunMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineShiKongLongZunMainView:_getRaceId()
	return DivineShiKongLongZunController.instance:getRaceId(self._activityId)
end

function DivineShiKongLongZunMainView:_getSkinId()
	return DivineShiKongLongZunController.instance:getSkinId(self._activityId)
end

function DivineShiKongLongZunMainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineShiKongLongZunMainView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return DivineShiKongLongZunMainView
