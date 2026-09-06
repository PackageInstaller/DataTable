-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/view/RoseclgmainView.lua

module("logic.extensions.roseclg.view.RoseclgmainView", package.seeall)

local RoseclgmainView = class("RoseclgmainView", ViewComponent)

function RoseclgmainView:buildUI()
	RoseclgmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
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
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._buffRoot = self:getGo("buffRoot")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
end

function RoseclgmainView:bindEvents()
	RoseclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
end

function RoseclgmainView:unbindEvents()
	RoseclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function RoseclgmainView:onEnter()
	RoseclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoseClgGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = RoseclgConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	RoseClgAgent.instance:sendPM_RoseClgGetInfoReq(self._activityId)
end

function RoseclgmainView:onExit()
	RoseclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function RoseclgmainView:_getRaceId()
	return self._actCfg.raceId
end

function RoseclgmainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function RoseclgmainView:_onClickBtnClg()
	local info = RoseclgModel.instance:getInfo(self._activityId)
	local cfgs = RoseclgConfig.instance:getStageCfgs(self._activityId)

	if info.curPassStageId >= #cfgs then
		FloatWordMgr.instance:show("已通过全部关卡")

		return
	end

	UIStateManager.instance:push(ViewName.RoseclgstageView, self._activityId)
end

function RoseclgmainView:_onClickBtnTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(195)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function RoseclgmainView:_updateUI()
	self._info = RoseclgModel.instance:getInfo(self._activityId)
end

function RoseclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function RoseclgmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.RoseClg)
	end
end

function RoseclgmainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function RoseclgmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

return RoseclgmainView
