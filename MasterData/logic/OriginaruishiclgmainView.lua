-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/view/OriginaruishiclgmainView.lua

module("logic.extensions.originaruishiclg.view.OriginaruishiclgmainView", package.seeall)

local OriginaruishiclgmainView = class("OriginaruishiclgmainView", ViewComponent)

function OriginaruishiclgmainView:buildUI()
	OriginaruishiclgmainView.super.buildUI(self)

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
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._rdBuff = self:getGo("buffCol/cell/rd")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
end

function OriginaruishiclgmainView:bindEvents()
	OriginaruishiclgmainView.super.bindEvents(self)
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

function OriginaruishiclgmainView:unbindEvents()
	OriginaruishiclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnGainBuff)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function OriginaruishiclgmainView:onEnter()
	OriginaruishiclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginAruishiClgGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.RoseClgUpgradeBuffRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = OriginaruishiclgConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	OriginAruishiClgAgent.instance:sendPM_OriginAruishiClgGetInfoReq(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OriginaruishiclgmainView:onExit()
	OriginaruishiclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginaruishiclgmainView:_getRaceId()
	return self._actCfg.raceId
end

function OriginaruishiclgmainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function OriginaruishiclgmainView:_onClickBtnClg()
	local info = OriginaruishiclgModel.instance:getInfo(self._activityId)
	local cfgs = OriginaruishiclgConfig.instance:getStageCfgs(self._activityId)

	if #info.stageId >= #cfgs then
		FloatWordMgr.instance:show("已通过全部关卡")

		return
	end

	UIStateManager.instance:push(ViewName.OriginaruishiclgstageView, self._activityId)
end

function OriginaruishiclgmainView:_onClickBtnTip()
	local challengeCfg = OriginaruishiclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginaruishiclgmainView:_updateUI()
	self._info = OriginaruishiclgModel.instance:getInfo(self._activityId)
end

function OriginaruishiclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function OriginaruishiclgmainView:_updateBuffUI(param)
	GameUtil.SetActive(self._rdBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

function OriginaruishiclgmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginaruishiClg)
	end
end

function OriginaruishiclgmainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function OriginaruishiclgmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

return OriginaruishiclgmainView
