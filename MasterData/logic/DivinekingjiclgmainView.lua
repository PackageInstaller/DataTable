-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgmainView.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgmainView", package.seeall)

local DivinekingjiclgmainView = class("DivinekingjiclgmainView", ViewComponent)

function DivinekingjiclgmainView:buildUI()
	DivinekingjiclgmainView.super.buildUI(self)

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
	self._btnClg = self:getBtn("btnClg")
	self._passGo = self:getGo("btnClg/passGo")
end

function DivinekingjiclgmainView:bindEvents()
	DivinekingjiclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	self._btnClg:AddClickListener(self._onClickbtnClg, self)
end

function DivinekingjiclgmainView:unbindEvents()
	DivinekingjiclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	self._btnClg:RemoveClickListener()
end

function DivinekingjiclgmainView:onEnter()
	DivinekingjiclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineKingJiClgGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = DivinekingjiclgConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	DivineKingJiClgAgent.instance:sendPM_DivineKingJiClgGetInfoReq(self._activityId)
	DivinekingjiclgController.instance:tryShowChangeSetId()
end

function DivinekingjiclgmainView:onExit()
	DivinekingjiclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DivinekingjiclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function DivinekingjiclgmainView:_updateUI()
	local info = DivinekingjiclgModel.instance:getInfo(self._activityId)
	local stageCfgs = DivinekingjiclgConfig.instance:getStageCfgs(self._activityId)
	local isAllPass = info.curPassStageId >= #stageCfgs

	goutil.setActive(self._passGo, isAllPass)
end

function DivinekingjiclgmainView:_onClickBtnSkill()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattleWithSkinId(skinId)
end

function DivinekingjiclgmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivinekingjiclgmainView:_onClickbtnClg()
	if DivinekingjiclgController:isClgPass(self._activityId) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivinekingjiclgstageView, self._activityId)
end

function DivinekingjiclgmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivinekingjiclgmainView:_getSkinId()
	return DivinekingjiclgConfig.instance:getSkinId(self._activityId)
end

function DivinekingjiclgmainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivinekingjiclgmainView:_onClickBtnTip()
	local challengeCfg = DivinekingjiclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivinekingjiclgmainView:_initActivityId()
	self._activityType = GameEnum.ActivityType.DivineKingJiClg
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineKingJiClg)
	end
end

return DivinekingjiclgmainView
